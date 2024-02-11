// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyPlasmaRegistry.sol

pragma solidity ^0.4.24;

contract ITwoKeyPlasmaRegistry {
    function plasma2ethereum(
        address _plasma
    )
    public
    view
    returns (address);


    function ethereum2plasma(
        address _ethereum
    )
    public
    view
    returns (address);
}
