pragma solidity ^0.5.12;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/Math.sol";
import "./xMathLib.sol";

contract varTypes{
    int intVar =1_345_678;     // int256
    int8 int8Var;
    // goes up to int256 with step of 8
    uint uintVar;   //uint256
    uint8 uint8Var;     
    // goes up to uint256
    
    //fixed and unfixed 
    //BUT NOT YET :)
    // fixed256x10 public fixType;
    // ufixed8x2 public ufixType;
    
    //float is currently not supported in solidity :D
    
    // addres type
    address contractAddr= address(this);
    address payable contractAddrPay = address(uint160(address(this)));
    
    function dumbTransfer() public payable{
        // it automatically reverts in case of error
        // contractAddrPay.transfer(msg.value- 1 ether);
        // xGettingNothing g = new xGettingNothing();
        // address(g).transfer(msg.value - 1 ether);
    }
    
    function currentBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function() external payable{}
    
    function dumbSend() public payable returns(bool result){
        // You should check the returned value of send
        // 2300 gas limited
        xGettingNothing g = new xGettingNothing();
        result = address(g).send(msg.value -100 wei);
    }
    // there is a call function for address but we don't teach it here. value(),gas()
    
    
    // contract type 
    // we have seen this above :)
    function contractName() public pure returns(string memory){
        // there are type(C).creationCode and type(C).runtimeCode
        return type(xGettingNothing).name;
    }
    
    // Fixed size array
    bytes1 bytes1Array; // same as byte
    byte byteVar;
    bytes32 bytes32Array;
    uint[10] fixedUint10;
    
    // Dynamic sized array
    bytes bytesVar;
    byte[] byteArray; //but due to padding rules, it wastes 31 bytes of space for each element (except in storage) 
    uint bytesVarLength = bytesVar.length;
    uint[] public uintArry = [1,2,3];
    // array are ref types
    // for ref type you should specifiy the location (memory | storage | calldata)
    // memory: they will die with the function (like ram memory)
    // storage: unlike the memory it won't die with function (like hard disk)
        // all the state variables are storage variables
    //calldata: we don't get into it for now
        /*
          Assignments between storage and memory (or from calldata) always create an independent copy
          Assignments from memory to memory only create references.
          Assignments from storage to a local storage variable also only assign a reference.
          All other assignments to storage always copy. Examples for this case are assignments to state variables or to members of local variables of storage struct type, even if the local variable itself is just a reference
          */
    function f(uint len) public pure {
        uint[] memory a = new uint[](7);
        bytes memory b = new bytes(len);
        assert(a.length == 7);
        assert(b.length == len);
        a[6] = 8;
    }
    // fixed sized array cannot be assigned to dynamically-sized memory arrays 
    // uintArry is storage :)
        // function fixToDyn() public {
        //     // The next line creates a type error because uint[3] memory
        //     // cannot be converted to uint[] memory.
        //     uint[] memory x = [uint(1), 3, 4];
        // }
    function addToUintArray(uint newValue) public{
        uintArry.push(newValue);
    }
    function removeFromUintArray() public{
        uintArry.pop();
    }
    // string doesn't have length, pop, push :)
    
    // 2d arrays
    bool[2][] m_pairsOfFlags; // this is a dynamic list of two element arrays :D
    bool[][2] two_pairsOfArrays; // this are two array which can have dynamic size :D
    // You cannot use multidimential arry as parameter or return value :D
        // current ABI limitation
        // strings are arrays so string[] is a 2D array :D
        // you have to serialize the array
        // function param2D(bytes[] memory data) public{}
        // function return2D() public returns(bytes[] memory){}
    
    
    // enum 
    // starting form zero
    enum programmerState { sleeping, coding, eating}
    programmerState myState = programmerState.coding;
    function letsSleep() public returns(programmerState){
        if (myState == programmerState.coding) // the parentheses are needed
            myState = programmerState.sleeping;
        else
            myState = programmerState.eating;
        return myState;
    }
    
    // struct 
    // it's a ref type
    struct bankAccount{
        uint userId;
        string f_name;
        string l_name;
        address payable accountAddr;
    }
    
    // mapping       [key=>value]
    // ref type - mapping a key to a value - it's equ of dictionary or hashtable
    // keys cannot be user defined types or array except bytes or string
    // if you need keys you should store it manually - every possible key is mapped to its value or default value 
        // nothing like python dic.keys()
    mapping(address => uint) balance;
    function invest() public payable returns (uint){
        balance[msg.sender] += msg.value;
        return balance[msg.sender];
    }
    // storage only
        // cannot be param or return of public function
        // function paramMap(mapping(address=>uint) memory _balance) public {}
        // function paramMap(mapping(address=>uint) storage _balance) private {}
        // function returnMap() private returns(mapping(address=>uint) storage){}
    
    
    
    // Delete
    // delete X     assign initial value to X
    function entryDelete() public returns(uint[] memory){
        delete uintArry[0];
        return uintArry;
    }
    function varDelete() public returns(uint[] memory){
        delete uintArry;
        return uintArry;
    }
    function mapDelete() public returns(uint){
        delete balance[msg.sender];
        return balance[msg.sender];
    }
    // as keys are not stored you cannot do:
        // delete MAP
        // function mapDelete() public returns(uint){
        //     delete balance;
        //     return balance[msg.sender];
        // }
    
    
    
    
    //function type
    // function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]
    // pure: not even reading state
    // view: read state but not changing it
    // payable: accepts ether
    
    
    // conversion
    // for numbers it paddes from left
    // for bytes it paddes from right
    // be careful!!!
    
    
    
    // library
    uint x = Math.max(1,2);
    uint x2 = MathLib.addXY(1,2);
    
    
    // event
    event logData(string indexed _name,uint _guess);
    
    function fireEvent(string memory name, uint guess) public {
        emit logData(name, guess);
    } 
    
    // comment and NatSpec
    // compiler understands the NatSpec tags
    /*
    this 
    is comment
    */
    
    /**
     * 
     * 
     * 
     * */
    ///
    
    
    
    // time and ether unit
        /*
        1 wei == 1
        1 szabo == 1e12
        1 finney == 1e15
        1 ether == 1e18
        */
        
        /*
        1 == 1 seconds
        1 minutes == 60 seconds
        1 hours == 60 minutes
        1 days == 24 hours
        1 weeks == 7 days
        */

    // if and for
    function addressEmpty() public view returns (bool){
        if (contractAddr == address(0)){
            return true;
        } else if (contractAddr == address(this)){
            return false;
        } else {
            return false;
        }
    }
    
    // for
    function sum2N(uint n) public pure returns (uint sum){
        uint i;
        for(i=0; i<n;i++){
            sum += i;
        }
        while(i<=2*n){
            sum +=i;
            i++;
        }
    }
    
    
    // overlaoding function
    // different params not different returns
    function addressEmpty(address _address) public pure returns(bool){
        if (_address == address(0))
            return true;
        return false;
    }



    // Abstract contract, interface and inheritance
    // Go to buttom of page
    
    
    

    // block and tx prop.
    
    
    // Error handling
    // state reverting error handling
    
    
    
    // selfdestruct
    // it has security problem if you send money to contract it will be ruined 
    // instead do a state check and revert
    address owner;
    constructor() public{
        owner=msg.sender;
    }
    function killMe() public {
        require(owner==msg.sender,"You are not the owner");
        selfdestruct(msg.sender);
    }
    //better way
    bool killed =false;
    function betterKillMe() public{
        require(owner==msg.sender,"You are not the owner");
        killed = true;
    }
    modifier isKilled(){
        require(killed==false, "the contract is not available");
        _;
    }
    
    
    
    
    // security

    
}


contract xGettingNothing{
    int intVar;
    function() external payable{
        // do anything other than emit an event to get an error (anything useful)
        intVar++;
    }
    function currentBalance() public view returns(uint){
        return address(this).balance;
    }
}








