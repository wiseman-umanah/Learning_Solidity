// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

contract Learn1 {
    string value;

    constructor() public {
        value = "myValue";
    }

    function get() public view returns(string) {
        return value;
    }

    function set(string _value) public {
        value = _value;
    }
}
