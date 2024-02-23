// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721 {
    address public owner;
    uint256 public tokenId = 1;

    struct NFT {
        address owner;
        uint256 price;
        bool isForSale;
    }

    mapping(uint256 => NFT) public nfts;

    constructor() ERC721("NFT Marketplace", "NFTM") {
        owner = msg.sender;
    }
        function mintNFT(address _owner, uint256 _price) external returns (uint256) {
        require(msg.sender == owner, "Only owner can mint NFT");
        uint256 newTokenId = tokenId++;
        _safeMint(_owner, newTokenId);
        nfts[newTokenId] = NFT(_owner, _price, false);
        return newTokenId;
    }

    function sellNFT(uint256 _tokenId, uint256 _price) external {
        require(msg.sender == nfts[_tokenId].owner, "Only owner can sell NFT");
        require(nfts[_tokenId].isForSale == false, "NFT is already for sale");
        nfts[_tokenId].price = _price;
        nfts[_tokenId].isForSale = true;
    }

    function buyNFT(uint256 _tokenId) external payable {
        require(nfts[_tokenId].isForSale == true, "NFT is not for sale");
        require(msg.value >= nfts[_tokenId].price, "Not enough Ether to buy NFT");
        address seller = nfts[_tokenId].owner;
        nfts[_tokenId].isForSale = false;
        nfts[_tokenId].price = 0;
        _transfer(seller, msg.sender, _tokenId);
    }
}