// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract IterableMapping{
    mapping(address => uint256) balance;
    mapping(address => bool) inserted;
    address[] public keys;

    function set(address _key, uint _val) public{
        balance[_key] = _val;
        if (!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }    
    }

    function getSize() public view returns (uint256){
        return keys.length;
    }

    function first() public view returns (uint256){
        return balance[keys[0]];
    }

    function last() public view returns (uint256){
        return balance[keys[keys.length-1]];
    }

    function get(uint256 _index) public view returns (uint256){
        return balance[keys[_index]];
    }
}
