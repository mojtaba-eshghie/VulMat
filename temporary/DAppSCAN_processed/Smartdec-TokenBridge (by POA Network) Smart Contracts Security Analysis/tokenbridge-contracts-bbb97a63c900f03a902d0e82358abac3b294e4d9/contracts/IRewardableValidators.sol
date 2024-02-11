// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/IRewardableValidators.sol

pragma solidity 0.4.24;


interface IRewardableValidators {
    function isValidator(address _validator) public view returns(bool);
    function requiredSignatures() public view returns(uint256);
    function owner() public view returns(address);
    function validatorList() public view returns (address[]);
    function getValidatorRewardAddress(address _validator) public view returns(address);
    function validatorCount() public view returns (uint256);
    function getNextValidator(address _address) public view returns (address);
}
