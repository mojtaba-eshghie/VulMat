// File: ../sc_datasets/DAppSCAN/Coinfabrik-EMDX – Protocol Audit/perpetual-protocol-emdx-main/src/mock/mocks/PerpTokenMock.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

contract PerpTokenMock {
    uint256 public totalSupply;

    function setTotalSupply(uint256 _totalSupply) public {
        totalSupply = _totalSupply;
    }
}
