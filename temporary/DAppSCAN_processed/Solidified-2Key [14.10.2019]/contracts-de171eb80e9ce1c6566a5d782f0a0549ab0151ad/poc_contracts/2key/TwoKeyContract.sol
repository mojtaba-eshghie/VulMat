// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol

pragma solidity ^0.4.24;


/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * See https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address _who) public view returns (uint256);
  function transfer(address _to, uint256 _value) public returns (bool);
  function allowance(address _ocwner, address _spender) public view returns (uint256);
  function approve(address spender, uint tokens) public returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/math/SafeMath.sol

pragma solidity ^0.4.24;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (_a == 0) {
      return 0;
    }

    c = _a * _b;
    assert(c / _a == _b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
    // assert(_b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = _a / _b;
    // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold
    return _a / _b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
    assert(_b <= _a);
    return _a - _b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    c = _a + _b;
    assert(c >= _a);
    return c;
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/BasicToken.sol

pragma solidity ^0.4.24;


/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC20Basic {

  using SafeMath for uint256;

  mapping(address => uint256) internal balances;

  uint256 internal totalSupply_;
  string public name;
  string public symbol;
  uint8 public decimals;
  bool public frozen = false;

  /**
  * @dev Total number of tokens in existence
  */
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  /**
  * @dev Transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[msg.sender]);
    require(_to != address(0));

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }



  function approve(address _spender, uint256 _value) public returns (bool);
  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/ownership/Ownable.sol

pragma solidity ^0.4.24;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


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
   * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing to ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function transferOwnership(address _newOwner) public onlyOwner {
    _transferOwnership(_newOwner);
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address _newOwner) internal {
    require(_newOwner != address(0));
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol

pragma solidity ^0.4.24;


/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * https://github.com/ethereum/EIPs/issues/20
 * Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is ERC20Basic {

  using SafeMath for uint256;

  uint256 internal totalSupply_;
  string public name;
  string public symbol;
  uint8 public decimals;

  mapping (address => mapping (address => uint256)) internal allowed;
  mapping(address => uint256) internal balances;


  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  )
    public
    returns (bool)
  {
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    require(_to != address(0));

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(
    address _owner,
    address _spender
   )
    public
    view
    returns (uint256)
  {
    return allowed[_owner][_spender];
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _addedValue The amount of tokens to increase the allowance by.
   */
  function increaseApproval(
    address _spender,
    uint256 _addedValue
  )
    public
    returns (bool)
  {
    allowed[msg.sender][_spender] = (
      allowed[msg.sender][_spender].add(_addedValue));
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   * approve should be called when allowed[_spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseApproval(
    address _spender,
    uint256 _subtractedValue
  )
    public
    returns (bool)
  {
    uint256 oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue >= oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
  * @dev Total number of tokens in existence
  */
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  /**
  * @dev Transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[msg.sender]);
    require(_to != address(0));

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyTypes.sol

pragma solidity ^0.4.24;

contract TwoKeyTypes {
	enum CampaignType { NonFungible, Fungible, Counter, None }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/lifecycle/Destructible.sol

pragma solidity ^0.4.24;

/**
 * @title Destructible
 * @dev Base contract that can be destroyed by owner. All funds in contract will be sent to the owner.
 */
contract Destructible is Ownable {
  /**
   * @dev Transfers the current balance to the owner and terminates the contract.
   */
  function destroy() public onlyOwner {
    selfdestruct(owner);
  }

  function destroyAndSend(address _recipient) public onlyOwner {
    selfdestruct(_recipient);
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.4.24;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyEconomy.sol

pragma solidity ^0.4.24;



contract TwoKeyEconomy is StandardToken, Ownable {
  string public name = 'TwoKeyEconomy';
  string public symbol = '2Key';
  uint8 public decimals = 18;
//  uint256 private totalSupply_ = 1000000000000000000000000000;

  constructor() Ownable() public {
    totalSupply_ = 1000000000000000000000000000;
    balances[msg.sender] = totalSupply_;
  }

  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  )
  public
  returns (bool)
  {
    require(_value <= balances[_from]);
//    require(_value <= allowed[_from][msg.sender]);
    require(_to != address(0));

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
//    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.4.24;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
  function safeTransfer(
    ERC20Basic _token,
    address _to,
    uint256 _value
  )
    internal
  {
    require(_token.transfer(_to, _value));
  }

  function safeTransferFrom(
    ERC20 _token,
    address _from,
    address _to,
    uint256 _value
  )
    internal
  {
    require(_token.transferFrom(_from, _to, _value));
  }

  function safeApprove(
    ERC20 _token,
    address _spender,
    uint256 _value
  )
    internal
  {
    require(_token.approve(_spender, _value));
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol

pragma solidity ^0.4.24;



/**
 * @title Crowdsale
 * @dev Crowdsale is a base contract for managing a token crowdsale,
 * allowing investors to purchase tokens with ether. This contract implements
 * such functionality in its most fundamental form and can be extended to provide additional
 * functionality and/or custom behavior.
 * The external interface represents the basic interface for purchasing tokens, and conform
 * the base architecture for crowdsales. They are *not* intended to be modified / overridden.
 * The internal interface conforms the extensible and modifiable surface of crowdsales. Override
 * the methods to add functionality. Consider using 'super' where appropriate to concatenate
 * behavior.
 */
contract Crowdsale {
  using SafeMath for uint256;
  using SafeERC20 for ERC20;

  // The token being sold
  ERC20 public token;

  // Address where funds are collected
  address public wallet;

  // How many token units a buyer gets per wei.
  // The rate is the conversion between wei and the smallest and indivisible token unit.
  // So, if you are using a rate of 1 with a DetailedERC20 token with 3 decimals called TOK
  // 1 wei will give you 1 unit, or 0.001 TOK.
  uint256 public rate;

  // Amount of wei raised
  uint256 public weiRaised;

  /**
   * Event for token purchase logging
   * @param purchaser who paid for the tokens
   * @param beneficiary who got the tokens
   * @param value weis paid for purchase
   * @param amount amount of tokens purchased
   */
  event TokenPurchase(
    address indexed purchaser,
    address indexed beneficiary,
    uint256 value,
    uint256 amount
  );

  /**
   * @param _rate Number of token units a buyer gets per wei
   * @param _wallet Address where collected funds will be forwarded to
   * @param _token Address of the token being sold
   */
  constructor(uint256 _rate, address _wallet, ERC20 _token) public {
    require(_rate > 0);
    require(_wallet != address(0));
    require(_token != address(0));

    rate = _rate;
    wallet = _wallet;
    token = _token;
  }

  // -----------------------------------------
  // Crowdsale external interface
  // -----------------------------------------

  /**
   * @dev fallback function ***DO NOT OVERRIDE***
   */
  function () external payable {
    buyTokens(msg.sender);
  }

  /**
   * @dev low level token purchase ***DO NOT OVERRIDE***
   * @param _beneficiary Address performing the token purchase
   */
  function buyTokens(address _beneficiary) public payable {

    uint256 weiAmount = msg.value;
    _preValidatePurchase(_beneficiary, weiAmount);

    // calculate token amount to be created
    uint256 tokens = _getTokenAmount(weiAmount);

    // update state
    weiRaised = weiRaised.add(weiAmount);

    _processPurchase(_beneficiary, tokens);
    emit TokenPurchase(
      msg.sender,
      _beneficiary,
      weiAmount,
      tokens
    );

    _updatePurchasingState(_beneficiary, weiAmount);

    _forwardFunds();
    _postValidatePurchase(_beneficiary, weiAmount);
  }

  // -----------------------------------------
  // Internal interface (extensible)
  // -----------------------------------------

  /**
   * @dev Validation of an incoming purchase. Use require statements to revert state when conditions are not met. Use `super` in contracts that inherit from Crowdsale to extend their validations.
   * Example from CappedCrowdsale.sol's _preValidatePurchase method:
   *   super._preValidatePurchase(_beneficiary, _weiAmount);
   *   require(weiRaised.add(_weiAmount) <= cap);
   * @param _beneficiary Address performing the token purchase
   * @param _weiAmount Value in wei involved in the purchase
   */
  function _preValidatePurchase(
    address _beneficiary,
    uint256 _weiAmount
  )
  internal
  {
    require(_beneficiary != address(0));
    require(_weiAmount != 0);
  }

  /**
   * @dev Validation of an executed purchase. Observe state and use revert statements to undo rollback when valid conditions are not met.
   * @param _beneficiary Address performing the token purchase
   * @param _weiAmount Value in wei involved in the purchase
   */
  function _postValidatePurchase(
    address _beneficiary,
    uint256 _weiAmount
  )
  internal
  {
    // optional override
  }

  /**
   * @dev Source of tokens. Override this method to modify the way in which the crowdsale ultimately gets and sends its tokens.
   * @param _beneficiary Address performing the token purchase
   * @param _tokenAmount Number of tokens to be emitted
   */
  function _deliverTokens(
    address _beneficiary,
    uint256 _tokenAmount
  )
  internal
  {
    token.safeTransfer(_beneficiary, _tokenAmount);
  }

  /**
   * @dev Executed when a purchase has been validated and is ready to be executed. Not necessarily emits/sends tokens.
   * @param _beneficiary Address receiving the tokens
   * @param _tokenAmount Number of tokens to be purchased
   */
  function _processPurchase(
    address _beneficiary,
    uint256 _tokenAmount
  )
  internal
  {
    _deliverTokens(_beneficiary, _tokenAmount);
  }

  /**
   * @dev Override for extensions that require an internal state to check for validity (current user contributions, etc.)
   * @param _beneficiary Address receiving the tokens
   * @param _weiAmount Value in wei involved in the purchase
   */
  function _updatePurchasingState(
    address _beneficiary,
    uint256 _weiAmount
  )
  internal
  {
    // optional override
  }

  /**
   * @dev Override to extend the way in which ether is converted to tokens.
   * @param _weiAmount Value in wei to be converted into tokens
   * @return Number of tokens that can be purchased with the specified _weiAmount
   */
  function _getTokenAmount(uint256 _weiAmount)
  internal view returns (uint256)
  {
    return _weiAmount.mul(rate);
  }

  /**
   * @dev Determines how ETH is stored/forwarded on purchases.
   */
  function _forwardFunds() internal {
    wallet.transfer(msg.value);
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyUpgradableExchange.sol

pragma solidity ^0.4.24;



contract TwoKeyUpgradableExchange is Crowdsale, Ownable {

	address filler;

	event TokenSell(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);

	modifier onlyAlive() {
		require(filler == address(0));
		_;
	}

	constructor(uint256 _rate, address _wallet, ERC20 _token)
		Crowdsale(_rate, _wallet, _token) Ownable() public {
	}

	function sellTokens(uint256 _tokenAmount) public onlyAlive payable {
		require(token.allowance(this, msg.sender) >= _tokenAmount);
		require(token.transferFrom(msg.sender, this, _tokenAmount));

		uint256 weiAmount = _getWeiAmount(_tokenAmount);
		require(weiAmount >= address(this).balance);
	    weiRaised = weiRaised.sub(weiAmount);
	    msg.sender.transfer(weiAmount);

	    emit TokenSell(msg.sender, wallet, weiAmount, _tokenAmount);
	}

	function _getWeiAmount(uint256 _tokenAmount) internal view returns (uint256) {
	    return _tokenAmount.div(rate);
	}

	function upgrade(address _to) public onlyAlive onlyOwner {
		filler = _to;
	}

	function() external payable {
		if (filler != address(0))
			filler.transfer(msg.value);
	}

	function buyTokens(address _beneficiary) public onlyAlive payable {
		super.buyTokens(_beneficiary);
	}

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyAdmin.sol

pragma solidity ^0.4.24;



interface AdminContract {

	function replaceOneself(address newAdminContract) external;

	function transferByAdmins(address to, uint256 tokens) external;

	function upgradeEconomyExchangeByAdmins(address newExchange) external;

	function transferEtherByAdmins(address to, uint256 amount) external;

}

// SAFT are to be implemented by transferEtherByAdmins with the amount including the discount, according to the prevailing rate

contract TwoKeyAdmin is Ownable, Destructible, AdminContract {


	TwoKeyEconomy economy;
	address electorateAdmins;
	TwoKeyUpgradableExchange exchange;
	address public newAdmin;
	bool wasReplaced;

	constructor(
		TwoKeyEconomy _economy,
		address _electorateAdmins,
		TwoKeyUpgradableExchange _exchange) Ownable() Destructible() payable public {
		require(_economy != address(0));
		require(_electorateAdmins != address(0));
		require(_exchange != address(0));
		wasReplaced = false;
		economy = _economy;
		exchange = _exchange;
		electorateAdmins = _electorateAdmins;
	}

	function replaceOneself(address newAdminContract) external wasNotReplaced adminsVotingApproved {
		AdminContract adminContract = AdminContract(newAdminContract);
		uint balanceOfOldAdmin = economy.balanceOf(adminContract);
		// move to deploy
		wasReplaced = true;
		economy.transfer(newAdminContract, balanceOfOldAdmin);
		economy.transferOwnership(newAdminContract);
		exchange.transferOwnership(newAdminContract);
		newAdminContract.transfer(address(this).balance);
	}

	function transferByAdmins(address _to, uint256 _tokens) external wasNotReplaced adminsVotingApproved {
		economy.transfer(_to, _tokens);
	}


	function upgradeEconomyExchangeByAdmins(address newExchange) external wasNotReplaced adminsVotingApproved {
		if (newExchange != address(0))
			exchange.upgrade(newExchange);
	}

	function transferEtherByAdmins(address to, uint256 amount) external wasNotReplaced adminsVotingApproved {
		require(to != address(0)  && amount > 0);
		to.transfer(amount);
	}


	// lifecycle methods

	function() public payable {
		if (wasReplaced) {
			newAdmin.transfer(msg.value);
		}
	}

	function destroy() public adminsVotingApproved {
		if (wasReplaced)
			selfdestruct(owner);
		else
			selfdestruct(newAdmin);
	}

	// modifiers
	modifier adminsVotingApproved() {
		require(msg.sender == electorateAdmins);
	    _;
	}

	modifier wasNotReplaced() {
		require(!wasReplaced);
		_;
	}


}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/GetCode.sol

pragma solidity ^0.4.24;

/// The following example provides library code to access the code of another contract and load it into a bytes variable.
/// This is not possible at all with “plain Solidity" and the idea is that assembly libraries will be used to enhance the
/// language in such ways.

/// Took from Solidity official documentation
/// https://solidity.readthedocs.io/en/latest/assembly.html?highlight=getCode
library GetCode {
    function at(address _addr) internal view returns (bytes o_code) {
        assembly {
        // retrieve the size of the code, this needs assembly
            let size := extcodesize(_addr)
        // allocate output byte array - this could also be done without assembly
        // by using o_code = new bytes(size)
            o_code := mload(0x40)
        // new "memory end" including padding
            mstore(0x40, add(o_code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
        // store length in memory
            mstore(o_code, size)
        // actually retrieve the code, this needs assembly
            extcodecopy(_addr, add(o_code, 0x20), 0, size)
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyEventSource.sol

pragma solidity ^0.4.24;



contract TwoKeyEventSource is TwoKeyTypes {

    mapping(address => bool) public activeUser;

    /// Events
    event Created(address indexed _campaign, address indexed _owner);
    event Joined(address indexed _campaign, address indexed _from, address indexed _to);
    event Escrow(address indexed _campaign, address indexed _converter, uint256 _tokenID, address _childContractID, uint256 _indexOrAmount, CampaignType _type);
    event Rewarded(address indexed _campaign, address indexed _to, uint256 _amount);
    event Fulfilled(address indexed _campaign, address indexed _converter, uint256 indexed _tokenID, address _childContractID, uint256 _indexOrAmount, CampaignType _type);
    event Cancelled(address indexed _campaign, address indexed _converter, uint256 indexed _tokenID, address _childContractID, uint256 _indexOrAmount, CampaignType _type);
    event Code(bytes32 _code, uint256 _index);
    event PublicLinkKey(address campaign, address owner, address key);




    ///Address of the contract admin
    TwoKeyAdmin twoKeyAdmin;



    ///Mapping contract bytecode to boolean if is allowed to emit an event
    mapping(bytes32 => bool) canEmit;

    /// Mapping contract bytecode to enumerator CampaignType.
    mapping(bytes32 => CampaignType) codeToType;


    ///Mapping an address to boolean if allowed to modify
    mapping(address => bool) authorizedSubadmins;



    ///@notice Modifier which allows only admin to call a function - can be easily modified if there is going to be more admins
    modifier onlyAdmin {
        require(msg.sender == address(twoKeyAdmin));
        _;
    }

    ///@notice Modifier which allows all modifiers to update canEmit mapping - ever
    modifier onlyAuthorizedSubadmins {
        require(authorizedSubadmins[msg.sender] == true || msg.sender == address(twoKeyAdmin));
        _;
    }

    ///@notice Modifier which will only allow allowed contracts to emit an event
    modifier onlyAllowedContracts {
        //just to use contract code instead of msg.sender address
        bytes memory code = GetCode.at(msg.sender);
        bytes32 cc = keccak256(abi.encodePacked(code));
        emit Code(cc,1);
// TODO  fails     require(canEmit[cc] == true);
        _;
    }

    /// @notice Constructor during deployment of contract we need to set an admin address (means TwoKeyAdmin needs to be previously deployed)
    /// @param _twoKeyAdminAddress is the address of TwoKeyAdmin contract previously deployed
    constructor(address _twoKeyAdminAddress) public {
        twoKeyAdmin = TwoKeyAdmin(_twoKeyAdminAddress);
    }

    /// @notice function where admin or any authorized person (will be added if needed) can add more contracts to allow them call methods
    /// @param _contractAddress is actually the address of contract we'd like to allow
    /// @dev We first fetch bytes32 contract code and then update our mapping
    /// @dev only admin can call this or an authorized person
    function addContract(address _contractAddress) public onlyAuthorizedSubadmins {
        require(_contractAddress != address(0));
        bytes memory _contractCode = GetCode.at(_contractAddress);
        bytes32 cc = keccak256(abi.encodePacked(_contractCode));
        emit Code(cc,2);
        canEmit[cc] = true;
    }

    /// @notice function where admin or any authorized person (will be added if needed) can remove contract (disable permissions to emit Events)
    /// @param _contractAddress is actually the address of contract we'd like to disable
    /// @dev We first fetch bytes32 contract code and then update our mapping
    /// @dev only admin can call this or an authorized person
    function removeContract(address _contractAddress) public onlyAuthorizedSubadmins {
        require(_contractAddress != address(0));
        bytes memory _contractCode = GetCode.at(_contractAddress);
        bytes32 cc = keccak256(abi.encodePacked(_contractCode));
        emit Code(cc,3);
        canEmit[cc] = false;
    }

    /// @notice Function where an admin can authorize any other person to modify allowed contracts
    /// @param _newAddress is the address of new modifier contract / account
    /// @dev if only contract can be modifier then we'll add one more validation step
    function addAuthorizedAddress(address _newAddress) public onlyAdmin {
        require(_newAddress != address(0));
        authorizedSubadmins[_newAddress] = true;
    }

    /// @notice Function to remove authorization from an modifier
    /// @param _authorizedAddress is the address of modifier
    /// @dev checking if that address is set to true before since we'll spend 21k gas if it's already false to override that value
    function removeAuthorizedAddress(address _authorizedAddress) public onlyAdmin {
        require(_authorizedAddress != address(0));
        require(authorizedSubadmins[_authorizedAddress] == true);

        authorizedSubadmins[_authorizedAddress] = false;
    }

    /// @notice Function to map contract code to type of campaign
    /// @dev is contract required to be allowed to emit to even exist in mapping codeToType
    /// @param _contractCode is code od contract
    /// @param _campaignType is enumerator representing type of campaign
    function addCampaignType(bytes _contractCode, CampaignType _campaignType) public onlyAdmin {
        bytes32 cc = keccak256(abi.encodePacked(_contractCode));
        require(canEmit[cc] == true); //Check if this validation is needed
        codeToType[cc] = _campaignType;
    }

    /// @notice Function where admin can be changed
    /// @param _newAdminAddress is the address of new admin
    /// @dev think about some security layer here
    function changeAdmin(address _newAdminAddress) public onlyAdmin {
        twoKeyAdmin = TwoKeyAdmin(_newAdminAddress);
    }

    function checkCanEmit(bytes _contractCode) public view returns (bool) {
        bytes32 cc = keccak256(abi.encodePacked(_contractCode));
        return canEmit[cc];
    }

    /// @dev Only allowed contracts can call this function ---> means can emit events
    // TODO use msg.sender instead of _campaign
    function created(address _campaign, address _owner) public onlyAllowedContracts{
    	emit Created(_campaign, _owner);
    }

    /// @dev Only allowed contracts can call this function ---> means can emit events
    // TODO use msg.sender instead of _campaign
    function joined(address _campaign, address _from, address _to) public onlyAllowedContracts {
      activeUser[_to] = true;  // do we want to do it also for _from and created, escrow, rewarded, fulfilled
    	emit Joined(_campaign, _from, _to);
    }

    /// @dev Only allowed contracts can call this function ---> means can emit events
    // TODO use msg.sender instead of _campaign
    function escrow(address _campaign, address _converter, uint256 _tokenID, address _childContractID, uint256 _indexOrAmount, CampaignType _type) public onlyAllowedContracts{
    	emit Escrow(_campaign, _converter, _tokenID, _childContractID, _indexOrAmount, _type);
    }

    /// @dev Only allowed contracts can call this function ---> means can emit events
    // TODO use msg.sender instead of _campaign
    function rewarded(address _campaign, address _to, uint256 _amount) public onlyAllowedContracts {
    	emit Rewarded(_campaign, _to, _amount);
	}

    /// @dev Only allowed contracts can call this function ---> means can emit events
    // TODO use msg.sender instead of _campaign
	function fulfilled(address  _campaign, address _converter, uint256 _tokenID, address _childContractID, uint256 _indexOrAmount, CampaignType _type) public onlyAllowedContracts {
		emit Fulfilled(_campaign, _converter, _tokenID, _childContractID, _indexOrAmount, _type);
	}

    /// @dev Only allowed contracts can call this function ---> means can emit events
    // TODO use msg.sender instead of _campaign
	function cancelled(address  _campaign, address _converter, uint256 _tokenID, address _childContractID, uint256 _indexOrAmount, CampaignType _type) public onlyAllowedContracts{
		emit Cancelled(_campaign, _converter, _tokenID, _childContractID, _indexOrAmount, _type);
	}


    function getAdmin() public view returns (address) {
        return address(twoKeyAdmin);
    }

    function checkIsAuthorized(address _subAdmin) public view returns (bool) {
        return authorizedSubadmins[_subAdmin];
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/Call.sol

pragma solidity ^0.4.24;

library Call {
    function params0(address c, bytes _method) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x04, // Inputs are 0 bytes long
            ptr,  //Store output over input
            0x20) //Outputs are 1 bytes long

            if eq(result, 0) {
                revert(0, 0)
            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
        }
    }

    function params1(address c, bytes _method, uint _val) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)
        // append argument after function sig
            mstore(add(ptr,0x04), _val)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x24, // Inputs are 0 bytes long
            ptr,  //Store output over input
            0x20) //Outputs are 1 bytes long

            if eq(result, 0) {
                revert(0, 0)
            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
        }
    }

    function params2(address c, bytes _method, uint _val1, uint _val2) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)
        // append argument after function sig
            mstore(add(ptr,0x04), _val1)
            mstore(add(ptr,0x24), _val2)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x44, // Inputs are 4 bytes for signature and 2 uint256
            ptr,  //Store output over input
            0x20) //Outputs are 1 uint long

        // TODO cause revert
        //            if eq(result, 0) {
        //                revert(0, 0)
        //            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x20)) // Set storage pointer to new space
        }
    }

    function loadAddress(bytes sig, uint idx) public pure returns (address) {
        address influencer;
        idx += 20;
        assembly
        {
            influencer := mload(add(sig, idx))
        }
        return influencer;
    }

    function loadUint8(bytes sig, uint idx) public pure returns (uint8) {
        uint8 weight;
        idx += 1;
        assembly
        {
            weight := mload(add(sig, idx))
        }
        return weight;
    }


    function recoverHash(bytes32 hash, bytes sig, uint idx) public pure returns (address) {
        // same as recoverHash in utils/sign.js
        // The signature format is a compact form of:
        //   {bytes32 r}{bytes32 s}{uint8 v}
        // Compact means, uint8 is not padded to 32 bytes.
        require (sig.length >= 65+idx, 'bad signature length');
        idx += 32;
        bytes32 r;
        assembly
        {
            r := mload(add(sig, idx))
        }

        idx += 32;
        bytes32 s;
        assembly
        {
            s := mload(add(sig, idx))
        }

        idx += 1;
        uint8 v;
        assembly
        {
            v := mload(add(sig, idx))
        }
        if (v >= 32) { // handle case when signature was made with ethereum web3.eth.sign or getSign which is for signing ethereum transactions
            v -= 32;
            bytes memory prefix = "\x19Ethereum Signed Message:\n32"; // 32 is the number of bytes in the following hash
            hash = keccak256(abi.encodePacked(prefix, hash));
        }
        if (v <= 1) v += 27;
        require(v==27 || v==28,'bad sig v');
        return ecrecover(hash, v, r, s);

    }

    function recoverSigMemory(bytes sig) private pure returns (address[], address[], uint8[], uint[], uint) {
        uint8 version = loadUint8(sig, 0);
        uint msg_len = (version == 1) ? 1+65+20 : 1+20+20;
        uint n_influencers = (sig.length-21) / (65+msg_len);
        uint8[] memory weights = new uint8[](n_influencers);
        address[] memory keys = new address[](n_influencers);
        if ((sig.length-21) % (65+msg_len) > 0) {
            n_influencers++;
        }
        address[] memory influencers = new address[](n_influencers);
        uint[] memory offsets = new uint[](n_influencers);

        return (influencers, keys, weights, offsets, msg_len);
    }

    function recoverSigParts(bytes sig, address last_address) private pure returns (address[], address[], uint8[], uint[]) {
        // sig structure:
        // 1 byte version 0 or 1
        // 20 bytes are the address of the contractor or the influencer who created sig.
        //  this is the "anchor" of the link
        //  It must have a public key aleady stored for it in public_link_key
        // Begining of a loop on steps in the link:
        // * 65 bytes are step-signature using the secret from previous step
        // * message of the step that is going to be hashed and used to compute the above step-signature.
        //   message length depend on version 41 (version 0) or 86 (version 1):
        //   * 1 byte cut (percentage) each influencer takes from the bounty. the cut is stored in influencer2cut or weight for voting
        //   * 20 bytes address of influencer (version 0) or 65 bytes of signature of cut using the influencer address to sign
        //   * 20 bytes public key of the last secret
        // In the last step the message can be optional. If it is missing the message used is the address of the sender
        uint idx = 0;
        uint msg_len;
        uint8[] memory weights;
        address[] memory keys;
        address[] memory influencers;
        uint[] memory offsets;
        (influencers, keys, weights, offsets, msg_len) = recoverSigMemory(sig);
        idx += 1;  // skip version

        idx += 20; // skip old_address which should be read by the caller in order to get old_key
        uint count_influencers = 0;

        while (idx + 65 <= sig.length) {
            offsets[count_influencers] = idx;
            idx += 65;  // idx was increased by 65 for the signature at the begining which we will process later

            if (idx + msg_len <= sig.length) {  // its  a < and not a <= because we dont want this to be the final iteration for the converter
                weights[count_influencers] = loadUint8(sig, idx);
                require(weights[count_influencers] > 0,'weight not defined (1..255)');  // 255 are used to indicate default (equal part) behaviour
                idx++;


                if (msg_len == 41)  // 1+20+20 version 0
                {
                    influencers[count_influencers] = loadAddress(sig, idx);
                    idx += 20;
                    keys[count_influencers] = loadAddress(sig, idx);
                    idx += 20;
                } else if (msg_len == 86)  // 1+65+20 version 1
                {
                    keys[count_influencers] = loadAddress(sig, idx+65);
                    influencers[count_influencers] = recoverHash(
                        keccak256(
                            abi.encodePacked(
                                keccak256(abi.encodePacked("bytes binding to weight","bytes binding to public")),
                                keccak256(abi.encodePacked(weights[count_influencers],keys[count_influencers]))
                            )
                        ),sig,idx);
                    idx += 65;
                    idx += 20;
                }

            } else {
                // handle short signatures generated with free_take
                influencers[count_influencers] = last_address;
            }
            count_influencers++;
        }
        require(idx == sig.length,'illegal message size');

        return (influencers, keys, weights, offsets);
    }

    function recoverSig(bytes sig, address old_key, address last_address) public pure returns (address[], address[], uint8[]) {
        // validate sig AND
        // recover the information from the signature: influencers, public_link_keys, weights/cuts
        // influencers may have one more address than the keys and weights arrays
        //
        require(old_key != address(0),'no public link key');

        address[] memory influencers;
        address[] memory keys;
        uint8[] memory weights;
        uint[] memory offsets;
        (influencers, keys, weights, offsets) = recoverSigParts(sig, last_address);

        // check if we received a valid signature
        for(uint i = 0; i < influencers.length; i++) {
            if (i < weights.length) {
                require (recoverHash(keccak256(abi.encodePacked(weights[i], keys[i], influencers[i])),sig,offsets[i]) == old_key, 'illegal signature');
                old_key = keys[i];
            } else {
                // signed message for the last step is the address of the converter
                require (recoverHash(keccak256(abi.encodePacked(influencers[i])),sig,offsets[i]) == old_key, 'illegal last signature');
            }
        }

        return (influencers, keys, weights);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyReg.sol

pragma solidity ^0.4.24;




contract TwoKeyReg is Ownable {
  mapping(address => string) public owner2name;
  mapping(bytes32 => address) public name2owner;
  // plasma address => ethereum address
  // note that more than one plasma address can point to the same ethereum address so it is not critical to use the same plasma address all the time for the same user
  // in some cases the plasma address will be the same as the ethereum address and in that case it is not necessary to have an entry
  // the way to know if an address is a plasma address is to look it up in this mapping
  mapping(address => address) public plasma2ethereum;
  mapping(address => address) public ethereum2plasma;
  mapping(address => bytes) public notes;

  event UserNameChanged(address owner, string name);

  TwoKeyEventSource eventSource;

  // Initialize all the constants
  constructor(TwoKeyEventSource _eventSource) public {
    eventSource = _eventSource;
  }

  function addNameInternal(string _name, address _sender) private {
    // check if name is taken
    require(name2owner[keccak256(abi.encodePacked(_name))] == 0 || name2owner[keccak256(abi.encodePacked(_name))] == _sender, "name already assigned");

    // remove previous name
    bytes memory last_name = bytes(owner2name[_sender]);
    if (last_name.length != 0) {
      name2owner[keccak256(abi.encodePacked(owner2name[_sender]))] = 0;
    }
    owner2name[_sender] = _name;
    name2owner[keccak256(abi.encodePacked(_name))] = _sender;
    emit UserNameChanged(_sender, _name);
  }

  function addName(string _name, address _sender) onlyOwner public {
    addNameInternal(_name, _sender);
  }

  function addNameByUser(string _name) public {
    addNameInternal(_name, msg.sender);
  }

  function addNameSigned(string _name, bytes external_sig) public {
    bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to name")),
      keccak256(abi.encodePacked(_name))));
    address eth_address = Call.recoverHash(hash,external_sig,0);
    require (msg.sender == eth_address || msg.sender == owner, "only owner or user can change name");
    addNameInternal(_name, eth_address);
  }

  function setNoteInternal(bytes note, address me) private {
    // note is a message you can store with sig. For example it could be the secret you used encrypted by you
    notes[me] = note;
  }

  function setNoteByUser(bytes note) public {
    // note is a message you can store with sig. For example it could be the secret you used encrypted by you
    setNoteInternal(note, msg.sender);
  }

  function addPlasma2EthereumInternal(bytes sig, address eth_address) private {
      // add an entry connecting msg.sender to the ethereum address that was used to sign sig.
      // see setup_demo.js on how to generate sig
    bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to ethereum address")),keccak256(abi.encodePacked(eth_address))));
    address plasma_address = Call.recoverHash(hash,sig,0);
    require(plasma2ethereum[plasma_address] == address(0) || plasma2ethereum[plasma_address] == eth_address, "cant change eth=>plasma");
    plasma2ethereum[plasma_address] = eth_address;
    ethereum2plasma[eth_address] = plasma_address;
  }

  function addPlasma2EthereumByUser(bytes sig) public {
    addPlasma2EthereumInternal(sig, msg.sender);
  }

  function setPlasma2EthereumAndNoteSigned(bytes sig, bytes note, bytes external_sig) public {
    bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding to ethereum-plasma")),
      keccak256(abi.encodePacked(sig,note))));
    address eth_address = Call.recoverHash(hash,external_sig,0);
    require (msg.sender == eth_address || msg.sender == owner, "only owner or user can change ethereum-plasma");
    addPlasma2EthereumInternal(sig, eth_address);
    setNoteInternal(note, eth_address);
  }

  function getName2Owner(string _name) public view returns (address) {
    return name2owner[keccak256(abi.encodePacked(_name))];
  }
  function getOwner2Name(address _sender) public view returns (string) {
    return owner2name[_sender];
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyContract.sol

pragma solidity ^0.4.24; //We have to specify what version of compiler this code will use






/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract TwoKeyContract is StandardToken, Ownable {
  event Fulfilled(address indexed to, uint256 units);
  event Rewarded(address indexed to, uint256 amount);
  event Log1(string s, uint256 units);
  event Log1A(string s, address a);


  using SafeMath for uint256;
  // Public variables of the token
  TwoKeyReg registry;
  TwoKeyEventSource eventSource;

  // address public owner;  // Who created the contract (business) // contained in Ownable.sol
  address owner_plasma; // must be set in constructor
  string public name;
  string public ipfs_hash;
  string public symbol;
  uint8 public decimals = 0;  // ARCs are not divisable
  uint256 public cost; // Cost of product in wei
  uint256 public bounty; // Cost of product in wei
  uint256 public quota;  // maximal tokens that can be passed in transferFrom
  uint256 unit_decimals;  // units being sold can be fractional (for example tokens in ERC20)

  // Private variables of the token
  // in all mappings the address is always a plasma address
  mapping (address => address) public received_from;
  mapping(address => uint256) public xbalances; // balance of external currency (ETH or 2Key coin)
  mapping(address => uint256) public units; // number of units bought

  // The cut from the bounty each influencer is taking + 1
  // zero (also the default value) indicates default behaviour in which the influencer takes an equal amount as other influencers
  mapping(address => uint256) internal influencer2cut;

  // All user information is stored on their plasma address
  // a msg sender must have a plasma address in registry
  function senderPlasma() public view returns (address) {
    address me = msg.sender;
    if (registry == address(0)) {
      return me;
    }
    address plasma = registry.ethereum2plasma(me);
    require(plasma != address(0),'your plasma address was not found in registry');

    return plasma;
  }

  function plasmaOf(address me) public view returns (address) {
    address plasma = me;
    if (registry == address(0)) {
      return plasma;
    }
    plasma = registry.ethereum2plasma(plasma);
    if (plasma != address(0)) {
      return plasma;
    }
    return me;  // assume me is a plasma address. TODO not to make this assumption
  }

  function ethereumOf(address me) public view returns (address) {
    // used in TwoKeyWeightedVoteContract to move coins
    address ethereum = me;
    if (registry == address(0)) {
      return ethereum;
    }
    ethereum = registry.plasma2ethereum(ethereum);
    if (ethereum != address(0)) {
      return ethereum;
    }
    return me; // assume me is a ethereum address. TODO not to make this assumption
  }

  function setCutOf(address me, uint256 cut) internal {
    // what is the percentage of the bounty s/he will receive when acting as an influencer
    // the value 255 is used to signal equal partition with other influencers
    // A sender can set the value only once in a contract
    address plasma = plasmaOf(me);
    require(influencer2cut[plasma] == 0 || influencer2cut[plasma] == cut, 'cut already set differently');
    influencer2cut[plasma] = cut;
  }

  function setCut(uint256 cut) public {
    setCutOf(msg.sender, cut);
  }

  function cutOf(address me) public view returns (uint256) {
    return influencer2cut[plasmaOf(me)];
  }

  function getCuts(address last_influencer) public view returns (uint256[]) {
    address[] memory influencers = getInfluencers(last_influencer);
    uint n_influencers = influencers.length;
    uint256[] memory cuts = new uint256[](n_influencers + 1);
    for (uint i = 0; i < n_influencers; i++) {
      address influencer = influencers[i];
      cuts[i] = cutOf(influencer);
    }
    cuts[n_influencers] = cutOf(last_influencer);
    return cuts;
  }

  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from ALREADY converted to plasma
   * @param _to address The address which you want to transfer to ALREADY converted to plasma
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(address _from, address _to, uint256 _value) public onlyOwner returns (bool) {
    return transferFromInternal(_from, _to, _value);
  }
  function transferFromInternal(address _from, address _to, uint256 _value) internal returns (bool) {
    // _from and _to are assumed to be already converted to plasma address (e.g. using plasmaOf)
    require(_value == 1, 'can only transfer 1 ARC');
    require(_from != address(0), '_from undefined');
    require(_to != address(0), '_to undefined');
    _from = plasmaOf(_from);
    _to = plasmaOf(_to);

//    // normalize address to be plasma
//    _from = plasmaOf(_from);
//    _to = plasmaOf(_to);

    require(balances[_from] > 0,'_from does not have arcs');
    balances[_from] = balances[_from].sub(1);
    balances[_to] = balances[_to].add(quota);
    totalSupply_ = totalSupply_.add(quota.sub(1));

    emit Transfer(_from, _to, 1);
    if (received_from[_to] == 0) {
      // inform the 2key admin contract, once, that an influencer has joined
      if (eventSource != address(0)) {
        eventSource.joined(this, _from, _to);
      }
    }
    received_from[_to] = _from;
    return true;
  }

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    revert('transfer not implemented');
    return false;
  }

  function getConstantInfo() public view returns (string,string,uint256,uint256,uint256,address,string,uint256) {
    return (name,symbol,cost,bounty,quota,owner,ipfs_hash,unit_decimals);
  }

  function total_units() public view returns (uint256);

  /**
  * Gets the balance of the specified address.
  * me - The address to query the the balance of.
  * returns An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address me) public view returns (uint256) {
    return balances[plasmaOf(me)];
  }

  function xbalanceOf(address me) public view returns (uint256) {
    return xbalances[plasmaOf(me)];
  }

  function unitsOf(address me) public view returns (uint256) {
    return units[plasmaOf(me)];
  }

  function getDynamicInfo(address me) public view returns (uint256,uint256,uint256,uint256,uint256,uint256,uint256) {
    // address(this).balance is solidity reserved word for the the ETH amount deposited in the contract
    return (balanceOf(me),unitsOf(me),xbalanceOf(me),totalSupply_,address(this).balance,total_units(),cutOf(me));
  }

   function () external payable {
     buyProduct();
   }

  // buy product. if you dont have ARCs then first take them (join) from _from
  function buyFrom(address _from) public payable {
    _from = plasmaOf(_from);
    address _to = senderPlasma();
    if (balanceOf(_to) == 0) {
      transferFromInternal(_from, _to, 1);
    }
    buyProduct();
  }

  function redeem() public {
    address influencer = senderPlasma();
    uint256 b = xbalances[influencer];


    uint256 bmax = address(this).balance;
    if (b > bmax) {
      b = bmax;
    }
    if (b == 0) {
      return;
    }

    xbalances[influencer] = xbalances[influencer].sub(b);
    // super important to send to msg.senbder not to influencer
    if(!msg.sender.send(b)) {
       revert("failed to send");
    }
  }

  // low level product purchase function
  function buyProduct() public payable;

  function getInfluencers(address customer) public view returns (address[]) {
    // build a list of all influencers (using plasma adress) from converter back to to contractor
    // dont count the conveter and contractr themselves
    address influencer = plasmaOf(customer);
    // first count how many influencers
    uint n_influencers = 0;
    while (true) {
      influencer = plasmaOf(received_from[influencer]);  // already a plasma address
      require(influencer != address(0),'not connected to contractor');
      if (influencer == owner_plasma) {
        break;
      }
      n_influencers++;
    }
    // allocate temporary memory to hold the influencers
    address[] memory influencers = new address[](n_influencers);
    // fill the array of influencers in reverse order, from the last influencer just before the converter to the
    // first influencer just after the contractor
    influencer = plasmaOf(customer);
    while (n_influencers > 0) {
      influencer = plasmaOf(received_from[influencer]);
      n_influencers--;
      influencers[n_influencers] = influencer;
    }

    return influencers;
  }

  function buyProductInternal(uint256 _units, uint256 _bounty) public payable {
    // buy coins with cut
    // low level product purchase function
    address customer = senderPlasma();
    require(balanceOf(customer) > 0,"no arcs");

    uint256 _total_units = total_units();
//    emit Log1('_total_units',_total_units);

    require(_units > 0,"no units requested");
    require(_total_units >= _units,"not enough units available in stock");
    address[] memory influencers = getInfluencers(customer);
    uint n_influencers = influencers.length;

    // distribute bounty to influencers
    uint256 total_bounty = 0;
    for (uint i = 0; i < n_influencers; i++) {
      address influencer = plasmaOf(influencers[i]);  // influencers is in reverse order
      uint256 b;
      if (i == n_influencers-1) {  // if its the last influencer then all the bounty goes to it.
        b = _bounty;
      } else {
        uint256 cut = cutOf(influencer);
        if (cut > 0 && cut <= 101) {
          b = _bounty.mul(cut.sub(1)).div(100);
        } else {  // cut == 0 or 255 indicates equal particine of the bounty
          b = _bounty.div(n_influencers-i);
        }
      }
      xbalances[influencer] = xbalances[influencer].add(b);
      emit Rewarded(influencer, b);
      total_bounty = total_bounty.add(b);
      _bounty = _bounty.sub(b);
    }

    // all that is left from the cost is given to the owner for selling the product
    xbalances[owner_plasma] = xbalances[owner_plasma].add(msg.value).sub(total_bounty); // TODO we want the cost of a token to be fixed?
    units[customer] = units[customer].add(_units);

    emit Fulfilled(customer, units[customer]);
  }
}

contract TwoKeyAcquisitionContract is TwoKeyContract
{
  uint256 public _total_units; // total number of units on offer

  // Initialize all the constants
  constructor(TwoKeyReg _reg, TwoKeyEventSource _eventSource, string _name, string _symbol,
        uint256 _tSupply, uint256 _quota, uint256 _cost, uint256 _bounty,
        uint256 _units, string _ipfs_hash) public {
    require(_bounty <= _cost,"bounty bigger than cost");
    // owner = msg.sender;  // done in Ownable()
    // We do an explicit type conversion from `address`
    // to `TwoKeyReg` and assume that the type of
    // the calling contract is TwoKeyReg, there is
    // no real way to check that.
    name = _name;
    symbol = _symbol;
    totalSupply_ = _tSupply;
    cost = _cost;
    bounty = _bounty;
    quota = _quota;
    _total_units = _units;
    ipfs_hash = _ipfs_hash;
    unit_decimals = 0;  // dont allow fractional units


    registry = _reg;
    owner_plasma = plasmaOf(owner); // can be called after setting registry
    received_from[owner_plasma] = owner_plasma;  // allow owner to buy from himself
    balances[owner_plasma] = _tSupply;

    if (_eventSource != address(0)) {
      eventSource = _eventSource;
      eventSource.created(this, owner);
    }
  }

  function total_units() public view returns (uint256) {
    return _total_units;
  }

  // low level product purchase function
  function buyProduct() public payable {
    // caluclate the number of units being purchased
    uint _units = msg.value.div(cost);
    require(msg.value == cost * _units, "ethere sent does not divide equally into units");
    // bounty is the cost of a single token. Compute the bounty for the units
    // we are buying
    uint256 _bounty = bounty.mul(_units);

    buyProductInternal(_units, _bounty);

    _total_units = _total_units.sub(_units);
  }
}

contract TwoKeyPresellContract is TwoKeyContract {
  StandardToken public erc20_token_sell_contract;

//  address dc;

  // Initialize all the constants
  constructor(TwoKeyReg _reg, TwoKeyEventSource _eventSource, string _name, string _symbol,
        uint256 _tSupply, uint256 _quota, uint256 _cost, uint256 _bounty,
        string _ipfs_hash, StandardToken _erc20_token_sell_contract) public {
    require(_bounty <= _cost,"bounty bigger than cost");
    // owner = msg.sender;  // done in Ownable()
    // We do an explicit type conversion from `address`
    // to `TwoKeyReg` and assume that the type of
    // the calling contract is TwoKeyReg, there is
    // no real way to check that.
    name = _name;
    symbol = _symbol;
    totalSupply_ = _tSupply;
    cost = _cost;
    bounty = _bounty;
    quota = _quota;
    ipfs_hash = _ipfs_hash;
    registry = _reg;
    owner_plasma = plasmaOf(owner); // can be called after setting registry
    received_from[owner_plasma] = owner_plasma;  // allow owner to buy from himself
    balances[owner_plasma] = _tSupply;
    if (_eventSource != address(0)) {
      eventSource = _eventSource;
      eventSource.created(this, owner);
    }

    if (_erc20_token_sell_contract != address(0)) {
      // fractional units are determined by the erc20 contract
      erc20_token_sell_contract = _erc20_token_sell_contract;
      unit_decimals = Call.params0(erc20_token_sell_contract, "decimals()");
//      emit Log1('start_unit_decimals', unit_decimals); // does not work in constructor on geth
      require(unit_decimals >= 0,"unit decimals to low");
      require(unit_decimals <= 18,"unit decimals to big");
    }
  }

  function total_units() public view returns (uint256) {
    uint256 _total_units;
//    _total_units = erc20_token_sell_contract.balanceOf(address(this));
    _total_units = Call.params1(erc20_token_sell_contract, "balanceOf(address)",uint(this));
    return _total_units;
  }

  // low level product purchase function

  function buyProduct() public payable {
//    emit Log1('unit_decimals', unit_decimals);
//    unit_decimals = 18; // uint256(erc20_token_sell_contract.decimals());
    // cost is the cost of a single token. Each token has 10**decimals units
    uint256 _units = msg.value.mul(10**unit_decimals).div(cost);
//    emit Log1('units', _units);
    // bounty is the cost of a single token. Compute the bounty for the units
    // we are buying
    uint256 _bounty = bounty.mul(_units).div(10**unit_decimals);
//    emit Log1('_bounty', _bounty);

    buyProductInternal(_units, _bounty);

//    emit Log1('going to transfer', _units);
//    emit Log1A('coin', address(erc20_token_sell_contract));

    // We are sending the bought coins to the ether address of the converter
    // keep this last
    require(address(erc20_token_sell_contract).call(bytes4(keccak256("transfer(address,uint256)")),msg.sender,_units),
      "failed to send coins");
  }
}
