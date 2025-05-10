// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract BankContract {
    // Handle the amount of money deposited
    mapping (address => uint) public balances;

    event Deposit(address indexed _userAddress, uint256 _amount);
    event Withdraw (address indexed _userAddress, uint256 _amount);
    event Balance (address indexed _userAddress, uint256 _amount);

    // Accept Ether from users who want to deposit money
    function deposit() public payable {
        // check if value sent by user is less than balance
        require(msg.value > 0, "You cannot deposit zero ether");

        // Track the amount save by a user
        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }


    // Withdraw money to user who request
    function withdraw(uint256 _amount) public payable {
        // check if the amount to be removed was saved
        require(balances[msg.sender] >= _amount, "You cannot withdraw more than you have saved");

        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Error while processing payment");

        balances[msg.sender] -= _amount;
        emit Withdraw(msg.sender, _amount);
    }

    // Get user ETH Saved
    function getUserBalance(address _userAddress) public returns (uint256) {
        require(balances[_userAddress] > 0, "Account doesn't exist");

        emit Balance(_userAddress, balances[_userAddress]);
        return balances[_userAddress];
    }
}
