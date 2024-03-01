// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Good {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setOwner(address _owner) public {
        require(tx.origin == owner, "You are not the owner");
        owner = _owner;
    }
}
