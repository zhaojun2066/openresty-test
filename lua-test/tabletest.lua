--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/15
-- Time: 15:05
-- To change this template use File | Settings | File Templates.
-- {} 内用, 相隔，也可以用; 相隔

local a = {} --- 空表
local day = {"Sunday", "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday"} --- 直接初始化

local  day_4 = day[4] --- 索引是从1开始

--- table 可以试任何形式的
local tt = {
    a = 10,
    b = 20
}

local tta = tt.a
local ttb = tt.b
--- 复杂的table
local complattable = {
    a = 10,
    b = 11,
    ha = "hellow",
    100,
    [2] = 33,
    user = {
        name= "jun",
        age = 30
    }
}

