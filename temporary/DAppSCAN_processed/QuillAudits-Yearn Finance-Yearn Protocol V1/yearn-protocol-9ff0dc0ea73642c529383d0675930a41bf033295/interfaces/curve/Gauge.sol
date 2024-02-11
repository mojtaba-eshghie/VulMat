// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Yearn Protocol V1/yearn-protocol-9ff0dc0ea73642c529383d0675930a41bf033295/interfaces/curve/Gauge.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.17;

interface Gauge {
    function deposit(uint) external;
    function balanceOf(address) external view returns (uint);
    function withdraw(uint) external;
}
