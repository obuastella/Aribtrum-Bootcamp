# NFT Marketplace Smart Contract

## Overview

The NFT Marketplace Smart Contract is a Solidity smart contract designed to facilitate the buying, selling, and minting of non-fungible tokens (NFTs) on the Ethereum blockchain. This contract leverages the ERC721 standard for NFTs and provides functionality for minting new tokens, putting them up for sale, and purchasing them using Ether.

## Features

- **Minting NFTs**: The contract allows the owner to mint new NFTs by specifying the owner's address and the initial price.
- **Selling NFTs**: Owners of NFTs can put their tokens up for sale by setting a price.
- **Buying NFTs**: Interested buyers can purchase NFTs that are listed for sale by paying the specified price in Ether.

## Getting Started

To deploy the NFT Marketplace contract, follow these steps:

1. Ensure you have the necessary environment set up to deploy Solidity smart contracts, including a compatible Ethereum development environment.
2. Clone this repository to your local machine.
3. Compile the `NFTMarketplace.sol` contract using a Solidity compiler.
4. Deploy the compiled contract to your chosen Ethereum network.

## Contract Details

- **Name**: NFT Marketplace
- **Symbol**: NFTM
- **Compiler Version**: Solidity ^0.8.18
- **License**: MIT

## Functions

### `mintNFT(address _owner, uint256 _price) external returns (uint256)`

Mints a new NFT and assigns it to the specified owner with the given price.

- **Parameters**:
  - `_owner`: Address of the new owner of the NFT.
  - `_price`: Price of the NFT.

### `sellNFT(uint256 _tokenId, uint256 _price) external`

Puts an existing NFT up for sale at the specified price.

- **Parameters**:
  - `_tokenId`: ID of the NFT to be put up for sale.
  - `_price`: Price at which the NFT will be sold.

### `buyNFT(uint256 _tokenId) external payable`

Allows a user to purchase an NFT that is listed for sale by paying the specified price in Ether.

- **Parameters**:
  - `_tokenId`: ID of the NFT to be purchased.

## Acknowledgements

The NFT Marketplace contract was inspired by the ERC721 standard and developed using OpenZeppelin's contracts as a base.

Reference: https://medium.com/@lea.lobanov/building-an-nft-marketplace-a-guide-to-smart-contract-development-d46dfdf913b2

Link to the smart contract verification page on Arbiscan (Testnet): https://sepolia.arbiscan.io/verifyContract-solc?a=0x9b6288e6f79269a02e51ab977b89442d3c4ce83d&c=v0.8.20%2bcommit.a1b79de6&lictype=3