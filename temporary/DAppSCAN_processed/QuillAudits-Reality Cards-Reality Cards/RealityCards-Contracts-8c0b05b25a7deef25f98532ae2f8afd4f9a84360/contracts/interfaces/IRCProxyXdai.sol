// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IRCProxyXdai.sol

pragma solidity 0.5.13;

interface IRCProxyXdai {
    function setWinner(address _marketAddress, uint256 _winningOutcome) external;
    function saveQuestion(address _marketAddress, string calldata _question, uint32 _oracleResolutionTime) external;
    function isFinalized(address _marketAddress) external view returns(bool);
    function getWinner(address _marketAddress) external view returns(uint256); 
    function saveCardToUpgrade(uint256, string calldata, address) external;
    function addMarket(address) external returns (bool);
    function confirmDaiDeposit(address _user, uint256 _amount, uint256 _nonce) external;
}
