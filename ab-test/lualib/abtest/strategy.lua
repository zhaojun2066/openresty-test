-- 读取json 策略配置文件

local json = require("cjson.safe")
local json_decode = json.decode
local _M = {
    _VERSION = '0.01'
}

-- 存储配置信息的json
local config

function _M.new(jsonfile)
    local file = io.open(jsonfile,"r")
    if not file then
       return false,"read config json file err"
    end
    if file then
        local content = ""
        for line in file:lines() do
            content = content..line
        end
        if  content and content ~= "" then
            ngx.log(ngx.ERR,"content , ",content)
            config = json_decode(content)
        end
    end
    return true,nil

end

function _M.getConfig()
    return config
end

return _M