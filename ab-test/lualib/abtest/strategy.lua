-- 读取json 策略配置文件

local json = require("cjson.safe")
local json_decode = json.decode
local _M = {
    _VERSION = '0.01'
}


local function tailConfig(strategy_content)
    if strategy_content then
        local s_c;
        for key,value in pairs(strategy_content) do
            local data = value["data"]
            local exp = value["experiment"]
            if data then
                for data_key,data_value in pairs(data) do
                    s_c[data_value]  = exp
                end
            end
        end
        -- 重新复
        strategy_content = s_c
    end
end

local function whiteConfig(strategy_content)
    if strategy_content then
        local s_c;
        for key,value in pairs(strategy_content) do
            local data = value["data"]
            local exp = value["experiment"]
            if data then
                for data_key,data_value in pairs(data) do
                    s_c[data_value]  = exp
                end
            end
        end
        -- 重新复
        strategy_content = s_c
    end
end

-- 存储配置信息的json
local config

function _M.init(jsonfile)
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
            --ngx.log(ngx.ERR,"content , ",content)
            config = json_decode(content)
            if config then
                for k,v in pairs(configJson) do
                    local strategy_name = v["strategy_name"]
                    -- tail
                    if strategy_name and strategy_name == "tail" then
                        local strategy_content = v["strategy_content"]
                        tailConfig(strategy_content)

                    elseif strategy_name and strategy_name == "white" then
                        local strategy_content = v["strategy_content"]
                        whiteConfig(strategy_content)
                    end
                end
            end

        end
        file:close()
    end

    return true,nil

end


function _M.getConfig()
    return config
end


function _M.check_default_experiment(strategy_name,strategy_content)
    if not strategy_name then
       return false
    end
    if strategy_name == "no" then
        return false
    end

    if not strategy_content then
        return false
    end
end


function _M.forward_experiment(experiment,url_args)
    local url = experiment["url"]
    ngx.location.capture(
        url, {args=url_args}
    )
end

return _M