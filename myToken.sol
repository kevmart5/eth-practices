// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract MyToken {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor(
        uint256 initialSupply,
        string memory tokenName,
        string memory tokenSymbol,
        uint8 decimalUnits
    ) {
        _balances[msg.sender] = initialSupply;
        _totalSupply = initialSupply;
        _decimals = decimalUnits;
        _symbol = tokenSymbol;
        _name = tokenName;
    }

    function getName() public view returns (string memory) {
        return _name;
    }

    function getSymbol() public view returns (string memory) {
        return _symbol;
    }

    function getDecimals() public view returns (uint8) {
        return _decimals;
    }

    function getTotalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function setTotalSupply(uint256 ammount) internal {
        _totalSupply = ammount;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function setBalance(address account, uint256 balance) internal {
        _balances[account] = balance;
    }

    function getAllowances(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function setAllowances(
        address owner,
        address spender,
        uint256 ammount
    ) internal {
        _allowances[owner][spender] = ammount;
    }

    function transfer(address beneficiary, uint256 ammount)
        public
        returns (bool)
    {
        require(
            beneficiary != address(0),
            "Beneficiary address cannot be empty or zero"
        );
        require(
            _balances[msg.sender] >= ammount,
            "Sender do not have enough balance"
        );
        require(
            _balances[beneficiary] + ammount > _balances[beneficiary],
            "Addition overflow"
        );
        emit Transfer(msg.sender, beneficiary, ammount);
        _balances[msg.sender] -= ammount;
        _balances[beneficiary] += ammount;
        return true;
    }

    function approve(address spender, uint256 ammount) public returns (bool) {
        require(spender != address(0), "Spender address cannot be zero");
        _allowances[msg.sender][spender] = ammount;
        emit Approval(msg.sender, spender, ammount);
        return true;
    }

    function transferFrom(
        address sender,
        address beneficiary,
        uint256 ammount
    ) public returns (bool) {
        require(sender != address(0), "Spender address cannot be zero");
        require(
            beneficiary != address(0),
            "Beneficiary address cannot be zero"
        );
        require(
            ammount <= _allowances[sender][msg.sender],
            "Allowance is not enough"
        );
        require(
            _balances[sender] >= ammount,
            "Sender do not have enough balance"
        );
        require(
            _balances[beneficiary] + ammount > _balances[beneficiary],
            "Addition overflow"
        );

        _balances[sender] -= ammount;
        _allowances[sender][msg.sender] -= ammount;
        _balances[beneficiary] += ammount;
        emit Transfer(sender, beneficiary, ammount);
        return true;
    }
}
