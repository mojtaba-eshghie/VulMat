// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Yearn Protocol V1/yearn-protocol-9ff0dc0ea73642c529383d0675930a41bf033295/interfaces/aave/Oracle.sol

pragma solidity ^0.5.16;

interface Oracle {
    function getAssetPrice(address reserve) external view returns (uint);
    function latestAnswer() external view returns (uint);
}
