// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract TestDelegateCall{
    address public sender;
    uint public num;
    uint public value;

    function setVars(uint _num) external payable {
        sender = msg.sender;
        num = _num;
        value = msg.value;
    }

}

contract DelegateCall{
    /*
        Note that if the order of variable is different from TestDelegateCall,
        the result will be pretty wired due to the strorage layout
    */
    uint public num;
    uint public value;
    address public sender;
    
    function setVars(address _test, uint _num) external payable {
        // abi.encodeWithSignature
        // (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        // require(success, "delegatecall failed");

        // abi.encodeWithSelector
        (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num));
        require(success, "delegatecall failed");
    }
}
