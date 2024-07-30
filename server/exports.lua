--[[
    Type: Serverside
    MACIEJ "Inder00" KLECZAJ <inder00@wp.pl, admin@multirpg.pl>.
    (©) 2024 All rights reserved exclusive to their author.
]]--

-- Generate server-side login challenge and encodes it using given public key
-- returns as the first argument raw challenge login and as the second argument encrypted challenge login or false otherwise
-- string, string generateLoginChallenge( string publicKey, [int challengeLength = 196] )
function generateLoginChallenge( publicKey, challengeLength )

    -- public key argument check
    if not publicKey then return false end
    if type(publicKey) ~= "string" then return false end

    -- challenge length argument check
    if challengeLength and type(challengeLength) ~= "number" then return false end

    -- generate login challenge and encode it
    local loginChallenge = generateRandomString("QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890-_+#.,/", challengeLength or 196)
    local encodedChallenge = encodeString( "rsa", loginChallenge, { key = publicKey } )

    -- check does challenge has been encoded
    if encodedChallenge and type(encodedChallenge) == "string" then

        -- return challenge
        return loginChallenge, encodedChallenge

    end

    -- failed to generate login challenge
    return false

end