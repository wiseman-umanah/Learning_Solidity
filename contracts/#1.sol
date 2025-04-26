// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Learn1 {
    string public value;

    constructor() {
        value = "myValue";
    }

    function set(string memory _value) public {
        value = _value;
    }
}
