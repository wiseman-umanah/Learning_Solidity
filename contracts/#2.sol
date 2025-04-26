// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract DataTypes {
    string public constant stringValue = "myValue";
    bool public mybol = true;
    int public myInt = -10;
    uint256 private peopleCount = 0;
    mapping(uint256 => Person) public people;

    enum State { Waiting, Ready, Active }
    State public state;

    struct Person {
        uint256 _id;
        string _firstname;
        string _lastname; 
    }

    function addPerson(string memory _firstname, string memory _lastname) public {
        peopleCount++;
        people[peopleCount] = Person(peopleCount, _firstname, _lastname);
    }

    constructor() {
        state = State.Waiting;
    }

    function activate() public {
        state = State.Active;
    }

    function ready() public {
        state = State.Ready;
    }

    function isActive() public view returns(bool) {
        return state == State.Active;
    }
}
