--[[
    Type: Clientside
    MACIEJ "Inder00" KLECZAJ <inder00@wp.pl, admin@multirpg.pl>.
    (©) 2024 All rights reserved exclusive to their author.
]]--

-- Generate client-side keypair and saves it to local file
-- returns base64 encoded private and public key or false otherwise
-- string, string generateLoginKeyPair( [ int keySize = 2048 ], [ string keypairPath = "@keypair.json" ] )
function generateLoginKeyPair( keySize, keypairPath )

    -- key size argument check
    if keySize and type(keySize) ~= "number" then return false end

    -- keypair path argument check
    if keypairPath and type(keypairPath) ~= "string" then return false end

    -- generate login key pair
    local privateKey, publicKey = generateKeyPair( "rsa", { size = keySize or 2048 } )
    if privateKey and publicKey then

        -- encode private key and public key
        local base64PrivateKey = encodeString( "base64", privateKey )
        local base64PublicKey = encodeString( "base64", publicKey )

        -- save login key pair to the file
        local keypairFile = fileCreate( keypairPath or "@keypair.json" )
        fileWrite( keypairFile, toJSON( { privateKey = base64PrivateKey, publicKey = base64PublicKey, checksum = md5( base64PrivateKey .. base64PublicKey ) } ) )
        fileFlush( keypairFile )
        fileClose( keypairFile )

        -- return key pair
        return base64PrivateKey, base64PublicKey

    end

    -- failed to generate key pair
    return false

end

-- Loads client-side keypair from the file to the cache
-- returns true is login key pair has been loaded successfully or false otherwise
-- boolean loadLoginKeyPair( [ string keypairPath = "@keypair.json" ] )
function loadLoginKeyPair( keypairPath )

    -- keypair path argument check
    if keypairPath and type(keypairPath) ~= "string" then return false end

    -- check does file exists
    if not fileExists( keypairPath or "@keypair.json" ) then return false end

    -- load login key pair from the file
    local keypairFile = fileOpen( keypairPath or "@keypair.json", true )
    if keypairFile then

        -- load contents of the file
        local keypairFileContent = fileRead( keypairFile, fileGetSize( keypairFile ) )
        fileClose( keypairFile )

        -- parse file as a json table
        local keypairJson = fromJSON( keypairFileContent )
        if keypairJson and type( keypairJson ) == "table" then

            -- verify checksum
            if md5( (keypairJson.privateKey or "undefined") .. (keypairJson.publicKey or "undefined") ) == (keypairJson.checksum or "undefined") then

                -- cache key pair locally and calcualte fingerprint
                CacheData.loginPrivateKey = decodeString( "base64", keypairJson.privateKey )
                CacheData.loginPublicKey = decodeString( "base64", keypairJson.publicKey )
                CacheData.loginFingerprint = hash("sha512", keypairJson.publicKey ):upper()

                -- successfully read client-side key pair
                return true

            end

        end

    end

    -- failed to load client-side key pair
    return false

end

-- Process login challenge from the server
-- returns decoded login challenge or false otherwise
-- string processLoginChallenge( string loginChallenge )
function processLoginChallenge( loginChallenge )

    -- login challenge argument check
    if not loginChallenge then return end
    if type(loginChallenge) ~= "string" then return end
    
    -- check does private key exists
    if CacheData.loginPrivateKey and type( CacheData.loginPrivateKey ) == "string" then

        -- try to decode login challenge
        local decodedLoginChallenge = decodeString( "rsa", loginChallenge, { key = CacheData.loginPrivateKey } )
        if decodedLoginChallenge and type(decodedLoginChallenge) == "string" then

            -- return decoded login challenge
            return decodedLoginChallenge

        end

    end

    -- failed to decode login challenge
    return false

end

-- Gets login key pair public key
-- returns login public key or false otherwise
-- string getLoginPublicKey()
function getLoginPublicKey()

    -- check does public key exists
    if CacheData.loginPublicKey and type(CacheData.loginPublicKey) == "string" then

        -- return public key
        return CacheData.loginPublicKey

    end

    -- public key doens't exists
    return false
    
end

-- Gets login key pair fingerprint
-- returns login fingerprint or false otherwise
-- string getLoginFingerprint()
function getLoginFingerprint()

    -- check does public key exists
    if CacheData.loginFingerprint and type(CacheData.loginFingerprint) == "string" then

        -- return fingerprint
        return CacheData.loginFingerprint

    end

    -- fingerprint doens't exists
    return false
    
end