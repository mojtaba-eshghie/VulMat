// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeySingletoneAddressStorage.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 12/24/18
 */
contract ITwoKeySingletoneAddressStorage {
    function getContractAddress(string contractName) external view returns (address);
}
