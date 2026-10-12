return function(require)
-- Lee gameplay policy only. Orbama owns queuing, input, priorities and cleanup.
local I={}
local held={fight=true,harass=true,clear=true,last_hit=true,q=true,secure=true,farm=true}
function I.origin(c,owner)
    if owner=='clear' and c.mode=='last_hit' then return 'last_hit' end
    if owner=='harass' and c.mode=='clear' then return 'clear' end
    if held[owner] and c.mode==owner then return owner end
end
function I.valid(c,origin)
    if not origin then return true end
    if c.mode~=origin then return false,'mode_changed' end
    if origin=='farm' and (not c.config:get('autoJungle') or c.input.farmPaused) then
        return false,'autojungle_stopped'
    end
    return true
end
function I.priority(owner,execute)
    if execute or owner=='evade' or owner=='interrupt' then return 'critical' end
    if owner=='flee' then return 'interactive' end
    if owner=='ward' or owner=='insec' or owner=='fight' or owner=='defense' or owner=='secure' then return 'interactive' end
    if owner=='farm' or owner=='clear' or owner=='expiry' then return 'background' end
    return 'normal'
end
return I

end
