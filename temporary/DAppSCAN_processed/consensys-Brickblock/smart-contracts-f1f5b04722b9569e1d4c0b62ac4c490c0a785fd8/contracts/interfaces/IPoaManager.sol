// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/interfaces/IPoaManager.sol

pragma solidity 0.4.23;

interface IPoaManager {
  function getTokenStatus(
    address _tokenAddress
  )
    external
    view
    returns (bool);
}
