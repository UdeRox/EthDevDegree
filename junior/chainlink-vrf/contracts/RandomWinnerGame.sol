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
    uint32 numWords;
    uint32 callBackGasLimit = 4000;
    uint16 requestConfirmations = 3;
    uint64 public subscriptionId;
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
    event RequestRandomNumber(
        uint256 indexed requestId,
        bytes32 keyHash,
        uint256 fee
    );
    event FullFillRandomNumber(uint256 indexRequest, address winner);

    constructor(
        address _owner,
        address _vrfCoordinator,
        bytes32 _vrfKeyHash,
        uint256 _vrfEntryFee,
        uint64 _subscriptionId
    ) Ownable(_owner) VRFConsumerBaseV2(_vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(_vrfCoordinator);
        keyHash = _vrfKeyHash;
        fee = _vrfEntryFee;
        gameStarted = false;
        subscriptionId = _subscriptionId;
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

    function pickWinner() private returns (uint256 requestId) {
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subscriptionId,
            requestConfirmations,
            callBackGasLimit,
            numWords
        );
        emit RequestRandomNumber(requestId, keyHash, fee);
    }

    receive() external payable {}

    fallback() external payable {}

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal virtual override {
        require(msg.sender == address(COORDINATOR), "Only Coordinator");
        uint256 winnerIndex = randomWords[0] % maxPlayers;
        address winner = players[winnerIndex];
        (bool sent, ) = winner.call{value: address(this).balance}("");
        require(sent, "Failed to send eth to winner!");
        emit FullFillRandomNumber(requestId, winner);
        gameStarted = false;
    }
}
