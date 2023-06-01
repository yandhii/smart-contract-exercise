// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*
    fallback is a special function that is executed either when
    a function that does not exist is called or
    Ether is sent directly to a contract but receive() does not exist or msg.data is not empty
    fallback has a 2300 gas limit when called by transfer or send.
*/
contract Fallback{
    event Log(string func, address sender, uint value, bytes data);
    fallback() external payable{
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    receive() external payable{
        emit Log("receive", msg.sender, msg.value, "");
    }
}
