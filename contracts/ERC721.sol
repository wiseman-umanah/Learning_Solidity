// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LiskNFTCollection is ERC721URIStorage, Ownable {
    using Strings for uint256;
    
    uint256 public constant MAX_SUPPLY = 100;
    uint256 public constant PRICE = 0 ether; 
    uint256 private _currentTokenId = 0;
    string private _baseTokenURI;
    bool public saleIsActive = false;

    event Minted(address indexed to, uint256 indexed tokenId);

    constructor(string memory baseURI) ERC721("LiskNFTCollection", "LNFT") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    function mint(uint256 numberOfTokens) public payable {
        require(saleIsActive, "Sale must be active to mint");
        require(numberOfTokens <= 20, "Can only mint 20 tokens at a time");
        require(_currentTokenId + numberOfTokens <= MAX_SUPPLY, "Purchase would exceed max supply");
        require(PRICE * numberOfTokens <= msg.value, "Value sent is not correct");

        for (uint256 i = 0; i < numberOfTokens; i++) {
            _currentTokenId++;
            _safeMint(msg.sender, _currentTokenId);
            _setTokenURI(_currentTokenId, string(abi.encodePacked(_baseTokenURI, _currentTokenId.toString(), ".json")));
            
            emit Minted(msg.sender, _currentTokenId);
        }
    }

    function totalSupply() public view returns (uint256) {
        return _currentTokenId;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function flipSaleState() public onlyOwner {
        saleIsActive = !saleIsActive;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }
}
