// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether/pool-contracts-956b9e9dfd41dacd4040c08b5061354cc11897fc/contracts/external/openzeppelin/OpenZeppelinProxyFactoryInterface.sol

pragma solidity >=0.6.0 <0.7.0;

interface OpenZeppelinProxyFactoryInterface {
  function deploy(uint256 _salt, address _logic, address _admin, bytes calldata _data) external returns (address);
  function getDeploymentAddress(uint256 _salt, address _sender) external view returns (address);
}
