# NFTContract

This is a Solidity smart contract for managing Non-Fungible Tokens (NFTs) using the ERC721 standard with URI storage. The contract allows minting NFTs and setting their metadata URIs. It inherits from the OpenZeppelin ERC721URIStorage and Ownable contracts.

## Prerequisites

- Solidity compiler version ^0.8.18
- OpenZeppelin contracts library

## Getting Started

1. Clone the repository or create a new Solidity file.
2. Install the necessary dependencies, particularly OpenZeppelin contracts.
3. Compile the Solidity code using the Solidity compiler.
4. Deploy the contract to the Ethereum blockchain.

## Installation

Ensure you have the required dependencies installed:

```bash
npm install @openzeppelin/contracts
```

## Usage

1. Deploy the `NFTContract` contract to the Ethereum blockchain.
2. The contract owner can mint NFTs by calling the `mintNFT` function, providing the recipient's address, token ID, and metadata URI.
3. The contract owner can also transfer ownership by using the Ownable functionality.

## Code Explanation

- The contract inherits from `ERC721URIStorage`, providing standard ERC721 functionalities with URI storage for metadata.
- It also inherits from `Ownable`, allowing the contract owner to control minting and other administrative functions.
- The constructor sets the initial owner and initializes the ERC721 contract with the name "Canine Dreamscape Collection" and the symbol "CDS".
- The `mintNFT` function mints a new NFT and sets its metadata URI. This function is accessible only by the contract owner.
- The SPDX license identifier is set to MIT.


Link to minted NFT collection page on Opensea (Testnet): https://testnets.opensea.io/collection/canine-dreamscape-collection