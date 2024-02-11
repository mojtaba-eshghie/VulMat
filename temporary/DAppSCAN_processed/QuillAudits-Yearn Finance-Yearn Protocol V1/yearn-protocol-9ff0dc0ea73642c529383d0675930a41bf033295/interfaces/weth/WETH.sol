// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Yearn Protocol V1/yearn-protocol-9ff0dc0ea73642c529383d0675930a41bf033295/interfaces/weth/WETH.sol

pragma solidity ^0.5.16;

interface WETH {
    function deposit() external payable;
    function withdraw(uint wad) external;
    event Deposit(address indexed dst, uint wad);
    event Withdrawal(address indexed src, uint wad);
}
