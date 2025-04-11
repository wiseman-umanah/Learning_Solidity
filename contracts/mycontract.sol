// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.1 <0.9.0;

contract MyContract {
    uint public amt = 100;
    address public owner;
    string public name = "Wiseman";

    // boolean
    bool public status = false;

    // array
    uint[8] myarray = [1, 2, 3, 4];

    // mapping
    mapping(string => address) public balances;

    constructor() {
        owner = msg.sender;
    }

    // struct
    struct Person {
        uint age;
        string name;
    }

    function setAmt(uint256 _amt) public {
        amt = _amt;
    }

    function getAmt() public view returns (uint256){
        return amt;
    }
}
