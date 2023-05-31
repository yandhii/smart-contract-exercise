// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// gas golf
contract GasGolf {
    // start - 50908 gas
    // use calldata - 49163 gas
    // load state variables to memory - 48952 gas
    // short circuit - 48634 gas
    // loop increments - 48244 gas
    // cache array length - 48209 gas
    // load array elements to memory - 48047 gas
    // uncheck i overflow/underflow - 47309 gas

    uint public total;

     function sumIfEvenAndLessThan99(uint[] calldata nums) external {
         // cache array length
         uint len = nums.length;
         // load state vriables to memory
         uint _total = total;
         for (uint i = 0; i < len;) {
             // short circuit
             if (nums[i] % 2 == 0 && nums[i] < 99) {
                 _total += nums[i];
            }
            // unchecked integer overflow/underflow
            unchecked{
                ++i;
            }
         }
         total = _total;
     }

}
