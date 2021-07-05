pragma solidity ^0.8.6;

contract MyToken {
    mapping (address => uint256) private _balances;

    constructor(uint256 initialSetup) {
        _balances[msg.sender] = initialSetup;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function setBalance(address account, uint256 balance) internal {
        _balances[account] = balance;
    }

    function transfer(address beneficiary, uint256 ammount) public returns (bool) {
        _balances[msg.sender] -= ammount;
        _balances[beneficiary] += ammount;
        return true;
    }
}