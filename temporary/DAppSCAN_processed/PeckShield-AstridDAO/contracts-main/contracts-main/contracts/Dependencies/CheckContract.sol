// File: ../sc_datasets/DAppSCAN/PeckShield-AstridDAO/contracts-main/contracts-main/contracts/Dependencies/CheckContract.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;


contract CheckContract {
    /**
     * Check that the account is an already deployed non-destroyed contract.
     * See: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol#L12
     */
    function checkContract(address _account) internal view {
        require(_account != address(0), "Account cannot be zero address");

        // TODO(Astrid): Contract size check seems not available on Astar EVM.
        // uint256 size;
        // // solhint-disable-next-line no-inline-assembly
        // assembly { size := extcodesize(_account) }
        // require(size > 0, "Account code size cannot be zero");
    }
}
