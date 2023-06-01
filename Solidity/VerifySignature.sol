// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/* Signature Verification

How to Sign and Verify
# Signing
1. Create message to sign
2. Hash the message
3. Sign the hash (off chain, keep your private key secret)

# Verify
1. Recreate hash from the original message
2. Recover signer from signature and hash
3. Compare recovered signer to claimed signer
*/
contract VerifySignature{
    /* 1. Unlock MetaMask account
    ethereum.enable()
    */

    /* 2. Get message hash to sign
    getMessageHash(
        "hi"
    )

    hash = "0xcf36ac4f97dc10d91fc2cbb20d718e94a8cbfe0f82eaedc6a4aa38946fb797cd"
    */

    // get message hash
    function getMessageHash(string memory _message) public pure returns (bytes32){
        return keccak256(abi.encodePacked(_message));
    }

    /* 3. Sign message hash
    # using browser
    account = "0x554b74531ed763220b6b1d594d64b249171a3ee2"
    hash = "0x7624778dedc75f8b322b9fa1632a610d40b85e106c7d9bf0e743a9ce291b9c6f"
    ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)

        
    # using web3
    web3.personal.sign(hash, web3.eth.defaultAccount, console.log)

    Signature will be different for different accounts
    sig: 0xbe19961f50e467fd9db49abcad1ddf0c03b05df722a00b426adb5f4ed53273fd7966a94f40f1e3418ce55266ff57fbd2f7323a01f957ec5eae2fc6cba3aba77f1b
    */

    // get eth signed message hash:
    // 1. add prefix \x19Ethereum Signed Message:\n32 to message
    // 2. hash new message again
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns(bytes32){
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    // split signature to r,s,v
    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v){
        require(_sig.length == 65,"Invalid signature length");

        assembly{
            // first 32 bytes is length of bytes, so we skip it
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            // v with uint8 type, 8 bits = 1 byte, so we take the first byte of v
            v := byte(0, mload(add(_sig, 96)))
        }
    }

    // recover signer address from eth signed hash and original signature
    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns (address){
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    /* 4. Verify signature
    signer = 0x554b74531ed763220b6b1d594d64b249171a3ee2
    message = "hi"
    signature =
        0xbe19961f50e467fd9db49abcad1ddf0c03b05df722a00b426adb5f4ed53273fd7966a94f40f1e3418ce55266ff57fbd2f7323a01f957ec5eae2fc6cba3aba77f1b
    */

    // verify if the recovered signer is the true signer
    function verify(address _signer, string memory _message, bytes memory _sig) 
    external pure returns (bool){
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMessageHash, _sig) == _signer;
    }
}
