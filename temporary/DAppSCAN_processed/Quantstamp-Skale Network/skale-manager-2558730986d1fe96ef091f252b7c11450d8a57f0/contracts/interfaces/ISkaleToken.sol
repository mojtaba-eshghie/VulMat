// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/interfaces/ISkaleToken.sol

pragma solidity 0.5.16;

interface ISkaleToken {
    function transfer(address to, uint256 value) external returns (bool success);
    function mint(
        address operator,
        address account,
        uint amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external returns (bool);
    function CAP() external view returns (uint);
}
