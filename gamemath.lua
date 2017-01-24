--[[
    gamemath.lua
]]

-- test whether two rectangles intersect
function rectCollide(a, b)
    if (a.x2 < b.x1) return false;
    if (a.x1 > b.x2) return false;
    if (a.y2 < b.y1) return false;
    if (a.y1 > b.y2) return false;
    return true;
end