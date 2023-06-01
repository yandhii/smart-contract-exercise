// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Counter{
    uint public counter;

    function count() external  view returns(uint){
        return counter;
    }
    
    function inc() external {
        counter += 1;
    }

    function dec() external {
        counter -= 1;
    }
}

interface ICounter {
    function count() external  view returns (uint);
    function inc() external;
    function dec() external;
}

contract callInterface{
    uint public count;
    function examples(address _counter) external returns (uint){
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
        return count;
    }
}
