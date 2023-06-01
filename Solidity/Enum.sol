// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Enum{
    enum Status{
        None,
        shipped,
        finished
    }

    Status public status;

    function get() public view returns (Status){
        return status;
    }

    function set(Status _status) external{
        status = _status;
    }

    function reset() external{
        delete status;
    }

    function ship() external{
        status = Status.shipped;
    }
}
