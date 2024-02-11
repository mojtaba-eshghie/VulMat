// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/interfaces/IRegistry.sol

pragma solidity 0.4.23;

// limited ContractRegistry definition
interface IRegistry {
  function owner() 
    external 
    returns(address);

  function updateContractAddress(
    string _name,
    address _address
  )
    external
    returns (address);

  function getContractAddress(
    string _name
  )
    external
    view
    returns (address);
}

// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/interfaces/IPoaManager.sol

pragma solidity 0.4.23;

interface IPoaManager {
  function getTokenStatus(
    address _tokenAddress
  )
    external
    view
    returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/interfaces/IPoaToken.sol

pragma solidity 0.4.23;

interface IPoaToken {
  function setupContract
  (
    string _name,
    string _symbol,
    // fiat symbol used in ExchangeRates
    string _fiatCurrency,
    address _broker,
    address _custodian,
    uint256 _totalSupply,
    // given as unix time (seconds since 01.01.1970)
    uint256 _startTime,
    // given as seconds
    uint256 _fundingTimeout,
    uint256 _activationTimeout,
    // given as fiat cents
    uint256 _fundingGoalInCents
  )
    external
    returns (bool);

  function pause()
    external;
  
  function unpause()
    external;
  
  function terminate()
    external
    returns (bool);
  
  function proofOfCustody()
    external
    view
    returns (string);
  
  function toggleWhitelistTransfers()
    external
    returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/contracts/CentralLogger.sol

pragma solidity 0.4.23;



contract CentralLogger {
  uint8 public constant version = 1;
  // registry instance to get other contract addresses
  IRegistry public registry;

  constructor(
    address _registryAddress
  )
    public
  {
    require(_registryAddress != address(0));
    registry = IRegistry(_registryAddress);
  }

  // only allow listed poa tokens to trigger events
  modifier onlyActivePoaToken() {
    require(
      IPoaManager(
        registry.getContractAddress("PoaManager")
      ).getTokenStatus(msg.sender)
    );
    _;
  }

  // possible events from a PoaToken
  event StageEvent(
    address indexed tokenAddress,
    uint256 stage
  );
  event BuyEvent(
    address indexed tokenAddress,
    address indexed buyer,
    uint256 amount
  );
  event ProofOfCustodyUpdatedEvent(
    address indexed tokenAddress,
    string ipfsHash
  );
  event PayoutEvent(
    address indexed tokenAddress,
    uint256 amount
  );
  event ClaimEvent(
    address indexed tokenAddress,
    address indexed claimer,
    uint256 payout
  );
  event TerminatedEvent(
    address indexed tokenAddress
  );
  event CustodianChangedEvent(
    address indexed tokenAddress,
    address oldAddress,
    address newAddress
  );
  event ReclaimEvent(
    address indexed tokenAddress,
    address indexed reclaimer,
    uint256 amount
  );

  // possible events from PoaProxy
  event ProxyUpgradedEvent(
    address indexed tokenAddress,
    address upgradedFrom,
    address upgradedTo
  );

  // event triggers for each event
  function logStageEvent(
    uint256 stage
  )
    external
    onlyActivePoaToken
  {
    emit StageEvent(msg.sender, stage);
  }

  function logBuyEvent(
    address buyer,
    uint256 amount
  )
    external
    onlyActivePoaToken
  {
    emit BuyEvent(msg.sender, buyer, amount);
  }

  function logProofOfCustodyUpdatedEvent()
    external
    onlyActivePoaToken
  {
    // easier to get the set ipfsHash from contract rather than send over string
    string memory _realIpfsHash = IPoaToken(msg.sender).proofOfCustody();

    emit ProofOfCustodyUpdatedEvent(
      msg.sender,
      _realIpfsHash
    );
  }

  function logPayoutEvent(
    uint256 _amount
  )
    external
    onlyActivePoaToken
  {
    emit PayoutEvent(
      msg.sender,
      _amount
    );
  }

  function logClaimEvent(
    address _claimer,
    uint256 _payout
    )
    external
    onlyActivePoaToken
  {
    emit ClaimEvent(
      msg.sender,
      _claimer,
      _payout
    );
  }

  function logTerminatedEvent()
    external
    onlyActivePoaToken
  {
    emit TerminatedEvent(msg.sender);
  }

  function logCustodianChangedEvent(
    address _oldAddress,
    address _newAddress
  )
    external
    onlyActivePoaToken
  {
    emit CustodianChangedEvent(
      msg.sender,
      _oldAddress,
      _newAddress
    );
  }

  function logReclaimEvent(
    address _reclaimer,
    uint256 _amount
  )
    external
    onlyActivePoaToken
  {
    emit ReclaimEvent(
      msg.sender,
      _reclaimer,
      _amount
    );
  }

  function logProxyUpgradedEvent(
    address _upgradedFrom,
    address _upgradedTo
  )
    external
    onlyActivePoaToken
  {
    emit ProxyUpgradedEvent(
      msg.sender,
      _upgradedFrom,
      _upgradedTo
    );
  }

  // keep money from entering this contract, unless selfdestruct of course :)
  function()
    public
    payable
  {
    revert();
  }
}
