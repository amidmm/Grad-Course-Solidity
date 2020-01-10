pragma solidity ^0.5.12;

// Abstract contract, interface and inheritance
contract Animal{
        // uint numberOfLegs;
        bool alive =true;
        
        // constructor(uint _numberOfLegs) public{
        //     numberOfLegs = _numberOfLegs;
        //     alive = true;
        // }
        
        function sound() public view returns(string memory);
        function isIntell() public pure returns(bool);
        function doesEat() public view returns(bool){
            if (alive){
                return true;
            }
            return false;
        }
}

contract Hunter{
    function useTools() public pure returns(bool);
}

contract Feline is Animal,Hunter{
    function isMammal() public pure returns(bool){
        return true;
    }
    function useTools() public pure returns(bool){
        return false;
    }
}

//concrete contract
contract Cat is Feline{
    function sound() public view returns(string memory){
        if (alive == true){
            return "meow";
        }
    }
    function isIntell() public pure returns(bool){
        return false;
    }
}

// order from most base to most derived
contract RightOrder is Animal, Feline{
    function sound() public view returns(string memory){
        if (alive == true){
            return "meow";
        }
    }
    function isIntell() public pure returns(bool){
        return false;
    }
}
// contract WrongOrder is Feline, Animal{
//     // WrongOrder request Animal to override Feline but Feline wants to override Animal
// }


