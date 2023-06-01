// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract FunctionSelector{
    event Log(bytes data);

    // msg.data: encode(function name || parameters), || means concatenate
    // encode: encode(m) = keccak256(m)
    // function name: first 4 bytes (8 hex chars) 0xa9059cbb
    // parameters: each parameter has 32 bytes
    // _to: 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
    // _amount: 000000000000000000000000000000000000000000000000000000000000000b
    function transfer(address _to, uint256 _amount) external{
        emit Log(msg.data);
    }

    // _func: "transfer(address,uint256)"
    // return: "transfer(address,uint256)"
    // 956 gas
    function getFunctionSelector1(string calldata _func) external pure returns (bytes4){
        return bytes4(keccak256(bytes(_func)));
    }

    // 1042 gas
    function getFunctionSelector2(string calldata _func) external pure returns (bytes4){
        return bytes4(keccak256(abi.encodePacked(_func)));
    }
}
