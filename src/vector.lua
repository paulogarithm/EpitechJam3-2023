local Vector = {}

Vector.new = function (x, y)
    return {x = x, y = y}
end

Vector.add = function (v1, v2)
    local ret = {}
    ret.x = (v1.x or 0) + (v2.x or 0)
    ret.y = (v1.y or 0) + (v2.y or 0)
    return ret
end

Vector.sub = function (v1, v2)
    local ret = {}
    ret.x = (v1.x or 0) - (v2.x or 0)
    ret.y = (v1.y or 0) - (v2.y or 0)
    return ret
end

Vector.isVector = function (val)
    return ((val.x) and (val.y))
end

return Vector