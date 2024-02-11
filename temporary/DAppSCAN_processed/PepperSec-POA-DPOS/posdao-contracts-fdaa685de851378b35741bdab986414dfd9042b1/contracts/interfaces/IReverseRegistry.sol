// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IReverseRegistry.sol

pragma solidity 0.5.9;


interface IReverseRegistry {
    event ReverseConfirmed(string name, address indexed reverse);
    event ReverseRemoved(string name, address indexed reverse);

    function hasReverse(bytes32 _name)
        external
        view
        returns (bool);

    function getReverse(bytes32 _name)
        external
        view
        returns (address);

    function canReverse(address _data)
        external
        view
        returns (bool);

    function reverse(address _data)
        external
        view
        returns (string memory);
}
