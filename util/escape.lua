function escape(s)
    s=s:gsub("\\", "\\\\")
    s=s:gsub("\a", "\\a")
    s=s:gsub("\b", "\\b")
    s=s:gsub("\f", "\\f")
    s=s:gsub("\n", "\\n")
    s=s:gsub("\r", "\\r")
    s=s:gsub("\t", "\\t")
    s=s:gsub("\v", "\\v")
    s=s:gsub("\"", "\\\"")
    s=s:gsub("\'", "\\\'")
    return s
end
