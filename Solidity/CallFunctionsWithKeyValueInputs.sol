// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract CallFunction{

    function test1(uint[] calldata arr, address addr, uint x) public  pure returns (uint, address, uint){
        return (arr[0], addr, ~x);
    }

    function callTestFunc1(uint[] calldata arr, address addr, uint x) external pure returns(uint, address, uint){
        return test1(arr, addr, x);
    }

    function callTestFunc2(uint[] calldata arr, address addr, uint x) external pure returns(uint, address, uint){
        return test1({
            arr:arr,
            addr:addr,
            x:x
        });
    }
}
