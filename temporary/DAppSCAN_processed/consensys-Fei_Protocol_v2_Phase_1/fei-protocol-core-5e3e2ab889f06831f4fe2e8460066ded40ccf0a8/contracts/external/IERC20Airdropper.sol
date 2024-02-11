// File: ../sc_datasets/DAppSCAN/consensys-Fei_Protocol_v2_Phase_1/fei-protocol-core-5e3e2ab889f06831f4fe2e8460066ded40ccf0a8/contracts/external/IERC20Airdropper.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IERC20Airdropper {

    function pricePerTx() external view returns (uint256);

    function transfer(address _token, address payable _referral, address[] calldata _addresses, uint256[] calldata _values) external payable returns (bool); 

}
