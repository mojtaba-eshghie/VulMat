// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/mocks/ReentrancyAttack.sol

pragma solidity ^0.4.24;

contract ReentrancyAttack {

  function callSender(bytes4 data) public {
    // solium-disable-next-line security/no-low-level-calls
    require(msg.sender.call(abi.encodeWithSelector(data)));
  }

}
