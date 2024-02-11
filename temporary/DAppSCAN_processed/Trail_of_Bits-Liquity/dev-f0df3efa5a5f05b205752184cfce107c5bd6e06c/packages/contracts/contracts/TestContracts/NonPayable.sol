// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Liquity/dev-f0df3efa5a5f05b205752184cfce107c5bd6e06c/packages/contracts/contracts/TestContracts/NonPayable.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;


contract NonPayable {
    function forward(address _dest, bytes calldata _data) external payable {
        (bool success, bytes memory returnData) = _dest.call{ value: msg.value }(_data);
        require(success, string(returnData));
    }

    receive() external payable {
        revert();
    }
}
