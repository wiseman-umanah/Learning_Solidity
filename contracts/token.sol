// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Token is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
  
    address public owner;
    
    mapping(address => uint256) public balanceOf;
    
   
    mapping(address => mapping(address => uint256)) public allowance;
    

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        owner = msg.sender;
        
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        
        balanceOf[msg.sender] = totalSupply;
        
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Transfer to zero address is not allowed");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Approval to zero address is not allowed");
        
        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_from != address(0), "Transfer from zero address is not allowed");
        require(_to != address(0), "Transfer to zero address is not allowed");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function increaseAllowance(address _spender, uint256 _addedValue) public returns (bool success) {
        require(_spender != address(0), "Approval to zero address is not allowed");
        
        allowance[msg.sender][_spender] += _addedValue;
        
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }
    
    function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool success) {
        require(_spender != address(0), "Approval to zero address is not allowed");
        require(allowance[msg.sender][_spender] >= _subtractedValue, "Decreased allowance below zero");
        
        allowance[msg.sender][_spender] -= _subtractedValue;
        
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

    function mint(address _to, uint256 _amount) public onlyOwner returns (bool success) {
        require(_to != address(0), "Mint to zero address is not allowed");
        
        totalSupply += _amount;
        balanceOf[_to] += _amount;
        
        emit Transfer(address(0), _to, _amount);
        emit Mint(_to, _amount);
        return true;
    }
    
    function burn(address _from, uint256 _amount) public returns (bool success) {
        // Only the owner can burn others' tokens, but anyone can burn their own
        if (_from != msg.sender) {
            require(msg.sender == owner, "Only owner can burn others' tokens");
        }
        
        require(balanceOf[_from] >= _amount, "Burn amount exceeds balance");
        
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
        
        emit Transfer(_from, address(0), _amount);
        emit Burn(_from, _amount);
        return true;
    }
    
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner cannot be zero address");
        owner = _newOwner;
    }
}



