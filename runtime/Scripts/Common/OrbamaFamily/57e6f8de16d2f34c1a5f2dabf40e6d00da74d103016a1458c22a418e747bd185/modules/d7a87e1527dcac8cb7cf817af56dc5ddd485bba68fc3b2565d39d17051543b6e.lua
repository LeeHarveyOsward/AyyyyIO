return function(require)
local M={}
function M.Register(guide,name,service)
    if name=='OrbamaUtils' then
        guide:Register('utils',{'Utils: Smite','Utils: protection','Utils: tracking'},function(index)
            local cfg=service.config
            local function state(key)return cfg:get(key) and 'ON' or 'OFF'end
            if index==1 then return {title='Objectives and Smite',subtitle='Autosmite '..state('autosmite')..' | Camp Smite '..state('smiteCamps'),cards={
                {'INDEPENDENT','Objective Smite does not need Combo or Clear to be held. It uses current readiness, damage, health and target identity.'},
                {'COOPERATION','Champion ability-plus-Smite plans request the same utility service. They do not own a second summoner queue. Sent input must finish its stabilization first.'},
                {'PERMISSIONS','Use the Objectives menu to configure camps and charge reservation. No available charge, invalid aim or a changed target can reject a waiting request.'}},note='A request or cursor movement is not proof of Smite. Confirm the actual cooldown and objective result.'} end
            if index==2 then return {title='Items, summoners and skill points',subtitle='Items '..state('items')..' | Offensive requests '..state('offense'),cards={
                {'PROTECTION','The Activator owns general potion, Cleanse, QSS, shield and supported defensive item requests. Evade requests permitted items through this service.'},
                {'PERMISSIONS','Offensive item use and summoner permissions remain separate. Existing saved settings win over new defaults. A profile must support an item before it can execute.'},
                {'LEVELING','The champion supplies its skill order. Utils owns the key input and waits for an observed rank change. This does not buy items or operate the shop.'}},note='Review the Activator menu for the current profile before enabling additional resource use.'} end
            return {title='Tracking and utility drawings',subtitle='Prepared displays, observed facts and labeled estimates.',cards={
                {'WORLD STATE','Ward, camp, objective, cooldown, recall and last-seen displays use their recorded observations. Missing visibility is not evidence that a camp is dead.'},
                {'DRAWINGS','Each drawing has its own visibility controls. Choose screen or minimap, teams, distance and modes in the Drawings menu.'},
                {'LIMITS','A ward radius is not an exact terrain-aware visibility map. Recall timeout without a finish event remains unknown. Legacy trackers stay enabled until their replacements are accepted.'}},note='Normal and Classic data are separate. SR-specific camp information does not establish support for another map.'}
        end)
    elseif name=='EvAYYYYde' then
        guide:Register('evade',{'Evade: controls','Evade: decisions'},function(index)
            if index==1 then
                local m=service.menu
                local toggle=m and m.Enabled and m.Enabled.Key and m.Enabled:Key()
                local bypass=m and m.Bypass and m.Bypass.Key and m.Bypass:Key()
                return {title='EvAYYYYde',subtitle='Toggle key '..tostring(toggle or 'see menu')..' | Bypass key '..tostring(bypass or 'see menu'),cards={
                    {'CONTROL','Hold bypass when you want manual movement. The menu separates movement, defensive spells, items, ultimates and summoner permissions.'},
                    {'DISPLAY','Incoming threats, the planned escape route and intended movement have separate drawing switches. A route preview does not prove that every future threat is known.'},
                    {'OWNERSHIP','Evade cooperates through Orbama actions and reservations. Item actions require OrbamaUtils; movement remains available without it.'}},note='Coverage is partial. Unsupported geometry or damage cannot establish that a route is safe.'}
            end
            return {title='How defensive actions compete',subtitle='Readiness, time windows and permission matter.',cards={
                {'MOVEMENT','The planner includes movement during reaction delay. It preserves an attack windup when a safe route permits it.'},
                {'DEFENSES','Spell and item defenses have expiry and interruption limits. Their end state and remaining exposure matter; activating a defense is not automatically a safe outcome.'},
                {'PROFILE','Threat definitions load for discovered enemies. Normal and Jade records remain separate, and map geometry needs current evidence.'}},note='Urgency cannot cancel required stabilization of an input that has already been sent.'}
        end)
    end
end
return M

end
