// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/interfaces/IOneSwapBuyback.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface IOneSwapBuyback {
    event BurnOnes(uint256 burntAmt);

    function weth() external pure returns (address);
    function ones() external pure returns (address);
    function router() external pure returns (address);
    function factory() external pure returns (address);

    function addMainToken(address token) external;
    function removeMainToken(address token) external;
    function isMainToken(address token) external view returns (bool);
    function mainTokens() external view returns (address[] memory list);

    function removeLiquidity(address[] calldata pairs) external;
    function swapForMainToken(address[] calldata pairs) external;
    function swapForOnesAndBurn(address[] calldata pairs) external;
}
