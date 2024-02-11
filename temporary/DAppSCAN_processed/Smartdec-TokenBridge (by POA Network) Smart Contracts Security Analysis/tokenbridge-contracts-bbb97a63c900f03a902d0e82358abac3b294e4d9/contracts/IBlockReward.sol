// File: ../sc_datasets/DAppSCAN/Smartdec-TokenBridge (by POA Network) Smart Contracts Security Analysis/tokenbridge-contracts-bbb97a63c900f03a902d0e82358abac3b294e4d9/contracts/IBlockReward.sol

pragma solidity 0.4.24;


interface IBlockReward {
    function addExtraReceiver(uint256 _amount, address _receiver) external;
    function mintedTotally() public view returns (uint256);
    function mintedTotallyByBridge(address _bridge) public view returns(uint256);
    function bridgesAllowedLength() external view returns(uint256);
    function addBridgeTokenFeeReceivers(uint256 _amount) external;
    function addBridgeNativeFeeReceivers(uint256 _amount) external;
}
