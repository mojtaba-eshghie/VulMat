// File: ../sc_datasets/DAppSCAN/consensys-rICO/rICO-smart-contracts-77517a4dceed53ff7c5a7f7580cb805831a7f8d5/contracts/Gnosis/CreateCall.sol

pragma solidity 0.5.17;


/// @title Create Call - Allows to use the different create opcodes to deploy a contract
/// @author Richard Meissner - <richard@gnosis.io>
contract CreateCall {
    event ContractCreation(address newContract);

    function performCreate2(uint256 value, bytes memory deploymentData, bytes32 salt) public returns(address newContract) {
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            newContract := create2(value, add(0x20, deploymentData), mload(deploymentData), salt)
        }
        require(newContract != address(0), "Could not deploy contract");
        emit ContractCreation(newContract);
    }

    function performCreate(uint256 value, bytes memory deploymentData) public returns(address newContract) {
        //  solium-disable-next-line security/no-inline-assembly
        assembly {
            newContract := create(value, add(deploymentData, 0x00), mload(deploymentData))
        }
         require(newContract != address(0), "Could not deploy contract");
        emit ContractCreation(newContract);
    }
}
