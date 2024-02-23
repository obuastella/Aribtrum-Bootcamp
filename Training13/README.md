# Smart Contract Vulnerabilities: Re-entrancy and Signature Replay

Author: Samuel Adeyeye

---

Smart contracts have revolutionized transactions and agreements on the blockchain, providing transparency, immutability, and trustlessness. However, they are not immune to security vulnerabilities. Understanding these vulnerabilities is crucial for developers and enthusiasts to maintain the integrity and safety of decentralized ecosystems.

## Overview

This repo delves into two critical vulnerabilities in smart contracts: signature replay and reentrancy attacks. These vulnerabilities, if left unaddressed, can lead to the loss of user funds, manipulation of contract logic, and exploitation of decentralized systems. By comprehending the root causes and implications of these vulnerabilities, developers can craft more secure and resilient smart contracts.

## What is Signature Replay in Smart Contracts?

Signature replay in smart contracts is akin to someone copying your signature and using it without your consent. It involves the reuse of cryptographic signatures to replicate authorized transactions, potentially leading to unintended consequences such as fund drainage or unauthorized actions.

To prevent signature replay, developers often utilize nonce (number used once) or timestamp checks. Nonces ensure that each signature can only be used once, while timestamps limit the validity period of signatures, thwarting replay attacks.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";

contract MultiSigWallet {
    using ECDSA for bytes32;

    address[2] public owners;

    constructor(address[2] memory _owners) payable {
        owners = _owners;
    }

    function deposit() external payable {}

    function transfer(address _to, uint _amount, bytes[2] memory _sigs) external {
        bytes32 txHash = getTxHash(_to, _amount);
        require(_checkSigs(_sigs, txHash), "invalid sig");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

}
```

## Mitigation of Signature Replay Vulnerability

The provided Solidity code implements a multi-signature wallet vulnerable to signature replay attacks. To mitigate this vulnerability, a nonce-based protection mechanism is introduced in the modified contract. Nonces ensure that each transaction is uniquely identified, preventing replay attacks.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";

contract MultiSigWallet {
    using ECDSA for bytes32;

    address[2] public owners;
    mapping(bytes32 => bool) public executed;

    constructor(address[2] memory _owners) payable {
        owners = _owners;
    }

    function deposit() external payable {}

    function transfer(
        address _to,
        uint _amount,
        uint _nonce,
        bytes[2] memory _sigs
    ) external {
        bytes32 txHash = getTxHash(_to, _amount, _nonce);
        require(!executed[txHash], "tx executed");
        require(_checkSigs(_sigs, txHash), "invalid sig");

        executed[txHash] = true;

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
```

## What is Re-entrancy in Smart Contracts?

Reentrancy in smart contracts involves unexpected re-entry into contract code, potentially leading to unintended behavior and fund theft. It occurs when a contract calls back into another contract before completing its execution, allowing malicious contracts to exploit vulnerabilities and manipulate state.

To prevent reentrancy, Solidity introduced the "checks-effects-interactions" pattern, emphasizing the importance of sequential operations and cautious interaction with external contracts.

```solidity
contract Attack {
    EtherStore public etherStore;
    uint256 constant public AMOUNT = 1 ether;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }
     receive() external payable {
        // Handle incoming Ether here
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (address(etherStore).balance >= AMOUNT) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= AMOUNT);
        etherStore.deposit{value: AMOUNT}();
        etherStore.withdraw();
    }
```

## Mitigation of Re-entrancy Vulnerability

The provided Solidity code illustrates a contract susceptible to reentrancy attacks. To mitigate this vulnerability, a reentrancy guard pattern is implemented using function modifiers. These modifiers prevent recursive calls during critical state-changing operations, enhancing contract security.

```solidity
contract ReEntrancyGuard {
    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }
}
```

## Conclusion

Understanding vulnerabilities like reentrancy and signature replay is essential in smart contract development. By implementing preventative measures and best practices, developers can fortify their contracts against exploitation and uphold the integrity of decentralized systems.

**Acknowledgements:**
I would like to acknowledge the invaluable resources provided by https://solidity-by-example.org/hacks/re-entrancy/ and https://solidity-by-example.org/hacks/signature-replay/. Their insights and code snippets significantly enriched the content of this article.
