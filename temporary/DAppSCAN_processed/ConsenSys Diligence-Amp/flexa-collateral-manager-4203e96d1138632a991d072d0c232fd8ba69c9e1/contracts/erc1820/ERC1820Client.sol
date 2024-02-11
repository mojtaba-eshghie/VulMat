// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Amp/flexa-collateral-manager-4203e96d1138632a991d072d0c232fd8ba69c9e1/contracts/erc1820/ERC1820Client.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;


interface ERC1820Registry {
    function setInterfaceImplementer(
        address _addr,
        bytes32 _interfaceHash,
        address _implementer
    ) external;
}


contract ERC1820Client {
    ERC1820Registry constant ERC1820REGISTRY = ERC1820Registry(
        0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24
    );

    function setInterfaceImplementation(string memory _interfaceLabel, address _implementation)
        internal
    {
        bytes32 interfaceHash = keccak256(abi.encodePacked(_interfaceLabel));
        ERC1820REGISTRY.setInterfaceImplementer(address(this), interfaceHash, _implementation);
    }
}
