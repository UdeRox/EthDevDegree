// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Good {
    address public currentWinner;
    uint public currentActionPrice;

    constructor() {
        currentWinner = msg.sender;
    }

    function setCurrentActionPrice() public payable {
        require(
            msg.value > currentActionPrice,
            "Need to pay more than the current Action Price!"
        );
        (bool sent, ) = currentWinner.call{value: currentActionPrice}("");
        if (sent) {
            currentActionPrice = msg.value;
            currentWinner = msg.sender;
        }
    }
}
