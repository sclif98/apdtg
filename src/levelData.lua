--[[
    levelData.lua
]]


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
                {x1=0, y1=90, x2=128, y2=128, color=6}
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
