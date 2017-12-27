-- 读取json 策略配置文件

local json = require("cjson.safe")
local json_decode = json.decode
local _M = {
    _VERSION = '0.01'
}


local function tail_config(strategy_content)
    local s_c={}
    if strategy_content then
        for key,value in pairs(strategy_content) do
            local data = value["data"]
            local exp = value["experiment"]
            if data then
                for data_key,data_value in pairs(data) do
                    s_c[data_value]  = exp
                end
            end
        end
    end
    return s_c
end

local function white_config(strategy_content)
    local s_c={}
    if strategy_content then

        for key,value in pairs(strategy_content) do
            local data = value["data"]
            local exp = value["experiment"]
            if data then
                for data_key,data_value in pairs(data) do
                    s_c[data_value]  = exp
                end
            end
        end
    end
    return s_c
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
                for k,v in pairs(config) do
                    --ngx.log(ngx.ERR,"k-> , ",k)
                    local strategy_name = v["strategy_name"]
                    -- tail
                    if strategy_name and strategy_name == "tail" then
                        local strategy_content = v["strategy_content"]
                        local s_c= tail_config(strategy_content)
                        config[k]["strategy_content"] = s_c

                    elseif strategy_name and strategy_name == "white" then
                        local strategy_content = v["strategy_content"]
                        local s_c= white_config(strategy_content)
                        config[k]["strategy_content"] = s_c
                    end
                end
            end

        end
        file:close()
    end

    return true,nil

end


function _M.get_config()
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

    return true
end


function _M.forward_experiment(experiment,url_args)
    local url = experiment["url"]
    ngx.log(ngx.ERR,"debug_url-> ",url)
    local res = ngx.location.capture(
        url, {args=url_args}
    )
    ngx.say(res.body)
   -- return

    --[[ngx.location.capture_multi(
        {
            {url,{args=url_args}}
        }
    )]]
end

return _M