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

Vector.mul = function (v, scalar)
    local ret = {}
    ret.x = (v.x or 0) * scalar
    ret.y = (v.y or 0) * scalar
    return ret
end

Vector.length = function (v)
    return math.sqrt(v.x * v.x + v.y * v.y)
end

Vector.normalize = function (v)
    local len = Vector.length(v)
    if len == 0 then
        return Vector.new(0, 0)
    else
        return Vector.mul(v, 1 / len)
    end
end

return Vector