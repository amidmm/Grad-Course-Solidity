pragma solidity >=0.5.12;

contract owned {
    constructor() public { owner = msg.sender; }
    address payable public owner;
    
    event whoKilledMe(string killer);
}

contract mortal is owned {
    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }
}

contract Base1 is mortal {
    function kill() public {
        emit whoKilledMe("Base1");
        mortal.kill(); 
    }
}

contract Base2 is mortal {
    function kill() public { 
        emit whoKilledMe("Base2");
        // mortal.kill(); 
        super.kill(); 
    }
}

contract Final is Base1, Base2 {
}