// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/contracts/classes/token/IToken.sol

pragma solidity ^0.4.23;

interface IToken {
  function name() external view returns (string);
  function symbol() external view returns (string);
  function decimals() external view returns (uint8);
  function totalSupply() external view returns (uint);
  function balanceOf(address) external view returns (uint);
  function allowance(address, address) external view returns (uint);
  function transfer(address, uint) external returns (bool);
  function transferFrom(address, address, uint) external returns (bool);
  function approve(address, uint) external returns (bool);
  function increaseApproval(address, uint) external returns (bool);
  function decreaseApproval(address, uint) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint amt);
  event Approval(address indexed owner, address indexed spender, uint amt);
}

interface TokenIdx {
  function name(address, bytes32) external view returns (bytes32);
  function symbol(address, bytes32) external view returns (bytes32);
  function decimals(address, bytes32) external view returns (uint8);
  function totalSupply(address, bytes32) external view returns (uint);
  function balanceOf(address, bytes32, address) external view returns (uint);
  function allowance(address, bytes32, address, address) external view returns (uint);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/contracts/classes/sale/ISale.sol

pragma solidity ^0.4.23;

interface ISale {
  function buy() external payable;
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/contracts/classes/sale_manager/ISaleManager.sol

pragma solidity ^0.4.23;

interface ISaleManager {
  function getAdmin() external view returns (address);
  function getCrowdsaleInfo() external view returns (uint, address, bool, bool);
  function isCrowdsaleFull() external view returns (bool, uint);
  function getCrowdsaleStartAndEndTimes() external view returns (uint, uint);
  function getCurrentTierInfo() external view returns (bytes32, uint, uint, uint, uint, uint, bool, bool);
  function getCrowdsaleTier(uint) external view returns (bytes32, uint, uint, uint, uint, bool, bool);
  function getTierWhitelist(uint) external view returns (uint, address[]);
  function getCrowdsaleMaxRaise() external view returns (uint, uint);
  function getCrowdsaleTierList() external view returns (bytes32[]);
  function getCrowdsaleUniqueBuyers() external view returns (uint);
  function getTierStartAndEndDates(uint) external view returns (uint, uint);
  function getTokensSold() external view returns (uint);
  function getWhitelistStatus(uint, address) external view returns (uint, uint);
}

interface SaleManagerIdx {
  function getAdmin(address, bytes32) external view returns (address);
  function getCrowdsaleInfo(address, bytes32) external view returns (uint, address, bool, bool);
  function isCrowdsaleFull(address, bytes32) external view returns (bool, uint);
  function getCrowdsaleStartAndEndTimes(address, bytes32) external view returns (uint, uint);
  function getCurrentTierInfo(address, bytes32) external view returns (bytes32, uint, uint, uint, uint, uint, bool, bool);
  function getCrowdsaleTier(address, bytes32, uint) external view returns (bytes32, uint, uint, uint, uint, bool, bool);
  function getTierWhitelist(address, bytes32, uint) external view returns (uint, address[]);
  function getCrowdsaleMaxRaise(address, bytes32) external view returns (uint, uint);
  function getCrowdsaleTierList(address, bytes32) external view returns (bytes32[]);
  function getCrowdsaleUniqueBuyers(address, bytes32) external view returns (uint);
  function getTierStartAndEndDates(address, bytes32, uint) external view returns (uint, uint);
  function getTokensSold(address, bytes32) external view returns (uint);
  function getWhitelistStatus(address, bytes32, uint, address) external view returns (uint, uint);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/contracts/classes/token_manager/ITokenManager.sol

pragma solidity ^0.4.23;

interface ITokenManager {
  function getReservedTokenDestinationList() external view returns (uint, address[]);
  function getReservedDestinationInfo(address) external view returns (uint, uint, uint, uint);
}

interface TokenManagerIdx {
  function getReservedTokenDestinationList(address, bytes32) external view returns (uint, address[]);
  function getReservedDestinationInfo(address, bytes32, address) external view returns (uint, uint, uint, uint);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/MintedCappedCrowdsale/contracts/IMintedCapped.sol

pragma solidity ^0.4.23;




interface IMintedCapped {
  function init(address, uint, bytes32, uint, uint, uint, uint, bool, bool, address) external;
}
