// File: ../sc_datasets/DAppSCAN/Callisto_Network-Monsta Infinite Inception Security Audit Report/moni-smart-contracts-3303268d5456d51a5f7412be8cfca7e3caf73ed5/contracts/utils/SafeMath.sol

pragma solidity ^0.6.0;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-Monsta Infinite Inception Security Audit Report/moni-smart-contracts-3303268d5456d51a5f7412be8cfca7e3caf73ed5/contracts/utils/Ownable.sol

pragma solidity ^0.6.0;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address payable public owner;


  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address payable newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-Monsta Infinite Inception Security Audit Report/moni-smart-contracts-3303268d5456d51a5f7412be8cfca7e3caf73ed5/contracts/utils/Pausable.sol

pragma solidity ^0.6.0;

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Ownable {
  event Pause();
  event Unpause();

  bool public paused = false;


  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    emit Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-Monsta Infinite Inception Security Audit Report/moni-smart-contracts-3303268d5456d51a5f7412be8cfca7e3caf73ed5/contracts/presale/MonstaPresale.sol

pragma solidity 0.6.0;


contract MonstaPresale is Pausable {
  using SafeMath for uint;

  uint constant public PRESALE_END_TIMESTAMP = 1633957199; // No Monstas can be adopted after this end date: Monday, October 11, 2021 12:59:59 PM GMT
  uint constant public PRICE_INCREMENT = 383325347388596 wei; // 0.000383325347388596 BNB
  uint constant public INITIAL_PRICE = 200000000000000000; // 0.2 BNB
  uint constant public MAX_TOTAL_ADOPTED_MONSTA = 2088;
  uint constant public MAX_TOTAL_GIVEAWAY_MONSTA = 2000;

  uint public _currentPrice;
  uint public _totalAdoptedMonstas;
  uint public _totalGiveawayMonstas;
  uint public _totalRedeemedMonstas;

  address public _redemptionAddress;
  mapping(address => bool) public _adopters;

  event MonstaAdopted(address indexed adopter);
  event AdoptedMonstaRedeemed(address indexed receiver);

  modifier onlyRedemptionAddress {
    require(msg.sender == _redemptionAddress);
    _;
  }

  constructor() public {
    _currentPrice = INITIAL_PRICE;
  }

  /**
   * @dev Adopt some Monsta
   */
  function adoptMonsta() public payable whenNotPaused {
    require(now <= PRESALE_END_TIMESTAMP);
    require(!_adopters[msg.sender], "Only can adopt once");
    require(_totalAdoptedMonstas.add(1) <= MAX_TOTAL_ADOPTED_MONSTA);
    require(msg.value >= _currentPrice);
    
  
    uint value = msg.value.sub(_currentPrice);
    msg.sender.transfer(value);  // Refund back the remaining to the receiver

    _adopters[msg.sender] = true;
    _totalAdoptedMonstas = _totalAdoptedMonstas.add(1);
    _currentPrice = _currentPrice.add(PRICE_INCREMENT);
     
    emit MonstaAdopted(msg.sender);
  }
  
  /**
   * @dev Set redemption contract address
   */
  function setRedemptionAddress(address redemptionAddress) external onlyOwner {
    _redemptionAddress = redemptionAddress;
  }

  /**
  * @dev Redeem adopted monsta, onlyRedemptionAddress is a redemption contract address
  * @param receiver Address of the receiver.
  */
  function redeemAdoptedMonsta(address receiver) external onlyRedemptionAddress whenNotPaused returns(uint) {
    require(_adopters[receiver]);
     _totalRedeemedMonstas = _totalRedeemedMonstas.add(1);
     _adopters[receiver] = false;
    emit AdoptedMonstaRedeemed(receiver);
    return _totalRedeemedMonstas;
  }

  /**
   * @dev Giveaway monsta without effecting adopted Monsta counter counter
   */
  function giveaway(address[] calldata _addresses) external onlyOwner whenNotPaused {
    require(_totalGiveawayMonstas.add(_addresses.length) <= MAX_TOTAL_GIVEAWAY_MONSTA);
    uint given;
    for (uint i = 0; i < _addresses.length; i++) {
      if(!_adopters[_addresses[i]]){
        given++;
        _adopters[_addresses[i]] = true;
        emit MonstaAdopted(_addresses[i]);
      }
    }
    _totalGiveawayMonstas = _totalGiveawayMonstas.add(given);
  }
  
  /**
  * @dev Transfer all BNB held by the contract to the owner.
  */
  // SWC-Unprotected Ether Withdrawal: L94-197
  function reclaimBNB() external onlyOwner {
    owner.transfer(address(this).balance);
  }
}
