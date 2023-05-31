// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract BitwiseOperation{

    function and(uint x, uint y) external pure returns(uint){
        return x & y;
    }

    function or(uint x, uint y) external pure returns(uint){
        return x | y;
    }

    function not(uint x) external pure returns(uint){
        return ~x;
    }

    function bitWiseShiftLeft(uint x, uint n) external pure returns (uint){
        return x << n;
    }

    function bitWiseShiftRight(uint x, uint n) external pure returns (uint){
        return x >> n;
    }

    function lastNBits(uint x, uint n) external pure returns (uint){
        // x = 1110
        // mask = 0111
        // res = 0110
        // To get mask, we need to shift n bits and minus 1
        // 1 -> 1000 (n=3) -> 0111
        uint mask = 1 << n - 1;
        return x & mask;
    }

    function lastNBitsByMod(uint x, uint n) external pure returns (uint){
        return x % (1 << n);
    }
}
