// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/upgradeable_contracts/Sacrifice.sol

pragma solidity 0.4.24;


contract Sacrifice {
    constructor(address _recipient) public payable {
        selfdestruct(_recipient);
    }
}
