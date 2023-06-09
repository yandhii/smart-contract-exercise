// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract MultipleOutput{
    function test1() public pure returns (uint, bool){
        return (1,true);
    }

    function test2() public pure returns (uint x, bool b){
        x = 1;
        b = true;
    }

    function test3() public pure returns (uint x, bool b){
        return (1, true);
    }

    function destructAssignments1() public pure returns(uint x, bool b){
        (x, b) = test1();
    }

    function destructAssignments2() public pure returns(uint, bool){
        (, bool b) = test1();
        uint a = 5;
        return (a,b);
    }

}
