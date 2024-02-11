// File: ../sc_datasets/DAppSCAN/PeckShield-Donut/crossroad-550a8c3c010dc8c1a46ea9191d3841462bd58d82/contracts/utils/TransferHelper.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

library TransferHelper
{
    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}
