// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ToDo {
    struct Task {
        uint id;
        string description;
        uint created;
    }
    
    mapping(address => Task[]) public ToDoList;

    event TaskAuction(
        address indexed user,
        string action
    );

    function addTask(string calldata _description) public {
        uint timestamp = block.timestamp;
        uint _id = ToDoList[msg.sender].length;
        ToDoList[msg.sender].push(Task(_id, _description, timestamp));

        emit TaskAuction(msg.sender, "Added a new task");
    }

    function deleteTask(uint _index) public {
        require (ToDoList[msg.sender].length > _index, "Invalid Array Size");

        uint last_index = ToDoList[msg.sender].length - 1;
        ToDoList[msg.sender][_index] = ToDoList[msg.sender][last_index];
        ToDoList[msg.sender].pop();
        emit TaskAuction(msg.sender, "deleted a new task");
    }

    function getAllTask() public view returns (Task[] memory) {
        return ToDoList[msg.sender];
    }
}
