return function(require)
local function skip()end
return {new=function()return {Sample=skip,Event=skip,Snapshot=function()return {}end}end}
end
