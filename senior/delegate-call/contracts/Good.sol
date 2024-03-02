// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Good {
    address public helper;
    address public owner;
    uint public num;

    constructor(address _helper) {
        helper = _helper;
        owner = msg.sender;
    }

    function setNum(uint _num) public {
        helper.delegatecall(abi.encodeWithSignature("setName(uint256)", _num));
    }
}
