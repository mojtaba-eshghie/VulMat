// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-livepeer/protocol-929182cc684410d55eb9048f47ed1ec3ab70461a/contracts/test/RevertProxy.sol

pragma solidity ^0.4.18;


contract RevertProxy {
    bytes data;

    function() public {
        data = msg.data;
    }

    // solium-disable security/no-low-level-calls
    function execute(address _target) external returns (bool) {
        return _target.call(data);
    }
}
