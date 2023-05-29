// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

library Math{
    function max(uint x, uint y) internal pure returns (uint){
        return x > y ? x : y;
    }
}

library ArrayLib{
    function find(uint[] storage _arr, uint _value) internal view returns(uint){
        for(uint i=0; i < _arr.length; i++){
            if(_arr[i] == _value){
                return i;
            }
        }
        revert("Not find");
    }
}

contract TestLibrary{
    using Math for uint;
    using ArrayLib for uint[];
    uint public x;
    uint public y;
    uint[] public arr = [1,2,3];

    // 4635 gas
    function TestMath1() external view  returns(uint){
        return Math.max(x,y);
    }
    
    // 4672 gas
    function TestMath2() external view returns(uint){
        return x.max(y);
    }

    // 10069 gas
    function testArray1() external view returns(uint){
        return ArrayLib.find(arr,3);
    }

    // 10062 gas
    function testArray2() external view returns (uint){
        return arr.find(3);
    }
}
