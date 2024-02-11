// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/interfaces/IWETH.sol

pragma solidity 0.7.5;

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256 _value) external;

    function approve(address _to, uint256 _value) external;
}
