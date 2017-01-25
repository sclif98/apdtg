--[[
    main.lua
]]

WIDTH=128
HEIGHT=128
SPRITESIZE=8

--@import spriteIDs.lua
--@import levelData.lua
--@import gamemath.lua

function printRectData(rect, y, color)
    local text = "x1=" .. rect.x1 .. ", y1=" .. rect.y1 .. ", x2=" .. rect.x2 .. ", y2=" .. rect.y2
    print(text, 0, y, color)
end

-- init
function _init()
    music(0)
end

-- update & draw
function _update()
    local player = gameState.player

    -- clear screen
    rectfill(0, 0, WIDTH, HEIGHT, gameState.clearColor)

    -- update player
    if (btn(0, 0)) then -- left 
        player.x = player.x - player.speed
    end
    if (btn(1, 0)) then -- right
        player.x = player.x + player.speed
    end

    for t in all(gameState.rooms[gameState.currentRoomID].loadTriggers) do
        if (rectCollide(t, {x1=player.x, y1=player.y, x2=player.x+SPRITESIZE, y2=player.y+SPRITESIZE})) then
            gameState.currentRoomID = t.destRoomID
            player.x = t.destPlayerX
            player.y = t.destPlayerY
        end
    end

    -- draw level
    for w in all(gameState.rooms[gameState.currentRoomID].walls) do
        rectfill(w.x1, w.y1, w.x2, w.y2, w.color)
    end
    for p in all(gameState.rooms[gameState.currentRoomID].props) do
        spr(p.spriteID, p.x, p.y)
    end
    for t in all(gameState.rooms[gameState.currentRoomID].loadTriggers) do
        rectfill(t.x1, t.y1, t.x2, t.y2, 15)
    end

    -- draw player
    spr(player.spriteID, player.x, player.y)
end
