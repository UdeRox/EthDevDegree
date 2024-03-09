// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LW3Punks is ERC721, ERC721Pausable, Ownable {
    using Strings for uint256;
    string _baseTokenURI;
    uint256 public maxTokenIds = 10;
    
    constructor(
        address initialOwner,
        string memory baseURI
    ) Ownable(initialOwner) ERC721("LW3Punks", "LW3P") {
        _baseTokenURI = baseURI;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Pausable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
}
