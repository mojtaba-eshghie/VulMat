// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/DutchCrowdsale/contracts/classes/token/IToken.sol

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

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/DutchCrowdsale/contracts/classes/sale/ISale.sol

pragma solidity ^0.4.23;

interface ISale {
  function buy() external payable;
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/DutchCrowdsale/contracts/classes/admin/IAdmin.sol

pragma solidity ^0.4.23;

interface IAdmin {
  function getAdmin() external view returns (address);
  function getCrowdsaleInfo() external view returns (uint, address, uint, bool, bool, bool);
  function isCrowdsaleFull() external view returns (bool, uint);
  function getCrowdsaleStartAndEndTimes() external view returns (uint, uint);
  function getCrowdsaleStatus() external view returns (uint, uint, uint, uint, uint, uint, bool);
  function getTokensSold() external view returns (uint);
  function getCrowdsaleWhitelist() external view returns (uint, address[]);
  function getWhitelistStatus(address) external view returns (uint, uint);
  function getCrowdsaleUniqueBuyers() external view returns (uint);
}

interface AdminIdx {
  function getAdmin(address, bytes32) external view returns (address);
  function getCrowdsaleInfo(address, bytes32) external view returns (uint, address, uint, bool, bool, bool);
  function isCrowdsaleFull(address, bytes32) external view returns (bool, uint);
  function getCrowdsaleStartAndEndTimes(address, bytes32) external view returns (uint, uint);
  function getCrowdsaleStatus(address, bytes32) external view returns (uint, uint, uint, uint, uint, uint, bool);
  function getTokensSold(address, bytes32) external view returns (uint);
  function getCrowdsaleWhitelist(address, bytes32) external view returns (uint, address[]);
  function getWhitelistStatus(address, bytes32, address) external view returns (uint, uint);
  function getCrowdsaleUniqueBuyers(address, bytes32) external view returns (uint);
}

// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/auth-os-applications-2840b97dea33c8cf455a67b2b9c7229e2cda1843/TokenWizard/crowdsale/DutchCrowdsale/contracts/IDutchCrowdsale.sol

pragma solidity ^0.4.23;



interface IDutchCrowdsale {
  function init(address, uint, uint, uint, uint, uint, uint, bool, address, bool) external;
}
