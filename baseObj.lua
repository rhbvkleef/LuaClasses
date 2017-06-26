require "util.escape"
require "util.deepcopy"
require "util.tables"

local BaseObj = {}
BaseObj.__tsdoesjson = true
BaseObj.__extends = {}
BaseObj.__type = "BaseObj"

function BaseObj:__call(type)
    obj = table.deepcopy(self)
    obj.__type = type
    obj:updateObject()
    return obj
end

function BaseObj:use(obj)
    for k,v in pairs(obj) do
        if self[k] == nil then
            self[k] = v
        end
    end
    
    local tmp = {}
    for _,v in pairs(obj.__extends) do
        tmp[#tmp + 1] = v
    end
    for _,v in pairs(self.__extends) do
        tmp[#tmp + 1] = v
    end
    
    self.__extends = {}
    for _,v in pairs(tmp) do
        if not hasValue(self.__extends, v) then
            self.__extends[#self.__extends + 1] = v
        end
    end
end

function BaseObj:applyTo(obj)
    local mt = getmetatable(obj)
    if mt ~= nil then
        for k,v in pairs(mt) do
            if obj[k] == nil then
                obj[k] = v
            end
        end
    end
    
    for k,v in pairs(self) do
        if obj[k] == nil then
            obj[k] = v
        end
    end
    
    local tmp = {}
    for k,v in pairs(self.__extends) do
        tmp[k] = v
    end
    
    for _,v in pairs(tmp) do
        if not hasValue(obj.__extends, v) then
            obj.__extends[#obj.__extends + 1] = v
        end
    end
    obj:updateObject()
end

function BaseObj:typeof(test)
    if type(test) == "table" then
        if test.__type then
            return hasValue(self.__extends, test.__type)
        else
            return false
        end
    end
    return hasValue(self.__extends, tostring(test))
end

function BaseObj:updateObject()
    if not hasValue(self.__extends, self.__type) then
        self.__extends[#self.__extends + 1] = self.__type
    end
    
    if getmetatable(self) == nil then
        setmetatable(self, {})
    end
    for k,v in pairs(self) do
        if tostring(k):find("__") then
            getmetatable(self)[k] = v
        end
    end
end

function BaseObj:__tostring()
    local string = "{"
    for k,v in pairs(self) do
        if not tostring(k):find("__") then
            if (type(v) == "table" and v["__tsdoesjson"]) or type(v) == "number" or type(v) == "boolean" then
                string = string .. "\"" .. escape(tostring(k)) .. "\":" .. tostring(v) .. ","
            elseif (type(v) ~= "function") then
                string = string .. "\"" .. escape(tostring(k)) .. "\":\"" .. escape(tostring(v)) .. "\","
            end
        end
    end
    if string:sub(#string, #string) ~= "{" then
        string = string:sub(1, -2)
    end
    
    string = string .. "}"
    return string
end

BaseObj:updateObject()
return BaseObj
