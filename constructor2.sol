pragma solidity >=0.5.12;

contract Base {
    uint public x;
    constructor(uint _x) public { x = _x; }
}

// Either directly specify in the inheritance list...
// static way
contract Derived1 is Base(7) {
    constructor() public {}
}

// or through a "modifier" of the derived constructor.
//dynamic way
contract Derived2 is Base {
    constructor(uint _y) Base(_y * _y) public {}
}