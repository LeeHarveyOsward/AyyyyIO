return function(require)
local function skip()end
return {new=function()return {Tick=skip,Decision=skip}end}
end
