// File: ../sc_datasets/DAppSCAN/Solidified-Aztec Lido Bridge/aztec-connect-bridges-d5aca13d4d0a17b21eeddf77f49f4c6613461fb0/src/bridges/set/interfaces/IController.sol

// SPDX-License-Identifier: GPL-2.0-only
pragma solidity >=0.6.10 <=0.8.10;
pragma experimental ABIEncoderV2;

interface IController {
    function addSet(address _setToken) external;

    function feeRecipient() external view returns (address);

    function getModuleFee(address _module, uint256 _feeType) external view returns (uint256);

    function isModule(address _module) external view returns (bool);

    function isSet(address _setToken) external view returns (bool);

    function isSystemContract(address _contractAddress) external view returns (bool);

    function resourceId(uint256 _id) external view returns (address);
}
