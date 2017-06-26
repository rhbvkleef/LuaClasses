function hasValue(table, value)
    if type(table) ~= "table" then
        return false
    end
    for _,v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end
