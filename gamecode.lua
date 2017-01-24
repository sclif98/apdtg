--[[------------------------------------------------------------------------------

    -- NOTES --

    Generic for:
        for value in all(tbl) do

        for key, value in all(tbl) do

    User input:
        btn( [i,] [p] )
        @i --> the button number
        @p --> the player number

        arrow keys:
            0, 1, 2, 3 --> left, right, up, down arrows for player 0
            btn(0, 0) left
            btn(1, 0) right
            btn(2, 0) up
            btn(3, 0) down

]]------------------------------------------------------------------------------

WIDTH=128
HEIGHT=128
SPRITESIZE=8

spriteIDs = {
    spr_player=1,
    spr_cooler=64,
    spr_ok=70,
    spr_bookshelf=69
}

gameState = {
    clearColor = 0,
    currentRoomID = 1,

    player = {
        spriteID = 1,
        speed = 1,
        x = 100,
        y = 92
    },

    rooms = {
        {
            walls={
                {x1=0, y1=0, x2=128, y2=40, color=1},
                {x1=0, y1=100, x2=128, y2=128, color=1}
            },

            props={
                {x=0, y=92, spriteID=spriteIDs.spr_cooler},
                {x=64, y=70, spriteID=spriteIDs.spr_ok},
                {x=100, y=92, spriteID=spriteIDs.spr_cooler}
            },

            loadTriggers={
                {x1=10, y1=74, x2=20, y2=94, destRoomID=2, destPlayerX=64, destPlayerY=82}
            }
        },

        {
            walls={
                {x1=0, y1=0, x2=128, y2=30, color=3},
                {x1=0, y1=90, x2=128, y2=128, color=2}
            },
            props={
                {x=20, y=82, spriteID=spriteIDs.spr_cooler},
                {x=20, y=40, spriteID=spriteIDs.spr_ok},
                {x=80, y=50, spriteID=spriteIDs.spr_ok},
                {x=60, y=82, spriteID=spriteIDs.spr_bookshelf}
            },
            loadTriggers={
                {x1=100, y1=74, x2=110, y2=94, destRoomID=1, destPlayerX=64, destPlayerY=92}
            }
        }
    }
}

------------------------------------------------------------------------------

-- test whether two rectangles intersect
function rectCollide(a, b)
    if (a.x2 < b.x1) return false;
    if (a.x1 > b.x2) return false;
    if (a.y2 < b.y1) return false;
    if (a.y1 > b.y2) return false;
    return true;
end

function printRectData(rect, y, color)
    local text = "x1=" .. rect.x1 .. ", y1=" .. rect.y1 .. ", x2=" .. rect.x2 .. ", y2=" .. rect.y2
    print(text, 0, y, color)
end

------------------------------------------------------------------------------

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
