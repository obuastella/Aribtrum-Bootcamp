// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ThriftContract {
    mapping(address => uint256) private _balances;

    // We need an event that will be triggered when funds are deposited
    event Deposited(address indexed account, uint amount);

    // We also need an event that will be triggered when funds are withdrawn.
    event Withdrawn(address indexed account, uint amount);

    // Deposit funds into the contract
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        _balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw funds from the contract
    function withdraw(uint256 amount) public payable {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        _balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Get account balance
    function getBalance(address account) public view returns (uint256) {
        return _balances[account];
    }
}
