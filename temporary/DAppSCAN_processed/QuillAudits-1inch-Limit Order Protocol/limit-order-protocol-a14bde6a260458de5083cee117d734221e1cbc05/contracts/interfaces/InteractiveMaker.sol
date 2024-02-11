// File: ../sc_datasets/DAppSCAN/QuillAudits-1inch-Limit Order Protocol/limit-order-protocol-a14bde6a260458de5083cee117d734221e1cbc05/contracts/interfaces/InteractiveMaker.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;


interface InteractiveMaker {
    function notifyFillOrder(
        address makerAsset,
        address takerAsset,
        uint256 makingAmount,
        uint256 takingAmount,
        bytes memory interactiveData
    ) external;
}
