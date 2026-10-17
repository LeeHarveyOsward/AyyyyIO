return function(require)
local function skip()end
return {new=function()return {enabled=false,Event=skip,Flush=skip}end}
end
