// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/external/Deployer.sol

pragma solidity ^0.5.0;

contract Deployer {

  function deploy(bytes memory data, uint256 salt) public {
    assembly {
      pop(create2(0, add(data, 32), mload(data), salt))
    }
  }

}
