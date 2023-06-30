// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MultiSig {
    address[] public owners;
    uint public transactionCount;
    uint public required;

    struct Transaction {
        address to;
        uint val;
        bool executed;
        bytes data;
    }

    mapping(uint => Transaction) public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;

    constructor(address[] memory _owners, uint _confirmations) {
        require(_owners.length > 0);
        require(_confirmations > 0);
        require(_confirmations <= _owners.length);
        owners = _owners;
        required = _confirmations;
    }

    modifier onlyOwner{
        uint n = owners.length;
        bool isCurAddrOwner;
        for(uint i; i < n;){
            if(owners[i] == msg.sender){
                isCurAddrOwner = true;
                break;
            }
            unchecked{
                ++i;
            }
        }
        require(isCurAddrOwner);
        _;
    }

    function getConfirmationsCount(uint transactionId) public view returns(uint) {
        uint count;
        uint n = owners.length;
        for(uint i; i < n;) {
            if(confirmations[transactionId][owners[i]]) {
                unchecked{
                    ++count;
                }
            }
            unchecked{
                ++i;
            }
        }
        return count;
    }

    function confirmTransaction(uint transactionId) public onlyOwner{
        confirmations[transactionId][msg.sender] = true;
        if(isConfirmed(transactionId)){
            executeTransaction(transactionId);
        }
    }

    function addTransaction(address to, uint val, bytes calldata data) internal returns(uint) {
        transactions[transactionCount] = Transaction(to, val, false, data);
        return transactionCount++;
    }

    function submitTransaction(address to, uint val, bytes calldata data) external{
        uint transactionId = addTransaction(to, val, data);
        confirmTransaction(transactionId);
    }

    function isConfirmed(uint transactionId) public view returns(bool){
        return getConfirmationsCount(transactionId) >= required;
    }

    function executeTransaction(uint transactionId) public {
        require(isConfirmed(transactionId));
        Transaction storage _tx = transactions[transactionId];
        _tx.executed = true;
        (bool success, ) = _tx.to.call{ value: _tx.val }(_tx.data);
        require(success);
    }

    receive() external payable {}

}
