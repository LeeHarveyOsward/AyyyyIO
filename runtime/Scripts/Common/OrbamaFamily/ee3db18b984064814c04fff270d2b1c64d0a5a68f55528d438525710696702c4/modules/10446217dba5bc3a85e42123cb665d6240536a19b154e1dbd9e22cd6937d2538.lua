return function(require)
local S={}
local empty={}
local function keyName(key)
    if type(key)~='number'or key==0 then return 'unbound' end
    if key==32 then return 'Space' end
    if key>=48 and key<=90 then return string.char(key) end
    if key>=112 and key<=123 then return 'F'..(key-111) end
    return 'key '..tostring(key)
end
function S.key(node)return keyName(node and node.Key and node:Key())end
function S.bind(sdk,mode)
    local names={}
    for _,node in ipairs(sdk.Orbwalker.MenuKeys[mode]or {})do
        if node.Key then names[#names+1]=keyName(node:Key())end
    end
    return #names>0 and table.concat(names,' / ')or 'unbound'
end
function S.new(guide,nodes,active)
    local links={}
    function links.rules()return empty end
    function links.spans(text)
        local spans={};local at=1
        while at<=#text do
            local first,last,key=text:find('%[%[([%w_]+)%]%]',at)
            if not first then spans[#spans+1]={text=text:sub(at)};break end
            if first>at then spans[#spans+1]={text=text:sub(at,first-1)}end
            -- A setting without a menu entry (a fixed good default) is named, not offered as a switch.
            local row=nodes[key];local linked=row and not row.node.fixed
            spans[#spans+1]={text=row and row.label or key,link=linked and {key=key,label=row.label}or nil}
            at=last+1
        end
        return spans
    end
    function links.active(_,link)
        local row=nodes[link.key]
        return row and row.node:Value()==true or false
    end
    local config={}
    function config:get(key)
        local row=nodes[key]
        if row then return row.node:Value()end
        return guide.config:get(key)
    end
    local function activate(link)
        if not active()then return false end
        local row=nodes[link.key]
        if not row or row.node.fixed or type(row.node:Value())~='boolean'then return false end
        row.node:Value(not row.node:Value());return true
    end
    return config,links,activate
end
return S

end
