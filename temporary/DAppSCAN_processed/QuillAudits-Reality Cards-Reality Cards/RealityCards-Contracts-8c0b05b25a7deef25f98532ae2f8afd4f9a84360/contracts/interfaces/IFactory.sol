// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IRealitio.sol

pragma solidity 0.5.13;

/// @title Realit.io contract interface
interface IRealitio 
{
    function askQuestion(uint256 template_id, string calldata question, address arbitrator, uint32 timeout, uint32 opening_ts, uint256 nonce) external payable returns (bytes32);
    function resultFor(bytes32 question_id) external view returns (bytes32);
    function isFinalized(bytes32 question_id) external view returns (bool);
    function getContentHash(bytes32 question_id) external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/ITreasury.sol

pragma solidity 0.5.13;

interface ITreasury
{
    function payout(address,uint256) external returns (bool);
    function payRent(address,uint256) external returns (bool);
    function addMarket(address) external returns (bool);
    function deposits(address) external returns (uint256);
    function setFactoryAddress() external returns(bool);
    function allocateCardSpecificDeposit(address,address,uint256,uint256) external returns (bool);
    function processHarbergerPayment(address,address,uint256) external returns (bool);
    function cardSpecificDeposits(address,address,uint256) external returns(uint256);
    function deposit(address) external payable returns (bool);
    function sponsor() external payable returns (bool);
    function hotPotatoDivisor() external payable returns (uint256);
    function updateTotalRental(address,uint256,bool) external returns (bool);
    function userTotalRentals(address) external returns (uint256);
    function updateLastRentalTime(address) external returns (bool);
    function minRentalDivisor() external returns (uint256);
    function maxContractBalance() external returns (uint256);
}

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

// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IRCNftHubXdai.sol

pragma solidity 0.5.13;

interface IRCNftHubXdai {
    function ownerOf(uint256) external view returns (address);
    function tokenURI(uint256) external view returns (string memory);
    function addMarket(address) external returns (bool);
    function mintNft(address,uint256,string calldata) external returns (bool);
    function transferNft(address,address,uint256) external returns (bool);
    function upgradeCard(address,uint256) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Reality Cards-Reality Cards/RealityCards-Contracts-8c0b05b25a7deef25f98532ae2f8afd4f9a84360/contracts/interfaces/IFactory.sol

pragma solidity 0.5.13;




interface IFactory
{
    function realitio() external returns (IRealitio);
    function proxy() external returns (IRCProxyXdai);
    function nfthub() external returns (IRCNftHubXdai);
    function treasury() external returns (ITreasury);
    function realitioTimeout() external returns (uint32);
    function arbitrator() external returns (address);
    function deposit() external payable returns(bool);
    function getPotDistribution() external returns(uint256[5] memory);
    function minimumPriceIncrease() external returns (uint256);
    function trapIfUnapproved() external returns(bool);
    function isMarketApproved(address) external returns(bool);
    function hotPotatoDivisor() external returns (uint256);
}
