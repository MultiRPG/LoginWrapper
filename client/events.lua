--[[
    Type: Clientside
    MACIEJ "Inder00" KLECZAJ <inder00@wp.pl, admin@multirpg.pl>.
    (©) 2024 All rights reserved exclusive to their author.
]]--

-- List of events
Events = {

    -- resource start
    {
        name = "onClientResourceStart",
        exec = function()

            -- load login key pair from the file
            local keypairLoaded = loadLoginKeyPair()
            if not keypairLoaded then

                -- generate client-side key pair and load it
                local keypairGenerated = generateLoginKeyPair()
                if keypairGenerated then

                    -- load key pair again
                    loadLoginKeyPair()

                end

            end

        end,
    },

}

-- events
for key, event in pairs(Events) do

    -- asserts
    assert( type( event.name ) == "string", "Invalid field name @ Events(" .. key .. ") [string expected, got " .. type( event.name ) .. "]" )
    assert( type( event.exec ) == "function", "Invalid field exec @ Events(" .. key .. ") [function expected, got " .. type( event.exec ) .. "]" )
    assert( isElement( (event.attachedTo or resourceRoot) ), "Invalid field attachedTo @ Events(" .. key .. ") [element expected, got " .. type( event.attachedTo ) .. "]" )

    -- add event
    addEventHandler(event.name, event.attachedTo or resourceRoot, event.exec)

end