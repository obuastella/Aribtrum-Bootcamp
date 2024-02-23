// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract DonationContract {
    uint256 public immutable goal;

    address payable public owner;

    // This tracks the amount that has been donated so far.
    uint256 public progress;

    constructor(uint256 goal_) {
        require(goal_ > 0, "Goal must be greater than 0");
        goal = goal_;
        owner = payable(msg.sender);
    }

    // We make the deposit function payable to allow you to send value with it when the function is called.
    // It sends it from your own account to the smart contract account.
    function donate() external payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        require(
            progress + msg.value <= goal,
            "Goal exceeded. Please withdraw funds or start a new donation round"
        );

        progress += msg.value;
    }

    function getMyAddress() public view returns (address) {
        return address(this);
    }

    // Whenever you send funds to a smart contract account you should also specify a way to withdraw it.
    // Your funds can be locked in a smart contract forever if you write the wrong code.
    // Smart contract is about logic, there is no private key.

    function withdrawFunds() external {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(progress > 0, "Insufficient funds to withdraw");

        uint256 amountToWithdraw = progress;
        progress = 0;

        payable(owner).transfer(amountToWithdraw);
    }
}
