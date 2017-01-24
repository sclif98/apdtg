--[[
    compiles the project into one pico-8 cartridge file
]]

-- stolen from http://lua-users.org/wiki/StringRecipes
function stringStarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- stolen from http://stackoverflow.com/questions/1426954/split-string-in-lua
function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function parseCode(main)
    -- substitute @import statements w/ the full text of the filename given

    local lines = mysplit(main, "\n")

    for number, line in pairs(lines) do
        --print(number .. ": " .. line)
        if stringStarts(line, "--@import") then
            local words = mysplit(line, " ")
            local filenameToImport = words[2]

            local importFile = assert(io.open(filenameToImport, "r"))
            local importFileContents = importFile:read("*all")
            importFile.close()

            table.remove(lines, number)
            table.insert(lines, number, importFileContents)
        end
    end

    return table.concat(lines, "\n")
end

-- load the header
local cartHeaderFile = assert(io.open("cartHeader.txt", "r"))
local cartHeader = cartHeaderFile:read("*all")
cartHeaderFile.close()

-- load the footer
local cartFooterFile = assert(io.open("assets.txt", "r"))
local cartFooter = cartFooterFile:read("*all")
cartFooterFile.close()

-- load the main source file
local mainSourceCodeFile = assert(io.open("main.lua", "r"))
local mainSourceCode = mainSourceCodeFile:read("*all")
mainSourceCodeFile.close()

-- compile 
local fullSourceCode = parseCode(mainSourceCode)

-- create/overwrite existing cartridge
local cartFile = io.open("demo.p8", "w")
io.output(cartFile)
io.write(cartHeader, fullSourceCode, cartFooter)
cartFile.close()
