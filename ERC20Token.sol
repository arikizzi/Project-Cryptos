//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

//EIP-20: ERC-20 Token Standard
//https://eips.ethereum.org/EIPS/eip-20

interface ERC20Interface{
    //First 3 are the mandatory functions to be overridden in derived class
    function totalSupply() external view returns(uint);
    function balanceOf(address tokenOwner) external view returns(uint balance);
    function transfer(address to, uint tokens) external returns(bool success);

    // function allowance(address tokenOwner, address spender) external view returns(uint remaining);
    // function approve(address spender, uint tokens) external returns(bool success);
    // function transferFrom(address from, address to, uint tokens) external returns(bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Cryptos is ERC20Interface{
    string public name = "Cryptos";
    string public symbol = "CRPT";
    uint public decimals = 0; //18 generally

    uint public override totalSupply;

    address public founder;
    mapping(address => uint) public balances;
    
    constructor(){
        totalSupply = 1000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address tokenOwner) public view override returns(uint balance){
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public override returns(bool success){
        require(balances[msg.sender] >= tokens);

        balances[to] += tokens;
        balances[msg.sender] -= tokens;

        emit Transfer(msg.sender, to, tokens);
        
        return true;
    }
}
