// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Modifiers {
    uint256 private peopleCount;
    uint256 openingTime = 1745724823;

    struct People {
        string _firstname;
        string _lastname;
    }
    address owner;

    mapping(uint => People) public people;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the Owner");
        _;
    }

    modifier onlyTimePass() {
        require(msg.sender == owner);
        require(block.timestamp >= openingTime);
        _;
    }
    constructor() {
        owner = msg.sender;
    }

    function addPerson(string memory _firstname, string memory _lastname) public onlyTimePass{
        incrementCount();
        people[peopleCount] = People(_firstname, _lastname);
    }

    function incrementCount() internal {
        peopleCount++;
    }
}

