// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";

contract RandomWinnerGame is Ownable, VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;
    address[] public players;
    bool public gameStarted;
    bytes32 public keyHash;
    uint8 public maxPlayers;
    uint256 public entryFee;
    uint256 public gameId;
    uint256 public fee;

    //Events
    event GameStarted(
        uint256 indexed gameId,
        uint8 maxPlayers,
        uint256 entryFee
    );
    event PlayerJoined(uint256 indexed gameId, address player);

    constructor(
        address _owner,
        address _vrfCoordinator,
        bytes32 _vrfKeyHash,
        uint256 _vrfEntryFee
    ) Ownable(_owner) VRFConsumerBaseV2(_vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(_vrfCoordinator);
        keyHash = _vrfKeyHash;
        fee = _vrfEntryFee;
        gameStarted = false;
    }

    function startGame(uint8 _maxPlayers, uint256 _entryFee) public onlyOwner {
        require(gameStarted, "Game us currently running!");
        require(_maxPlayers > 0, "Max players must be greater than 0");
        delete players;
        maxPlayers = _maxPlayers;
        gameStarted = true;
        entryFee = _entryFee;
        gameId += 1;
        emit GameStarted(gameId, maxPlayers, _entryFee);
    }

    function joinGame() public payable {
        require(gameStarted, "Game us currently running!");
        require(entryFee == msg.value, "Value sent not equal to entry fee");
        require(players.length < maxPlayers, "Game is full!");
        players.push(msg.sender);
        emit PlayerJoined(gameId, msg.sender);
        if (players.length == maxPlayers) {
            // gameStarted = false;
            pickWinner();
        }
    }

    function pickWinner() private returns (bytes32 requestId) {
        // require(LINK.balanceOf(address(this)) >= fee, "Not enough Link!");
    }

    receive() external payable {}

    fallback() external payable {}

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal virtual override {
        
    }
}
