# MTA Login Wrapper 💡
🍎 This is a login wrapper for [Multi Theft Auto: San Andreas](https://mtasa.com/) and is designed for easy interacting with functions.

🎉The reason I released this wrapper is because I would like to save hours of working on scripting.
Finally, I am glad to provide the `MTA Login Wrapper`, and everyone is welcome to adjust the code and help make it better by editting the code, adding functions or events.

# Clientside functions 🖌️
* **string, string generateLoginKeyPair( [ int keySize = 2048 ], [ string keypairPath = "@keypair.json" ] )**
    * Generates client-side keypair and saves it to local file
    * Returns base64 encoded private and public key or false otherwise
    * Example of usage:
    ```lua
    local privateKey, publicKey = generateLoginKeyPair()
    if privateKey and publicKey then
        iprint("Successfully generated login key pair and saved it to the local file")
    else
        iprint("Failed to generate login key pair")
    end
    ```



* **boolean loadLoginKeyPair( [ string keypairPath = "@keypair.json" ] )**
    * Loads client-side keypair from the file to the cache
    * Returns true is login key pair has been loaded successfully or false otherwise
    * Example of usage:
    ```lua
    local keypairLoaded = loadLoginKeyPair()
    if keypairLoaded then
        iprint("Key pair has been successfully loaded to the cache")
    else
        iprint("Failed to load login key pair")
    end
    ```

* **string getLoginPublicKey()**
    * Gets login key pair public key
    * Returns login public key or false otherwise
    * Example of usage:
    ```lua
    local publicKey = getLoginPublicKey()
    iprint("Public key of the login key pair", encodeString("base64", publicKey))
    ```

* **string getLoginFingerprint()**
    * Gets login key pair fingerprint
    * Returns login fingerprint or false otherwise
    * Example of usage:
    ```lua
    local loginFingerprint = getLoginFingerprint()
    iprint("Fingerprint of the login key pair", loginFingerprint)
    ```

* **string processLoginChallenge( string loginChallenge )**
    * Process encoded login challenge from the server and decodes it using cached private key
    * Returns decoded login challenge or false otherwise
    * Example of usage:
    ```lua
    local encodedChallenge = decodeString("base64", "h2RDF19QILBnzxF4B0Bd4ZohWHyoUdzZYi1ka/H++uOOsljoPlSTyR8BJhyd9AkgfiUZ4wpmTCH4C7P90HyhLHvkxGHwh8nImab6RCTxLhNO//gLhbL+IutdAYwDmoG5+Dlboh6tCTcq64hb1rGaWiDbzDam9fmzoVbr40CfJsT6UYZMemqiPn29EKRJQRgrMeu3OT1sndU9NF34Aln0Uu8funELtNr8iJo+FC/8ZRbuk0OzCGXyHYgvpb9JFoJl+iN7Z9+HyKAkIEhrhWJjthR34iQAjP1fyDvqkLa8sXyjANJPfXpU8A5zZjMBavemVRhh72qEnING1I+2tEx6PQ==") -- server sent raw rsa encoded data
    iprint( "Lq+0vUK9/KrDTzmonhbxv5cFpP#7tNSofbYB3d8xWOewog0CH/bpbTX#2..D4kR0Y6nbc1mAs+DJ.z.uaan8oLDacyK71eVJD3,QxYEOVvQGH3B+#ey+fDLCrKAT5a3pF-Tmuzau/vXVunAb3Iva4BHlOZAl6h5mC4w.DrcUPijPZ,I7DMy#aUC#2n0_IWo.xqaJ" == processLoginChallenge(encodedChallenge) )
    ```

# Serverside functions 🖌️
* **string, string generateLoginChallenge( string publicKey, [int challengeLength = 196] )**
    * Generate server-side login challenge and encodes it using given public key
    * Returns as the first argument raw challenge login and as the second argument encrypted challenge login or false otherwise
    * Example of usage:
    ```lua
    local clientPublicKey = decodeString("base64", "MIIBIDANBgkqhkiG9w0BAQEFAAOCAQ0AMIIBCAKCAQEAxUDXDaxzIhu7QchJNLgkYaWgkmJRA5ZzoNZVHm65V\/MlQUMi8gSUYimW7LyjQ4jze+08O2zacBQzeVCbtljZE++aMTPuZTIAQS5FF3u\/ZrEx8XD9tPnWfmE8Yb2Y5D0rBFjvr5yxFElQRd7oo03y\/FZVD0MrbUGy3dkJEk4R1P1pBGRpRw8X41rAg2WFZD+u601sa+HiFem+QmYzaJDLZUdINsJdm9o6vDwit1zkHBcpdso\/m0z1RKU\/OX8wSARV395d3QjmiqJMwdVxqF00dzFyv62pR5ftlZUu\/k8dgnLeJzMqTO8W1SO2ZQ9elU+zSksUwpXUPx+Gqz4xAMAJpwIBEQ==") -- client sent raw rsa public key
    local rawChallenge, encodedChallenge = generateLoginChallenge( clientPublicKey )
    iprint("Raw data of the challenge", rawChallenge)
    iprint("Encoded data of the challenge", encodeString("base64", encodedChallenge))
    ```

# Diagram showing example use in production version 🎱
#### Below is shown the implementation used on a [MultiRPG](https://multirpg.pl/) server on Multi Theft Auto: San Andreas platform.

![Diagram](diagram.png?raw=true "Diagram")

# Contribution ❤️

The most powerful feature of open source projects is developers community❤️. Everyone is welcome and will be written
below 🔥.

# Thanks for your support.❤️