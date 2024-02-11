// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Yearn Protocol V1/yearn-protocol-9ff0dc0ea73642c529383d0675930a41bf033295/interfaces/yearn/Strategy.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.16;


interface Strategy {
    function want() external view returns (address);

    function deposit() external;

    // NOTE: must exclude any tokens used in the yield 
    // Controller role - withdraw should return to Controller
    function withdraw(address) external;

    // Controller | Vault role - withdraw should always return to Vault
    function withdraw(uint) external;

    // Controller | Vault role - withdraw should always return to Vault
    function withdrawAll() external returns (uint);

    function balanceOf() external view returns (uint);
}
