// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Array{
    uint [] public nums = [1,2,3];
    uint [3] public fixedNums = [4,5,6];

    function examples() public{
        nums.push(4);
        uint x = nums[0];
        nums[1] = 55;
        delete nums[1];
        nums.pop();
        uint len = nums.length;

        uint[] memory a = new uint[](5);
    }

    function see() public view returns(uint[] memory){
        return nums;
    }

    function remove(uint _index) public {
        require(_index < nums.length, "Array out of bound");
        for(uint i=_index; i < nums.length-1; i++){
            nums[i] = nums[i+1];
        }
        nums.pop();
    }
}
