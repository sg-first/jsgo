function deleteSpace(str)
    while(字符串查找(str,"  ")!=-1)
        str=字符串替换(str,"  "," ")
    end
    return str
end