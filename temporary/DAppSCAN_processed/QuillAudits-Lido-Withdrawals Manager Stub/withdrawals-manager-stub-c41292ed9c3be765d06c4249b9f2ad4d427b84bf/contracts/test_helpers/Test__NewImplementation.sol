// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Withdrawals Manager Stub/withdrawals-manager-stub-c41292ed9c3be765d06c4249b9f2ad4d427b84bf/contracts/test_helpers/Test__NewImplementation.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;


/**
 * @dev This is a test helper only, don't use it in production!
 */
contract Test__NewImplementation {
    event SmthHappened();
    event EtherReceived(uint256 amount);

    function wasUpgraded() external pure returns (bool) {
        return true;
    }

    function doSmth() external {
        emit SmthHappened();
    }

    receive() external payable {
        emit EtherReceived(msg.value);
    }
}
