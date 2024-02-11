// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/FXB/Curves/IFraxBond_Curve.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

interface IFraxBond_Curve {
    function get_total_points(uint8 curve_choice) external view returns (uint32);
    function get_curve_point(uint8 curve_choice, uint8 index) external view returns (uint32);
}
