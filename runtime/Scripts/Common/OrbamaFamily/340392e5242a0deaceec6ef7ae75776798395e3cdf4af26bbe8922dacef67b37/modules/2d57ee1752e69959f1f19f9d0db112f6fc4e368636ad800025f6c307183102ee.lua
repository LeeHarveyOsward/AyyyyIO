return function(require)
-- Seconds; standard Normal map 11 and the installed Classic map 453 are distinct.
-- A schedule predicts a spawn. It does not observe a living camp.
local T={normal={},classic={}}
local riot='https://www.leagueoflegends.com/en-us/news/game-updates/patch-26-1-notes/'
local baseline='https://www.leagueoflegends.com/en-gb/news/game-updates/patch-11-10-notes/'
local function row(first,respawn,count,source,verified,clear)
 return {firstSpawn=first,respawn=respawn,members=count,source=source,units='seconds',
   firstSpawnSource=first and source or nil,respawnSource=source,verified=verified==true,
  clearCondition=clear or 'all_members',oneTime=respawn==0}
end
for _,name in ipairs({'Red','Blue'})do T.normal[name]=row(55,300,1,riot,true)end
T.normal.Wolves=row(55,135,3,baseline,true)
T.normal.Raptors=row(55,135,6,baseline,true)
T.normal.Gromp=row(67,135,1,baseline,true)
T.normal.Krugs=row(67,135,2,baseline,true,'original_members_split_remnants')
for _,name in ipairs({'Wolves','Raptors','Gromp','Krugs'})do T.normal[name].firstSpawnSource=riot end
local standard='https://www.leagueoflegends.com/en-au/news/game-updates/patch-14-19-notes/'
T.normal.River=row(175,180,1,riot..'; standard SR baseline: '..standard,true)
T.normal.Dragon=row(300,300,1,standard..' (standard SR baseline, outside Spellbook values)',true)
T.normal.Elder=row(nil,360,1,'https://www.leagueoflegends.com/en-gb/news/game-updates/patch-9-23-notes/',true)
T.normal.Elder.spawnRule='360 seconds after a team obtains its fourth elemental drake; then 360 after Elder death'
T.normal.Baron=row(1200,300,1,riot..'; standard SR baseline: '..standard,true)
T.normal.Grubs=row(480,0,3,'https://www.leagueoflegends.com/en-au/news/game-updates/patch-25-09-notes/',true)
T.normal.Herald=row(900,0,1,'https://www.leagueoflegends.com/en-au/news/game-updates/patch-25-09-notes/',true)
T.normal.Atakhan=row(nil,0,1,riot,true);T.normal.Atakhan.removed=true
local asset='installed map453 monster CharacterRecord enemyTooltip + RST5 locale, 2026-10-10'
T.classic.Wolves=row(nil,75,3,asset..': GiantWolf',true)
T.classic.Wraiths=row(nil,75,4,asset..': Wraith',true)
T.classic.Golems=row(nil,75,2,asset..': Golem',true)
T.classic.Wight=row(nil,50,1,asset..': Wight',true)
T.classic.Red=row(nil,300,3,'retained Classic profile; S3_LizardElder tooltip unresolved',false)
T.classic.Blue=row(nil,300,3,'retained Classic profile; S3_AncientGolem tooltip unresolved',false)
T.classic.Dragon=row(nil,360,1,'retained Classic estimate; S3_Dragon tooltip unresolved',false)
T.classic.Baron=row(nil,420,1,'retained Classic estimate; S3_Baron tooltip unresolved',false)
return T

end
