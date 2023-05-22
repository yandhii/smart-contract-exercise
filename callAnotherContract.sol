// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract callTestContract{
    function getX(TestContract _test) external view returns(uint) {
        return _test.getX();
    }

    function setX(address _test, uint _x) external{
        TestContract(_test).setX(_x);
    }

    function setXandSendEther(address _test, uint _x) external payable{
        TestContract(_test).setXandReceiveEther{value:msg.value}(_x);
    }
}

contract TestContract{
    uint public x;
    uint public value=123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() public view returns(uint){
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
    }
}
