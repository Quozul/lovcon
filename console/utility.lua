--[[ This file include some usefull functions used by the console
     You are free to use all of these functions in your own game
     Note that the last function is not made by me ]]
function inSquare(x1, y1, x2, y2, w2, h2) return x1 >= x2 and x1 <= x2 + w2 and y1 >= y2 and y1 <= y2 + h2 end
function isBetween(value, min, max) return value >= min and value <= max end
function math.between(value, min, max) return math.max(math.min(value, max), min) end
function math.round(num, decimals) return math.floor(num * 10^(decimals or 0) + 0.5) / 10^(decimals or 0) end
function math.trunc(num) return tostring(num):split(".")[1] end
-- I'm very proud of the insert and remove functions :D
function string:insert(pos, char) return self:sub(1, pos) .. char .. self:sub(pos + 1, self:len()) end
function string:remove(pos, dir)
    if not dir then return self:sub(1, pos - 1) .. self:sub(pos + 1, self:len())
    else return self:sub(1, pos) .. self:sub(pos + 2, self:len()) end
end
function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end
-- found over there: https://github.com/EmmanuelOga/easing/blob/master/lib/easing.lua
function outElastic(t, b, c, d, a, p)
    if t == 0 then return b end
    t = t / d
    if t == 1 then return b + c end
    if not p then p = d * 0.3 end
    local s
    if not a or a < math.abs(c) then
        a = c
        s = p / 4
    else
        s = p / (2 * math.pi) * math.asin(c/a)
    end
    return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * math.pi) / p) + c + b
end