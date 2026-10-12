#requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Root,
    [string[]]$Packages,
    [switch]$NonInteractive,
    [switch]$DetectOnly,
    [switch]$LibraryOnly,
    [string]$SourceRoot,
    [string]$Commit,
    [switch]$KeepOtherScripts
)

# One release repository. Usage (PowerShell):
#   irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1 | iex
$script:RuntimeRepository = 'LeeHarveyOsward/AyyyyIO'
$script:RuntimeAgent = 'ayyyyio-installer'

function Get-RuntimeHash([byte[]]$Bytes) {
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash($Bytes))).Replace('-', '').ToLowerInvariant() }
    finally { $sha.Dispose() }
}

function Write-RuntimeJson([string]$Path, $Value) {
    $text = ConvertTo-Json -InputObject $Value -Depth 20
    $temporary = $Path + '.' + [guid]::NewGuid().ToString('N') + '.tmp'
    try {
        [IO.File]::WriteAllText($temporary, $text + "`n", (New-Object Text.UTF8Encoding($false)))
        Set-RuntimeFile $temporary $Path
    } finally { if ([IO.File]::Exists($temporary)) { [IO.File]::Delete($temporary) } }
}

function Assert-RuntimeRelative([string]$Path) {
    if ([string]::IsNullOrWhiteSpace($Path) -or $Path -match '[\\:]' -or $Path.StartsWith('/')) {
        throw "Invalid relative path: $Path"
    }
    foreach ($part in $Path.Split('/')) {
        if (!$part -or $part -in @('.', '..') -or $part -match '[<>"|?*\x00-\x1f]' -or
            $part -match '[. ]$' -or $part -match '^(?i:CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(?:\.|$)') {
            throw "Invalid path component: $Path"
        }
    }
}

function Get-RuntimePath([string]$Base, [string]$Relative) {
    Assert-RuntimeRelative $Relative
    $basePath = [IO.Path]::GetFullPath($Base).TrimEnd('\', '/')
    $path = [IO.Path]::GetFullPath((Join-Path $basePath $Relative))
    if (!$path.StartsWith($basePath + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Path escapes installation: $Relative"
    }
    $current = $path
    while ($current) {
        if (Test-Path -LiteralPath $current) {
            if ((Get-Item -LiteralPath $current -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "Linked paths are not supported: $current"
            }
        }
        $parent = [IO.Path]::GetDirectoryName($current)
        if ($parent -eq $current) { break }
        $current = $parent
    }
    return $path
}

function Get-RuntimeProcessPath([int]$ProcessId) {
    if ($ProcessId -le 0 -or $script:RuntimeProcessQueryUnavailable) { return $null }
    try {
        if (!('RuntimeFiles.InstallerProcessPath' -as [type])) {
            Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
using System.Text;
namespace RuntimeFiles {
    public static class InstallerProcessPath {
        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr OpenProcess(uint access, bool inherit, int processId);
        [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        private static extern bool QueryFullProcessImageNameW(IntPtr process, uint flags,
            StringBuilder name, ref uint size);
        [DllImport("kernel32.dll")]
        private static extern bool CloseHandle(IntPtr handle);
        public static string Read(int processId) {
            // PROCESS_QUERY_LIMITED_INFORMATION, no memory access or elevation.
            IntPtr handle = OpenProcess(0x1000, false, processId);
            if (handle == IntPtr.Zero) return null;
            try {
                uint size = 32768;
                var name = new StringBuilder((int)size);
                return QueryFullProcessImageNameW(handle, 0, name, ref size)
                    ? name.ToString() : null;
            } finally { CloseHandle(handle); }
        }
    }
}
'@ -ErrorAction Stop
        }
    } catch {
        $script:RuntimeProcessQueryUnavailable = $true
        Write-Verbose "Native process path query unavailable: $_"
        return $null
    }
    try { return [RuntimeFiles.InstallerProcessPath]::Read($ProcessId) }
    catch { return $null }
}

function Get-RuntimeInstallations($Processes) {
    if ($null -eq $Processes) {
        try { $Processes = @(Get-CimInstance Win32_Process -ErrorAction Stop) }
        catch { $Processes = @() }
        if (!$Processes.Count) {
            $Processes = @([Diagnostics.Process]::GetProcesses() | ForEach-Object {
                try { [pscustomobject]@{ProcessId=$_.Id; ExecutablePath=$null} }
                finally { $_.Dispose() }
            })
        }
    }
    $found = @{}
    foreach ($process in $Processes) {
        try {
            $executable = $process.ExecutablePath
            if (!$executable) { $executable = Get-RuntimeProcessPath $process.ProcessId }
            if (!$executable) { continue }
            $candidate = Join-Path ([IO.Path]::GetDirectoryName($executable)) 'GamingOnSteroids'
            if (Test-Path -LiteralPath (Join-Path $candidate 'LOLEXT/Scripts') -PathType Container) {
                $candidate = [IO.Path]::GetFullPath($candidate)
                $found[$candidate] = $candidate
            }
        } catch { continue }
    }
    return @($found.Values | Sort-Object)
}

function Select-RuntimeRoot([string]$Requested, [bool]$Quiet) {
    if (!$Requested) {
        $candidates = @(Get-RuntimeInstallations)
        if ($candidates.Count -eq 1) { $Requested = $candidates[0] }
        elseif ($Quiet) { throw 'No unique installation found. Specify -Root with the GamingOnSteroids folder.' }
        elseif ($candidates.Count -gt 1) {
            for ($i = 0; $i -lt $candidates.Count; $i++) { Write-Host "[$($i+1)] $($candidates[$i])" }
            $choice = Read-Host 'Choose installation number'
            $index = 0
            if (![int]::TryParse($choice, [ref]$index) -or $index -lt 1 -or $index -gt $candidates.Count) {
                throw 'Invalid installation selection.'
            }
            $Requested = $candidates[$index-1]
        } else {
            Write-Host 'Could not determine the installation folder from running processes. Select the GamingOnSteroids folder.'
            try {
                Add-Type -AssemblyName System.Windows.Forms
                $picker = New-Object Windows.Forms.FolderBrowserDialog
                try {
                    $picker.Description = 'Select your GamingOnSteroids folder'
                    $picker.ShowNewFolderButton = $false
                    if ($picker.ShowDialog() -eq [Windows.Forms.DialogResult]::OK) { $Requested = $picker.SelectedPath }
                } finally { $picker.Dispose() }
            } catch { Write-Host 'Folder picker unavailable.' }
            if (!$Requested) { $Requested = (Read-Host 'GamingOnSteroids folder path (blank cancels)').Trim('"') }
        }
    }
    if (!$Requested) { throw 'Installation cancelled.' }
    $resolved = [IO.Path]::GetFullPath($Requested)
    $scripts = Get-RuntimePath $resolved 'LOLEXT/Scripts'
    if (!(Test-Path -LiteralPath $scripts -PathType Container)) {
        throw "Not an installation: $resolved has no LOLEXT\Scripts directory."
    }
    return $resolved
}

function Get-RuntimeBytes([string]$Relative, [string]$LocalSource, [string]$Revision) {
    Assert-RuntimeRelative $Relative
    if ($LocalSource) { return ,([IO.File]::ReadAllBytes((Get-RuntimePath $LocalSource $Relative))) }
    if ($Revision -notmatch '^[a-f0-9]{40}$') { throw 'A full Git commit is required.' }
    # One archive of the published commit instead of hundreds of single downloads; every file is still
    # checked against manifest.json by the caller. Per-file download remains the fallback.
    if ($Relative -ne 'manifest.json' -and !$script:RuntimeArchiveFailed) {
        if (!$script:RuntimeArchive -or $script:RuntimeArchiveRevision -ne $Revision) {
            try {
                Add-Type -AssemblyName System.IO.Compression
                $archiveClient = New-Object Net.WebClient
                $archiveClient.Headers['User-Agent'] = $script:RuntimeAgent
                try { $zip = $archiveClient.DownloadData("https://codeload.github.com/$($script:RuntimeRepository)/zip/$Revision") }
                finally { $archiveClient.Dispose() }
                $entries = @{}
                $reader = New-Object IO.Compression.ZipArchive((New-Object IO.MemoryStream(,$zip)), [IO.Compression.ZipArchiveMode]::Read)
                try {
                    foreach ($entry in $reader.Entries) {
                        $slash = $entry.FullName.IndexOf('/')
                        if ($slash -lt 0 -or $entry.FullName.EndsWith('/')) { continue }
                        $stream = $entry.Open(); $buffer = New-Object IO.MemoryStream
                        try { $stream.CopyTo($buffer) } finally { $stream.Dispose() }
                        $entries[$entry.FullName.Substring($slash + 1)] = $buffer.ToArray()
                    }
                } finally { $reader.Dispose() }
                $script:RuntimeArchive = $entries; $script:RuntimeArchiveRevision = $Revision
            } catch { $script:RuntimeArchiveFailed = $true; Write-Verbose "Archive download failed, using single files: $_" }
        }
        if ($script:RuntimeArchive -and $script:RuntimeArchive.ContainsKey($Relative)) { return ,([byte[]]$script:RuntimeArchive[$Relative]) }
    }
    $url = "https://raw.githubusercontent.com/$($script:RuntimeRepository)/$Revision/$Relative"
    $client = New-Object Net.WebClient
    $client.Headers['User-Agent'] = $script:RuntimeAgent
    try { return ,($client.DownloadData($url)) } finally { $client.Dispose() }
}

function Resolve-RuntimePackages($Manifest, [string[]]$Requested) {
    if ($Manifest.schema -ne 1 -or $Manifest.repository -ne $script:RuntimeRepository) {
        throw 'Unsupported package manifest.'
    }
    $catalog = @{}
    foreach ($package in $Manifest.packages) {
        if ($package.id -notmatch '^[a-z][a-z0-9-]*$' -or $catalog.ContainsKey($package.id)) { throw 'Invalid or duplicate package ID.' }
        $catalog[$package.id] = $package
    }
    $selected = @{}
    $visiting = @{}
    function Visit-RuntimePackage([string]$Id) {
        if ($selected.ContainsKey($Id)) { return }
        if (!$catalog.ContainsKey($Id)) { throw "Unknown package: $Id" }
        if ($visiting.ContainsKey($Id)) { throw "Dependency cycle: $Id" }
        $visiting[$Id] = $true
        foreach ($dependency in $catalog[$Id].depends) { Visit-RuntimePackage $dependency }
        $visiting.Remove($Id)
        $selected[$Id] = $catalog[$Id]
    }
    foreach ($id in $Requested) { Visit-RuntimePackage $id }
    return @($selected.Values | Sort-Object id)
}

function Assert-RuntimeFamily($Manifest) {
    if (!$Manifest.family) { return }
    $family = $Manifest.family
    if ($family.schema -ne 1 -or $family.api -ne 1 -or $family.generation -notmatch '^[a-f0-9]{64}$') {
        throw 'Incompatible family release.'
    }
    $prefix = 'LOLEXT/Scripts/Common/OrbamaFamily/' + $family.generation + '/'
    $allFiles = @($Manifest.packages | ForEach-Object { $_.files })
    $pointer = @($allFiles | Where-Object { $_.destination -eq 'LOLEXT/Scripts/Common/OrbamaFamily/current' })
    if ($pointer.Count -ne 1) { throw 'Family release must contain one activation selector.' }
    if (!($allFiles | Where-Object { $_.destination -eq ($prefix + 'manifest.lua') })) {
        throw 'Family generation manifest is missing.'
    }
    foreach ($file in $allFiles) {
        if ($file.destination -match '^LOLEXT/Scripts/Common/OrbamaFamily/[a-f0-9]{64}/' -and
            !$file.destination.StartsWith($prefix, [StringComparison]::Ordinal)) {
            throw 'Mixed family generations in one installation.'
        }
    }
}

function Convert-RuntimePackageNames($Manifest, [string[]]$Names) {
    foreach ($name in $Names) {
        $alias = if ($Manifest.packageAliases) { $Manifest.packageAliases.PSObject.Properties[$name] } else { $null }
        if ($alias) { [string]$alias.Value } else { $name }
    }
}

# Registered loader entries that are currently active (ACTIVE other than 0).
function Get-RuntimeActiveScripts([string]$Text) {
    $active = @()
    $headers = [regex]::Matches($Text, '(?m)^[ \t]*\[([^\[\]\\/:\r\n]+\.lua)\][^\r\n]*')
    foreach ($header in $headers) {
        $start = $header.Index + $header.Length
        $next = [regex]::Match($Text.Substring($start), '(?m)^[ \t]*\[')
        $body = if ($next.Success) { $Text.Substring($start, $next.Index) } else { $Text.Substring($start) }
        $setting = [regex]::Match($body, '(?im)^[ \t]*ACTIVE[ \t]*=[ \t]*([^;#\r\n]*)')
        if ($setting.Success -and $setting.Groups[1].Value.Trim() -notin @('', '0')) { $active += $header.Groups[1].Value }
    }
    return @($active | Select-Object -Unique)
}

function Update-RuntimeIni([string]$Text, [string[]]$Enable, [string[]]$Disable) {
    $newline = if ($Text.Contains("`r`n")) { "`r`n" } else { "`n" }
    foreach ($name in @($Enable) + @($Disable)) {
        if (!$name -or $name -notmatch '^[^\[\]\\/:\r\n]+\.lua$') { throw "Invalid loader entry: $name" }
        if ($name -in $Enable -and $name -in $Disable) { throw "Conflicting activation: $name" }
        $pattern = '(?im)^[ \t]*\[' + [regex]::Escape($name) + '\][^\r\n]*(?:\r?\n|$)'
        $matches = [regex]::Matches($Text, $pattern)
        if ($matches.Count -gt 1) { throw "Duplicate loader section: $name" }
        $active = if ($name -in $Enable) { '1' } else { '0' }
        if (!$matches.Count) {
            if ($active -eq '1') {
                if ($Text -and !$Text.EndsWith("`n")) { $Text += $newline }
                $Text += $newline + "[$name]" + $newline + 'ACTIVE = 1' + $newline + 'UPDATE =' + $newline
            }
            continue
        }
        $header = $matches[0]
        $start = $header.Index + $header.Length
        $next = [regex]::Match($Text.Substring($start), '(?m)^[ \t]*\[')
        $length = if ($next.Success) { $next.Index } else { $Text.Length - $start }
        $body = $Text.Substring($start, $length)
        $setting = [regex]::new('(?im)^([ \t]*ACTIVE[ \t]*=[ \t]*)[^;#\r\n]*([;#][^\r\n]*)?')
        if ($setting.Matches($body).Count -gt 1) { throw "Duplicate ACTIVE setting: $name" }
        if ($setting.IsMatch($body)) {
            $body = $setting.Replace($body, [Text.RegularExpressions.MatchEvaluator]{ param($m)
                $suffix = if ($m.Groups[2].Success) { ' ' + $m.Groups[2].Value } else { '' }
                $m.Groups[1].Value + $active + $suffix
            })
        } else { $body = 'ACTIVE = ' + $active + $newline + $body }
        if (!$header.Value.EndsWith("`n")) { $body = $newline + $body }
        $Text = $Text.Substring(0, $start) + $body + $Text.Substring($start + $length)
    }
    return $Text
}

function Read-RuntimeIniText([byte[]]$Bytes) {
    if ($null -eq $Bytes -or !$Bytes.Length) { return '' }
    $offset = 0
    $encoding = New-Object Text.UTF8Encoding($false, $true)
    if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 239 -and $Bytes[1] -eq 187 -and $Bytes[2] -eq 191) { $offset = 3 }
    elseif ($Bytes.Length -ge 2 -and $Bytes[0] -eq 255 -and $Bytes[1] -eq 254) { $encoding = [Text.Encoding]::Unicode; $offset = 2 }
    elseif ($Bytes.Length -ge 2 -and $Bytes[0] -eq 254 -and $Bytes[1] -eq 255) { $encoding = [Text.Encoding]::BigEndianUnicode; $offset = 2 }
    try { return $encoding.GetString($Bytes, $offset, $Bytes.Length - $offset) }
    catch { return [Text.Encoding]::Default.GetString($Bytes) }
}

function Convert-RuntimeIni([byte[]]$Bytes, [string[]]$Enable, [string[]]$Disable) {
    if ($null -eq $Bytes) { $Bytes = [byte[]]@() }
    $offset = 0
    $encoding = New-Object Text.UTF8Encoding($false, $true)
    if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 239 -and $Bytes[1] -eq 187 -and $Bytes[2] -eq 191) {
        $encoding = New-Object Text.UTF8Encoding($true, $true); $offset = 3
    } elseif ($Bytes.Length -ge 2 -and $Bytes[0] -eq 255 -and $Bytes[1] -eq 254) {
        $encoding = [Text.Encoding]::Unicode; $offset = 2
    } elseif ($Bytes.Length -ge 2 -and $Bytes[0] -eq 254 -and $Bytes[1] -eq 255) {
        $encoding = [Text.Encoding]::BigEndianUnicode; $offset = 2
    }
    try { $text = $encoding.GetString($Bytes, $offset, $Bytes.Length - $offset) }
    catch { $encoding = [Text.Encoding]::Default; $text = $encoding.GetString($Bytes); $offset = 0 }
    $updated = Update-RuntimeIni $text $Enable $Disable
    $prefix = if ($offset) { $encoding.GetPreamble() } else { [byte[]]@() }
    return ,([byte[]]($prefix + $encoding.GetBytes($updated)))
}

function Get-RuntimeFileHash([string]$Path) {
    if (!(Test-Path -LiteralPath $Path -PathType Leaf)) { return $null }
    return Get-RuntimeHash ([IO.File]::ReadAllBytes($Path))
}

function Set-RuntimeFile([string]$Stage, [string]$Target) {
    if ([IO.File]::Exists($Target)) { [IO.File]::Replace($Stage, $Target, [NullString]::Value) }
    else { [IO.File]::Move($Stage, $Target) }
}

# Backups and staged files use short numbered names (b/N, a/N), recorded in the journal: mirroring the
# installed path inside the backup folder exceeded Windows' 260-character path limit (live 2026-10-11,
# C:/Users/<name>/Downloads/GamingOnSteroids). Journals of earlier installers used before/<path>.
# Windows refuses paths of 260+ characters unless long paths are enabled.
function Test-RuntimeLongPaths {
    try { return (Get-ItemProperty -LiteralPath 'HKLM:/SYSTEM/CurrentControlSet/Control/FileSystem' -Name LongPathsEnabled -ErrorAction Stop).LongPathsEnabled -eq 1 }
    catch { return $false }
}

function Get-RuntimeBackupPath([string]$Transaction, $Entry) {
    if ($Entry.slot) { return Get-RuntimePath $Transaction ('b/' + $Entry.slot) }
    return Get-RuntimePath $Transaction ('before/' + $Entry.path)
}

function Restore-RuntimeTransaction([string]$Base, [string]$Transaction) {
    $journalPath = Join-Path $Transaction 'journal.json'
    $journal = Get-Content -LiteralPath $journalPath -Raw | ConvertFrom-Json
    if ($journal.root -ne $Base) { throw 'Backup belongs to a different installation.' }
    $restore = @()
    foreach ($entry in $journal.files) {
        $target = Get-RuntimePath $Base $entry.path
        $current = Get-RuntimeFileHash $target
        if ($current -eq $entry.before) { continue }
        if ($current -ne $entry.after) { throw "Rollback conflict at $target. Backup: $Transaction" }
        if ($null -ne $entry.before) {
            $backup = Get-RuntimeBackupPath $Transaction $entry
            if ((Get-RuntimeFileHash $backup) -ne $entry.before) { throw "Backup hash mismatch: $backup" }
        }
        $restore += $entry
    }
    [array]::Reverse($restore)
    foreach ($entry in $restore) {
        $target = Get-RuntimePath $Base $entry.path
        if ((Get-RuntimeFileHash $target) -ne $entry.after) { throw "File changed during rollback: $target" }
        if ($null -eq $entry.before) { [IO.File]::Delete($target) }
        else {
            $temp = Join-Path $Transaction ([guid]::NewGuid().ToString('N') + '.restore')
            [IO.File]::WriteAllBytes($temp, [IO.File]::ReadAllBytes((Get-RuntimeBackupPath $Transaction $entry)))
            Set-RuntimeFile $temp $target
        }
        if ((Get-RuntimeFileHash $target) -ne $entry.before) { throw "Rollback verification failed: $target" }
    }
    $journal.state = 'rolled-back'
    Write-RuntimeJson $journalPath $journal
    Write-Host "Restored backup: $Transaction"
}

function Remove-RuntimeFolder([string]$Path) {
    if ($Path -and (Test-Path -LiteralPath $Path)) { Remove-Item -LiteralPath $Path -Recurse -Force -ErrorAction SilentlyContinue }
}

# Releases a game may be running right now: the installed one (current) and any the in-game updater staged.
# Their files stay until the next install, so a running session can still load modules it has not loaded yet.
function Get-RuntimeActiveGenerations([string]$Root) {
    $family = Get-RuntimePath $Root 'LOLEXT/Scripts/Common/OrbamaFamily'
    $found = @()
    foreach ($name in @('current', 'update-a', 'update-b')) {
        $path = Join-Path $family $name
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            $lines = ([IO.File]::ReadAllText($path)).Split("`n")
            if ($lines.Count -ge 3 -and $lines[0] -in @('FAMILY1', 'FAMILYUPDATE1')) {
                $generation = if ($lines[0] -eq 'FAMILY1') { $lines[1] } else { $lines[2] }
                if ($generation -match '^[a-f0-9]{64}$') { $found += $generation }
            }
        }
    }
    return @($found | Select-Object -Unique)
}

# Old releases are removed, so updates never pile up: every release folder and every file the in-game updater
# staged (update-<release>-...) except the kept releases.
function Remove-RuntimeOldGenerations([string]$Root, [string[]]$Keep) {
    $family = Get-RuntimePath $Root 'LOLEXT/Scripts/Common/OrbamaFamily'
    if (!(Test-Path -LiteralPath $family)) { return }
    $removed = @{}
    foreach ($item in Get-ChildItem -LiteralPath $family -Force) {
        $generation = $null
        if ($item.PSIsContainer -and $item.Name -match '^[a-f0-9]{64}$') { $generation = $item.Name }
        elseif (!$item.PSIsContainer -and $item.Name -match '^update-([a-f0-9]{64})-') { $generation = $Matches[1] }
        if ($generation -and $generation -notin $Keep) {
            Remove-Item -LiteralPath $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
            $removed[$generation] = $true
        }
    }
    if ($removed.Count) { Write-Host "Removed $($removed.Count) old release(s)." }
}

function Invoke-RuntimeTransaction([string]$Base, $Writes, [string]$Revision) {
    $id = [DateTime]::UtcNow.ToString('yyyyMMddTHHmmssZ') + '-' + [guid]::NewGuid().ToString('N').Substring(0, 8)
    $transaction = Get-RuntimePath $Base ('.runtime-files/backups/' + $id)
    [void][IO.Directory]::CreateDirectory($transaction)
    $entries = @()
    [void][IO.Directory]::CreateDirectory((Join-Path $transaction 'a'))
    [void][IO.Directory]::CreateDirectory((Join-Path $transaction 'b'))
    foreach ($write in $Writes) {
        $target = Get-RuntimePath $Base $write.path
        $before = Get-RuntimeFileHash $target
        if ($before -ne $write.expected) { throw "File changed while preparing installation: $target" }
        $after = Get-RuntimeHash $write.bytes
        if ($before -eq $after -and !$write.snapshot) { continue }
        $slot = [string]$entries.Count
        if ($null -ne $before) {
            $backup = Get-RuntimePath $transaction ('b/' + $slot)
            [IO.File]::WriteAllBytes($backup, [IO.File]::ReadAllBytes($target))
            if ((Get-RuntimeFileHash $backup) -ne $before) { throw "File changed while backing up: $target" }
        }
        $stage = Get-RuntimePath $transaction ('a/' + $slot)
        [IO.File]::WriteAllBytes($stage, $write.bytes)
        if ((Get-RuntimeFileHash $stage) -ne $after) { throw "Staging verification failed: $stage" }
        $entries += [pscustomobject]@{path=$write.path; slot=$slot; before=$before; after=$after}
    }
    $journal = [pscustomobject]@{schema=1; root=$Base; commit=$Revision; state='installing'; files=$entries}
    $journalPath = Join-Path $transaction 'journal.json'
    Write-RuntimeJson $journalPath $journal
    try {
        foreach ($entry in $entries) {
            $target = Get-RuntimePath $Base $entry.path
            if ((Get-RuntimeFileHash $target) -ne $entry.before) { throw "Concurrent file change: $target" }
            [void][IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($target))
            Set-RuntimeFile (Get-RuntimePath $transaction ('a/' + $entry.slot)) $target
            if ((Get-RuntimeFileHash $target) -ne $entry.after) { throw "Installed hash mismatch: $target" }
        }
        $journal.state = 'installed'
        Write-RuntimeJson $journalPath $journal
    } catch {
        $failure = $_
        try { Restore-RuntimeTransaction $Base $transaction }
        catch { throw "Installation failed: $failure. Recovery failed: $_. Staged copies: $transaction" }
        throw "Installation failed and was rolled back: $failure"
    }
    return $transaction
}

function Invoke-RuntimeInstaller {
    [CmdletBinding()]
    param([string]$Root, [string[]]$Packages, [switch]$NonInteractive,
          [string]$SourceRoot, [string]$Commit, [switch]$KeepOtherScripts)
    $ErrorActionPreference = 'Stop'
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    $rootPath = Select-RuntimeRoot $Root $NonInteractive.IsPresent
    Write-Host "Installation: $rootPath"
    $state = Get-RuntimePath $rootPath '.runtime-files'
    [void][IO.Directory]::CreateDirectory($state)
    $lockPath = Get-RuntimePath $rootPath '.runtime-files/install.lock'
    try { $lock = [IO.File]::Open($lockPath, [IO.FileMode]::OpenOrCreate, [IO.FileAccess]::ReadWrite, [IO.FileShare]::None) }
    catch { throw 'Another installer is running, or the installation folder is not writable.' }
    try {
        $backups = Get-RuntimePath $rootPath '.runtime-files/backups'
        $journals = @()
        if (Test-Path -LiteralPath $backups) {
            $journals = @(Get-ChildItem -LiteralPath $backups -Directory | Sort-Object Name -Descending | ForEach-Object {
                $path = Get-RuntimePath $_.FullName 'journal.json'
                if (Test-Path -LiteralPath $path) { [pscustomobject]@{path=$_.FullName; data=(Get-Content -LiteralPath $path -Raw | ConvertFrom-Json)} }
            })
        }
        $pending = @($journals | Where-Object { $_.data.state -eq 'installing' })
        # Re-running the installer always recovers: an interrupted earlier installation is rolled back first.
        foreach ($interrupted in $pending) {
            try { Restore-RuntimeTransaction $rootPath $interrupted.path; Write-Host 'Rolled back an interrupted earlier installation.' }
            catch { throw "An interrupted earlier installation could not be rolled back: $_" }
        }
        # No backups are kept: a finished installation's staging folder (and any left by older installers) goes.
        foreach ($finished in $journals) { Remove-RuntimeFolder $finished.path }
        if (!$SourceRoot) {
            if (!$Commit) {
                $head = Invoke-RestMethod -Uri "https://api.github.com/repos/$($script:RuntimeRepository)/commits/main" -Headers @{'User-Agent'=$script:RuntimeAgent} -TimeoutSec 30
                $Commit = $head.sha
            }
        } else { $SourceRoot = [IO.Path]::GetFullPath($SourceRoot); if (!$Commit) { $Commit = 'local-test' } }
        $manifest = [Text.Encoding]::UTF8.GetString((Get-RuntimeBytes 'manifest.json' $SourceRoot $Commit)) | ConvertFrom-Json
        Assert-RuntimeFamily $manifest
        # Validate the catalog before resolving package dependencies.
        $null = Resolve-RuntimePackages $manifest @($manifest.packages.id)
        $receiptPath = Get-RuntimePath $rootPath '.runtime-files/installed.json'
        $receiptHash = Get-RuntimeFileHash $receiptPath
        $previous = @()
        if ($receiptHash) {
            $receipt = Get-Content -LiteralPath $receiptPath -Raw | ConvertFrom-Json
            if ($receipt.schema -ne 1) { throw 'Unsupported installation receipt.' }
            # Packages an older release had but this one does not are skipped, never an error.
            $known = @($manifest.packages.id)
            $previous = @($receipt.packages | ForEach-Object { $_.id } | Where-Object { $_ -in $known -or ($manifest.packageAliases -and $manifest.packageAliases.PSObject.Properties[$_]) })
        }
        if (!$Packages) {
            $Packages = @($manifest.packages.id)
        }
        $requested = @(Convert-RuntimePackageNames $manifest @($Packages + $previous))
        $selected = @(Resolve-RuntimePackages $manifest @($requested | Select-Object -Unique))
        if (!$selected.Count) { throw 'No packages selected.' }
        $enable = @($selected | ForEach-Object { $_.enable } | Select-Object -Unique)
        $disable = @($selected | ForEach-Object { $_.disable } | Select-Object -Unique)
        Write-Host ('Install and enable: ' + ($enable -join ', '))
        if ($disable.Count) { Write-Host ('Disable if registered: ' + ($disable -join ', ')) }
        Write-Host "Release $($manifest.release), publication $Commit"
        $writes = @()
        $destinations = @{}
        foreach ($package in $selected) {
            foreach ($file in $package.files) {
                if ($file.destination -notmatch '^LOLEXT/(Scripts|Sprites|Fonts|Sounds)/' -or
                    $file.sha256 -notmatch '^[a-f0-9]{64}$' -or $file.size -le 0) { throw 'Invalid package file metadata.' }
                $target = Get-RuntimePath $rootPath $file.destination
                if ($target.Length -ge 260 -and !(Test-RuntimeLongPaths)) {
                    throw "The GamingOnSteroids folder path is too long for Windows ($($target.Length) characters for $($file.destination)). Move GamingOnSteroids to a shorter path, for example directly on drive C, and run the installer again."
                }
                if ($destinations.ContainsKey($file.destination)) { throw "Duplicate package destination: $($file.destination)" }
                $destinations[$file.destination] = $true
                $expected = Get-RuntimeFileHash $target
                $bytes = Get-RuntimeBytes $file.source $SourceRoot $Commit
                if ($bytes.Length -ne $file.size -or (Get-RuntimeHash $bytes) -ne $file.sha256) { throw "Download verification failed: $($file.source)" }
                # A damaged or edited file of this release is simply replaced.
                if ($manifest.family -and $file.destination -eq 'LOLEXT/Scripts/Common/OrbamaFamily/current') {
                    $selector = [Text.Encoding]::UTF8.GetString($bytes)
                    $generationManifest = @($manifest.packages | ForEach-Object { $_.files } | Where-Object {
                        $_.destination -eq ('LOLEXT/Scripts/Common/OrbamaFamily/' + $manifest.family.generation + '/manifest.lua')
                    })
                    $required = "FAMILY1`n$($manifest.family.generation)`n$($generationManifest[0].sha256)`n"
                    if ($selector -cne $required) { throw 'Family activation selector does not match its manifest.' }
                }
                $writes += [pscustomobject]@{path=$file.destination; bytes=$bytes; expected=$expected}
            }
        }
        foreach ($name in $enable) {
            if (!$destinations.ContainsKey('LOLEXT/Scripts/' + $name)) { throw "Loader entry has no package file: $name" }
        }
        if ($manifest.family) {
            # New generations are complete before the selector changes. Existing
            # sessions keep their generation and never read this selector again.
            $writes = @($writes | Sort-Object @{Expression={if ($_.path -eq 'LOLEXT/Scripts/Common/OrbamaFamily/current') { 1 } else { 0 }}})
            # What the installer installs is authoritative: a release the in-game updater staged earlier
            # (update-a / update-b) would otherwise be preferred at the next load. Its selectors are
            # switched off.
            foreach ($slot in @('a', 'b')) {
                $slotPath = 'LOLEXT/Scripts/Common/OrbamaFamily/update-' + $slot
                $slotHash = Get-RuntimeFileHash (Get-RuntimePath $rootPath $slotPath)
                if ($slotHash) { $writes += [pscustomobject]@{path=$slotPath; bytes=[Text.Encoding]::ASCII.GetBytes("FAMILYUPDATE0`n"); expected=$slotHash} }
            }
        }
        $iniPath = Get-RuntimePath $rootPath 'LOLEXT/LocalScriptDB.ini'
        $iniHash = Get-RuntimeFileHash $iniPath
        $iniBytes = if ($null -ne $iniHash) { [IO.File]::ReadAllBytes($iniPath) } else { [byte[]]@() }
        # Only the family runs: every other active script is switched off (ACTIVE = 0, files untouched;
        # -KeepOtherScripts leaves them as they are.
        if (!$KeepOtherScripts) {
            $others = @(Get-RuntimeActiveScripts (Read-RuntimeIniText $iniBytes) | Where-Object { $_ -notin $enable -and $_ -notin $disable })
            if ($others.Count) { Write-Host ('Disable other active scripts: ' + ($others -join ', ')) }
            $disable = @($disable + $others | Select-Object -Unique)
        }
        $writes += [pscustomobject]@{path='LOLEXT/LocalScriptDB.ini'; bytes=(Convert-RuntimeIni $iniBytes $enable $disable); expected=$iniHash}
        $receipt = [ordered]@{schema=1; commit=$Commit; release=$manifest.release; installedAt=[DateTime]::UtcNow.ToString('o');
            packages=@($selected | ForEach-Object { [ordered]@{id=$_.id; version=$_.version} });
            files=@($writes | ForEach-Object { [ordered]@{path=$_.path; sha256=(Get-RuntimeHash $_.bytes)} })}
        $receiptBytes = [Text.Encoding]::UTF8.GetBytes((ConvertTo-Json $receipt -Depth 15) + "`n")
        $writes += [pscustomobject]@{path='.runtime-files/installed.json'; bytes=$receiptBytes; expected=$receiptHash}
        $running = if ($manifest.family) { @(Get-RuntimeActiveGenerations $rootPath) } else { @() }
        $transaction = Invoke-RuntimeTransaction $rootPath $writes $Commit
        Remove-RuntimeFolder $transaction
        if ($manifest.family) { Remove-RuntimeOldGenerations $rootPath (@($manifest.family.generation) + $running) }
        Write-Host 'Installed and enabled. Reload the complete script runtime when ready.' -ForegroundColor Green
        Write-Host 'No running process was stopped or reloaded.'
    } finally { $lock.Dispose() }
}

if (!$LibraryOnly) {
    try {
        if ($DetectOnly) { Get-RuntimeInstallations }
        else { Invoke-RuntimeInstaller -Root $Root -Packages $Packages -NonInteractive:$NonInteractive -SourceRoot $SourceRoot -Commit $Commit -KeepOtherScripts:$KeepOtherScripts }
    } catch {
        if ($NonInteractive) { throw }
        Write-Host "Installer stopped: $_" -ForegroundColor Red
        if (!$DetectOnly) { $null = Read-Host 'Press Enter to close' }
    }
}
