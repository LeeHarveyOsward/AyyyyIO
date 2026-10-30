return function(require)
-- Native recall identities shared by tracking and every own-channel guard.
local M={names={recall=true,recallimproved=true,superrecall=true}}
function M.IsName(name)return type(name)=='string'and M.names[name:lower()]==true end
return M

end
