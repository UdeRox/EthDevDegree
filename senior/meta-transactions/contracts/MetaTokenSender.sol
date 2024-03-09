// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract RandomToken is ERC20 {
    constructor() ERC20("", "") {}

    function freeMint(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}

contract TokenSender {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;

    function tranfer(
        address sender,
        uint256 amount,
        address recipient,
        address tokenContract,
        bytes memory signature
    ) public {
        bytes32 messageHash = getHash(sender, amount, recipient, tokenContract);
        bytes32 signedMessageHash = messageHash.toEthSignedMessageHash();
        address singer = signedMessageHash.recover(signature);
        require(singer == sender, "Signature does not match!");
        bool sent = ERC20(tokenContract).transferFrom(
            sender,
            recipient,
            amount
        );
        require(sent, "Failed Transfer");
    }

    function getHash(
        address sender,
        uint256 amount,
        address recipient,
        address tokenContract
    ) public pure returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(sender, amount, recipient, tokenContract)
            );
    }
}
