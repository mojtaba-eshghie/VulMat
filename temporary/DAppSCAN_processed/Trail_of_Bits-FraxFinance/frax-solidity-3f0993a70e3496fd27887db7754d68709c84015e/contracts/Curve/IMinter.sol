// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Curve/IMinter.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

// https://github.com/swervefi/swerve/blob/master/packages/swerve-contracts/interfaces/IMinter.sol

interface IMinter {
    // Public variables
    function minter() external view returns (address);
    function controller() external view returns (address);
    function minted(address, address) external view returns (uint256);
    function allowed_to_mint_for(address, address) external view returns (bool);

    // External functions
    function mint(address) external;
    function mint_many(address[] memory) external;
    function mint_for(address, address) external;
    function toggle_approve_mint(address) external;
}
