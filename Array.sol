// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array {
    // Several ways to initialize an array
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // Fixed sized array, all elements initialize to 0
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // Solidity can return the entire array.
    // But this function should be avoided for
    // arrays that can grow indefinitely in length.
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // Append to array
        // This will increase the array length by 1.
        arr.push(i);
    }

    function pop() public {
        // Remove last element from array
        // This will decrease the array length by 1
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }

    function examples() external pure returns (uint[] memory a){
        // create array in memory, only fixed size can be created
        a = new uint[](5);
    }

    // Not gas-efficient but can reserve order
    // [1,2,3,4] => remove(1) => [1,3,4]
    function removeByShifting(uint _index) public{
        for(uint i=_index; i < arr.length-1;i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    // More gas efficient but it will shuffle the order
    // [1,2,3,4] => remove(1) => [1,4,3]
    function removeByReplacing(uint _index) public {
        arr[_index] = arr[arr.length-1];
        arr.pop();
    }
}
