--[[
    Type: Shared
    MACIEJ "Inder00" KLECZAJ <inder00@wp.pl, admin@multirpg.pl>.
    (©) 2024 All rights reserved exclusive to their author.
]]--

-- Random string generator
function generateRandomString(charset, length)
    local outputString = ""
    for i=1, length do
        local charNum = math.random( 1, #charset )
        outputString = outputString .. charset:sub( charNum, charNum )
    end
    return outputString
end