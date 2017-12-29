-- 动态切换upstream

local _M = {}

local json = require("cjson.safe")
local json_decode = json.decode
local upstream_config
function _M.init(json_file)
    local file = io.open(json_file,"r")
    if not file then
        return false,"read upstream config json file err"
    end
    if file then
        local content = ""
        for line in file:lines() do
            content = content..line
        end
        if content and content ~="" then
            upstream_config = json_decode(content)

        else
            return false,"read upstream config json file err,content is nil"
        end
        file:close()
    end
    return true,nil
end

function _M.get_config()
    return upstream_config
end


return _M

