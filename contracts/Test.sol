pragma solidity ^0.4.24;

contract Test {
    
    int public x;

    event NewX(int newX);

    function setX(int _x) public { 
        x = _x;
        emit NewX(x);
    }
}
