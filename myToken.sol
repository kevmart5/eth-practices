// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract MyToken {
    mapping(address => uint256) private _balances;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

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
        _balances[msg.sender] -= ammount;
        _balances[beneficiary] += ammount;
        return true;
    }

    // Parse function for uint to string
    // Code from Stackoverflow https://stackoverflow.com/questions/47129173/how-to-convert-uint-to-string-in-solidity
    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
