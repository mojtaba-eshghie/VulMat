// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IMetadataRegistry.sol

pragma solidity 0.5.9;


interface IMetadataRegistry {
    event DataChanged(bytes32 indexed name, string key, string plainKey);

    function getData(bytes32 _name, string calldata _key)
        external
        view
        returns (bytes32);

    function getAddress(bytes32 _name, string calldata _key)
        external
        view
        returns (address);

    function getUint(bytes32 _name, string calldata _key)
        external
        view
        returns (uint);
}
