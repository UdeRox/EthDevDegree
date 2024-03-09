// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract LW3Punks is ERC721, ERC721URIStorage, ERC721Pausable, Ownable {
    using Strings for uint256;
    string _baseTokenURI;
    uint256 public maxTokenIds = 10;
    uint256 public _price = 0.001 ether;
    uint256 public tokenId;

    constructor(
        address initialOwner,
        string memory baseURI
    ) Ownable(initialOwner) ERC721("LW3Punks", "LW3P") {
        _baseTokenURI = baseURI;
    }

    function mint(address to) public payable onlyOwner whenNotPaused {
        require(tokenId <= maxTokenIds, "Maximum limit reached!");
        require(msg.value >= _price, "Amount is less than Price!");
        tokenId += 1;
        _safeMint(to, tokenId);
    }

    function pause() public onlyOwner {
        _pause();
    }

    // The following functions are overrides required by Solidity. ERC721Pausable
    function _update(
        address to,
        uint256 _tokenId,
        address auth
    ) internal override(ERC721, ERC721Pausable) returns (address) {
        return super._update(to, _tokenId, auth);
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 _amount = address(this).balance;
        (bool sent, ) = _owner.call{value: _amount}("");
        require(sent, "Failed to send Eth to Owner");
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        require(
            _ownerOf(tokenId) != address(0),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return super.tokenURI(_tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    receive() external payable {}

    fallback() external payable {}
}
