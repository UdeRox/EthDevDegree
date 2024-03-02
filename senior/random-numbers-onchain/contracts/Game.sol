// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Game {
    constructor() payable {}

    function pickCard() private view returns (uint256) {
        uint256 pickedCard = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number), block.timestamp)
            )
        );
        return pickedCard;
    }

    function guess(uint256 _guess) public {
        uint256 _pickedCard = pickCard();
        if (_guess == _pickedCard) {
            (bool sent, ) = msg.sender.call{value: 1}("");
            require(sent, "Failed to send ether");
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
