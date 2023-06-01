// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*
    Parent constructors are always called in the order of inheritance
    regardless of the order of parent contracts listed in the
    constructor of the child contract.
*/
contract S{
    constructor(uint s){}
}

contract T{
    constructor(uint t){}
}

// Execution order: S,T,V
contract V is S,T{
    constructor(uint v, uint s, uint t) S(s) T(t){}
}

// Execution order: S,T,V
contract V0 is S(0),T(1) {
    constructor(uint v){}
}

// Execution order: T,S,V
contract V1 is T,S{
    constructor(uint v1, uint s, uint t) S(s) T(t){}
}
