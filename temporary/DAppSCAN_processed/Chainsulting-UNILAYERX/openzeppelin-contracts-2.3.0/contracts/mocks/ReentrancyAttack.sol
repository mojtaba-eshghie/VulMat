// File: ../sc_datasets/DAppSCAN/Chainsulting-UNILAYERX/openzeppelin-contracts-2.3.0/contracts/mocks/ReentrancyAttack.sol

pragma solidity ^0.5.0;

contract ReentrancyAttack {
    function callSender(bytes4 data) public {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = msg.sender.call(abi.encodeWithSelector(data));
        require(success, "ReentrancyAttack: failed call");
    }
}
