return function(require)
-- Mode-key editors share the orbwalker's native key node, including its save ID.
-- Mirrors have no ID: the host documents anonymous parameters as unsaved.
local B={};B.__index=B
local function read(node)
    if not node or type(node.Key)~='function' then return end
    local ok,key=pcall(node.Key,node)
    if ok and type(key)=='number' then return key end
end
local function write(node,key)
    if read(node)==key then return true end
    -- GoS native key parameters expose __key. Do not assume Key is a setter:
    -- several providers implement it as a getter only. Check both before/after.
    local old=read(node)
    if old==nil or node.__key~=old then return false end
    local ok=pcall(function()node.__key=key end)
    if ok and read(node)==key then return true end
    pcall(function()node.__key=old end)
    return false
end
function B.new(config,sdk)
    local self=setmetatable({config=config,entries={},nextSync=0},B)
    if not config.menu then return self end
    local menu=config.menu;local icon=require('leesin.menuicons').new()
    -- Every Lee bind is created once, under Controls. The guide only adds an
    -- overview of the orbwalker mode keys, which belong to another menu.
    local help
    local function editor(node,label,semantic)
        if read(node)==nil then return end
        -- Unknown menu implementations keep their original editor; never show
        -- a second independent binding that cannot update the real input node.
        if node.__key~=read(node) then return end
        if not help then
            menu.Guide:MenuElement({id='Bindings',name='Orbwalker mode keys',type=MENU});help=menu.Guide.Bindings
        end
        local entry={source=node,last=read(node)}
        local args={name=label,key=entry.last,leftIcon=icon(semantic),
            tooltip="Changes the orbwalker's own binding."}
        args.onKeyChange=function(key)
            if type(key)~='number' or key<0 or key%1~=0 then return end
            if write(node,key) then self:sync(true) end
        end
        entry.mirror=help:MenuElement(args)
        if entry.mirror then self.entries[#self.entries+1]=entry end
    end
    local modes={{'COMBO','Combat','Combo'},{'HARASS','Harass','Harass'},
        {'LANECLEAR','Wave','Lane clear'},{'JUNGLECLEAR','Jungle','Jungle clear'},
        {'LASTHIT','LastHit','Last hit'},{'FLEE','Controls','Flee'}}
    local orb=sdk and sdk.Orbwalker
    for _,row in ipairs(modes) do
        local id=sdk and sdk['ORBWALKER_MODE_'..row[1]]
        local nodes=orb and orb.MenuKeys and id~=nil and orb.MenuKeys[id]
        for index,node in ipairs(nodes or {}) do
            editor(node,row[3]..(index>1 and ' '..index or ''),row[2])
        end
    end
    return self
end
function B:sync(force)
    local now=Game and Game.Timer and Game.Timer() or 0
    if not force and now<self.nextSync then return end
    self.nextSync=now+.1
    for _,entry in ipairs(self.entries) do
        local key=read(entry.source)
        if key~=nil and read(entry.mirror)~=key then write(entry.mirror,key) end
        entry.last=key
    end
end
return B

end
