local family=_G.OrbamaFamily
if not family then
 local root=assert(COMMON_PATH,'COMMON_PATH is unavailable')
 if not root:match('[/\\]$') then root=root..'/' end
 family=assert(loadfile(root..'OrbamaFamily/bootstrap.lua'))()
 _G.OrbamaFamily=family
end
return family:Boot("AyyyyIO")
