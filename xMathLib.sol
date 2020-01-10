pragma solidity ^0.5.12;


/// @title Math class
/// @author Amid
/// @notice You can do math with this library
/// @dev All function calls are currently implemented without side effects
library MathLib{
    uint constant public someNumber = 10;
    
    /// @author Amid
    /// @notice addes two unsigned-int256
    /// @dev can get generailized 
    /// @param x first number
    /// @param y second number
    /// @return sum of x and y
    function addXY(uint x, uint y) public pure returns(uint){
        return x+y;
    }
}