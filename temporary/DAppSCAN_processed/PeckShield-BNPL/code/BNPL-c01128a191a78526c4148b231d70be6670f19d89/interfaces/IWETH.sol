// File: ../sc_datasets/DAppSCAN/PeckShield-BNPL/code/BNPL-c01128a191a78526c4148b231d70be6670f19d89/interfaces/IWETH.sol

pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;

    function transfer(address to, uint value) external returns (bool);

    function withdraw(uint) external;
}
