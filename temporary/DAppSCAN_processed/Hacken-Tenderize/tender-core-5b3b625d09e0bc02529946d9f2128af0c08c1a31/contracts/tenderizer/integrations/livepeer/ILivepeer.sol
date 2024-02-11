// File: ../sc_datasets/DAppSCAN/Hacken-Tenderize/tender-core-5b3b625d09e0bc02529946d9f2128af0c08c1a31/contracts/tenderizer/integrations/livepeer/ILivepeer.sol

// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

interface ILivepeer {
    function bond(uint256 _amount, address _to) external;

    function unbond(uint256 _amount) external;

    function withdrawStake(uint256 _unbondingLockId) external;

    function withdrawFees() external;

    function pendingFees(address _delegator, uint256 _endRound) external view returns (uint256);

    function pendingStake(address _delegator, uint256 _endRound) external view returns (uint256);
}
