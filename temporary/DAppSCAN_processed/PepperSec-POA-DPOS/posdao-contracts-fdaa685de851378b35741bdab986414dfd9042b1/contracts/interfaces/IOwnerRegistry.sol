// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IOwnerRegistry.sol

pragma solidity 0.5.9;


interface IOwnerRegistry {
    event Reserved(bytes32 indexed name, address indexed owner);
    event Transferred(bytes32 indexed name, address indexed oldOwner, address indexed newOwner);
    event Dropped(bytes32 indexed name, address indexed owner);

    function getOwner(bytes32 _name)
        external
        view
        returns (address);
}
