// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract BaseContract{
    int public x;
    address public owner;

    constructor() public{
        x = 7;
        owner = msg.sender;
    }

    function setX(int _x) public{
        x = _x;
    }
}

contract A is BaseContract{
    int public y;
}
