// File: ../sc_datasets/DAppSCAN/QuillAudits-1inch-Fee Collector/fee-collector-3c2626763fd829500496f15476d5e98fbdf4f574/contracts/utils/BalanceAccounting.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract BalanceAccounting {
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function _mint(address account, uint256 amount) internal virtual {
        _totalSupply += amount;
        unchecked {
            _balances[account] += amount;
        }
    }

    function _burn(address account, uint256 amount) internal virtual {
        _balances[account] -= amount;
        unchecked {
            _totalSupply -= amount;
        }
    }
}
