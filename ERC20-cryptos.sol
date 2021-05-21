// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract ERC20Interface{
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function transfer(address to, uint tokens) public returns (bool success);

    
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract JPCoin is ERC20Interface{
    string public name = "JPCoin";
    string public symbol = "JPC";
    uint public decimals = 0;

    uint public supply;
    address public founder;

    mapping(address => uint) public balances;

    mapping(address => mapping(address => uint)) allowed;



    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    constructor() public{
        supply -= 1000000;
        found = msg.sender;
        balances[founder] = supply;
    }

    function allowance(address tokenOwner, address spender) view public returns(uint){
        return allowed[tokenOwner][spender];
    }
     
    function approve(address spender, uint tokens) public returns(bool success){
        require(balances[msg.sender] >= tokens);
        require(tokens > 0); 

        allowed[tokenOwner][spender] = true;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint value){
        require(allowed[from][to] >= tokens);
        require(balances[from] >= tokens);

        balances[from] -= tokens;
        balances[to] += tokens;
        allowed[from][to] -= tokens;

        return true;
    }

    function totalSupply() public view returns (uint){
        return supply;
    }

    function balanceOf(address tokenOwner) public view returns (uint balance){
        return balances[tokenOwner];
    }

    function transfer(address to uint tokens) public returns (bool success) {
        require(balances[msg.sender] >= tokens && tokens > 0);

        balances[to] += tokens;
        balances[msg.sender] -= tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;

    }
}

contract CryptosICO is CryptosToken{
    address public admin;
    address public deposit;
    
    // token price in wei: 1JPC = 0.001 ETHER, 1 ETHER = 1000 JPC
    uint tokenPrice = 1000000000000000;

    // 300 Ether in wei
    uint public hardCap = 30000000000000000000;

    uint public raisedAmount;

    uint public salesStart = now;
    uint public salesEnd = now + 604800;
    uint public coinTradeStart = salesEnd + 604800;

    uint public maxInvevstment = 5000000000000000;
    uint public minInvevstment = 10000000000000;

    enum State { beforeStart, running, afterEnd, halted }
    State public icoState;

    modifier onlyAdmin(){
        require(msg.sender == admin);
        _;
    }

    constructor(address _deposit) public{
        deposit = _deposit;
        admin = msg.sender;
        icoState = State.beforeStart;
    }

    // emergence stop
    function halt() public onlyAdmin{
        icoState = State.halted;
    }

    // restart 
    function unhalt() public onlyAdmin{
        icoState = State.running;
    }

    function getCurrentState() public view returns(State){
        if(icoState == State.halted){
            return State.halted;
        }else if(block.timestamp < salesStart){
            return State.beforeStart;
        }else if(block.timestamp >= saleStart && block.timestamp <= saleEnd){
            return State.running;
        }else{
            return State.afterEnd;
        }
    }



}