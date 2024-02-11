// File: ../sc_datasets/DAppSCAN/Quantstamp-NAOS-Formation Updates/NAOS-Formation-c1404ec0f5de6f80189b528acf5f0923ff8d4e6e/contracts/interfaces/IYearnController.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

interface IYearnController {
    function balanceOf(address _token) external view returns (uint256);

    function earn(address _token, uint256 _amount) external;

    function withdraw(address _token, uint256 _withdrawAmount) external;
}
