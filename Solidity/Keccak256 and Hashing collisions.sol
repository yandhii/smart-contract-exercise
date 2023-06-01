// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract HashFunc{
    string public s1 = "AAA";
    string public s2 = "BBB";

    string public s11 = "AA";
    string public s22 = "ABBB";

    uint constant public nonce = 10;

    function encode(string memory str1, string memory str2) external pure returns (bytes memory){
        return abi.encode(str1, str2);
    }

    function encodePacked(string memory str1, string memory str2) external pure returns (bytes memory){
        return abi.encodePacked(str1, str2);
    }

    // check if there is a collision
    // AAA BBB
    // AA ABBB
    function collisionHash() external view returns (bytes32, bool){
        bytes32  h1 = keccak256(abi.encodePacked(s1, s2));
        return  (h1, h1 == keccak256(abi.encodePacked(s11, s22)));
    }

    // check if there is a collision when add a nonce / use encode
    function collisionFreeHash() external view returns (bool){
        return 
        (keccak256(abi.encode(s1, s2)) != keccak256(abi.encode(s11, s22))) 
        && 
        (keccak256(abi.encodePacked(s1, nonce, s2)) != keccak256(abi.encodePacked(s11, nonce, s22)));
    }
}
