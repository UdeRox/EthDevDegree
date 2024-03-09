// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string _baseTokenURI;

    constructor(
        address initialOwner,
        string memory baseURI
    ) Ownable(initialOwner) ERC721("LW3Punks", "LW3P") {
        _baseTokenURI = baseURI;
    }
}
