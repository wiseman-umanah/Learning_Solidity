// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.1 <0.9.0;

contract Ownable {
    address private owner;
    event OwnershipTransferred(address indexed _from, address indexed  _to);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}



contract MyToken is Ownable {
    
}