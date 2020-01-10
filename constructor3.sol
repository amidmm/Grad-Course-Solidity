pragma solidity >=0.4.0 <0.7.0;


contract Base1 {
    event iAmHere(string);
    constructor() public {
        emit iAmHere("Base1");
    }
}

contract Base2 {
    event iAmHere(string);
    constructor() public {
        emit iAmHere("Base2");
    }
}

// Constructors are executed in the following order:
//  1 - Base1
//  2 - Base2
//  3 - Derived1
contract Derived1 is Base1, Base2 {
    constructor() public Base1() Base2() {
        emit iAmHere("Derived1");
    }
}

// Constructors are executed in the following order:
//  1 - Base2
//  2 - Base1
//  3 - Derived2
contract Derived2 is Base2, Base1 {
    constructor() public Base2() Base1() {
        emit iAmHere("Derived2");
    }
}

// Constructors are still executed in the following order:
//  1 - Base2
//  2 - Base1
//  3 - Derived3
contract Derived3 is Base2, Base1 {
    constructor() public Base1() Base2() {
        emit iAmHere("Derived3");
    }
}