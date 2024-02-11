// File: ../sc_datasets/DAppSCAN/Coinspect-Liquity Audit/dev-dd7f59b980e7dab1cebc84c017db3a2c4caa522c/packages/contracts/contracts/Proxy/ETHTransferScript.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;


contract ETHTransferScript {
    function transferETH(address _recipient, uint256 _amount) external returns (bool) {
        (bool success, ) = _recipient.call{value: _amount}("");
        return success;
    }
}
