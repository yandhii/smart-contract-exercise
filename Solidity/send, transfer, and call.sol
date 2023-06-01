// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SendEther{
    uint256 constant amount = 123;

    constructor() payable {}
    fallback() external payable {}
    receive() external payable {}

    function sendViaTransfer(address payable _to) public{
        _to.transfer(amount);
    }

    function sendViaSend(address payable _to) public{
        bool flag = _to.send(amount);
        require(flag,"Send failed");
    }

    function sendViaCall(address payable _to) public{
        (bool flag, ) = _to.call{value:amount}("");
        require(flag,"Call failed");
    }
}

contract EtherReceiver{
    event Log(uint value, uint gasLeft);

    fallback() external payable {
        emit Log(msg.value, gasleft());
    }
    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
