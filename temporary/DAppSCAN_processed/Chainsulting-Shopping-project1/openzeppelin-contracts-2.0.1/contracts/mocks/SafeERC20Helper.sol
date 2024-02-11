// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.4.24;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
interface IERC20 {
  function totalSupply() external view returns (uint256);

  function balanceOf(address who) external view returns (uint256);

  function allowance(address owner, address spender)
    external view returns (uint256);

  function transfer(address to, uint256 value) external returns (bool);

  function approve(address spender, uint256 value)
    external returns (bool);

  function transferFrom(address from, address to, uint256 value)
    external returns (bool);

  event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
  );

  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/math/SafeMath.sol

pragma solidity ^0.4.24;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, reverts on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b);

    return c;
  }

  /**
  * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0); // Solidity only automatically asserts when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
  * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a);
    uint256 c = a - b;

    return c;
  }

  /**
  * @dev Adds two numbers, reverts on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);

    return c;
  }

  /**
  * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
  * reverts when dividing by zero.
  */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0);
    return a % b;
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.4.24;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {

  using SafeMath for uint256;

  function safeTransfer(
    IERC20 token,
    address to,
    uint256 value
  )
    internal
  {
    require(token.transfer(to, value));
  }

  function safeTransferFrom(
    IERC20 token,
    address from,
    address to,
    uint256 value
  )
    internal
  {
    require(token.transferFrom(from, to, value));
  }

  function safeApprove(
    IERC20 token,
    address spender,
    uint256 value
  )
    internal
  {
    // safeApprove should only be called when setting an initial allowance, 
    // or when resetting it to zero. To increase and decrease it, use 
    // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
    require((value == 0) || (token.allowance(address(this), spender) == 0));
    require(token.approve(spender, value));
  }

  function safeIncreaseAllowance(
    IERC20 token,
    address spender,
    uint256 value
  )
    internal
  {
    uint256 newAllowance = token.allowance(address(this), spender).add(value);
    require(token.approve(spender, newAllowance));
  }

  function safeDecreaseAllowance(
    IERC20 token,
    address spender,
    uint256 value
  )
    internal
  {
    uint256 newAllowance = token.allowance(address(this), spender).sub(value);
    require(token.approve(spender, newAllowance));
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Shopping-project1/openzeppelin-contracts-2.0.1/contracts/mocks/SafeERC20Helper.sol

pragma solidity ^0.4.24;


contract ERC20FailingMock {
  uint256 private _allowance;

  function transfer(address, uint256) public returns (bool) {
    return false;
  }

  function transferFrom(address, address, uint256) public returns (bool) {
    return false;
  }

  function approve(address, uint256) public returns (bool) {
    return false;
  }

  function allowance(address, address) public view returns (uint256) {
    return 0;
  }
}

contract ERC20SucceedingMock {
  mapping (address => uint256) private _allowances;

  function transfer(address, uint256) public returns (bool) {
    return true;
  }

  function transferFrom(address, address, uint256) public returns (bool) {
    return true;
  }

  function approve(address, uint256) public returns (bool) {
    return true;
  }

  function setAllowance(uint256 allowance_) public {
    _allowances[msg.sender] = allowance_;
  }

  function allowance(address owner, address) public view returns (uint256) {
    return _allowances[owner];
  }
}

contract SafeERC20Helper {
  using SafeERC20 for IERC20;

  IERC20 private _failing;
  IERC20 private _succeeding;

  constructor() public {
    _failing = IERC20(new ERC20FailingMock());
    _succeeding = IERC20(new ERC20SucceedingMock());
  }

  // Using _failing

  function doFailingTransfer() public {
    _failing.safeTransfer(address(0), 0);
  }

  function doFailingTransferFrom() public {
    _failing.safeTransferFrom(address(0), address(0), 0);
  }

  function doFailingApprove() public {
    _failing.safeApprove(address(0), 0);
  }

  function doFailingIncreaseAllowance() public {
    _failing.safeIncreaseAllowance(address(0), 0);
  }

  function doFailingDecreaseAllowance() public {
    _failing.safeDecreaseAllowance(address(0), 0);
  }

  // Using _succeeding

  function doSucceedingTransfer() public {
    _succeeding.safeTransfer(address(0), 0);
  }

  function doSucceedingTransferFrom() public {
    _succeeding.safeTransferFrom(address(0), address(0), 0);
  }

  function doSucceedingApprove(uint256 amount) public {
    _succeeding.safeApprove(address(0), amount);
  }

  function doSucceedingIncreaseAllowance(uint256 amount) public {
    _succeeding.safeIncreaseAllowance(address(0), amount);
  }

  function doSucceedingDecreaseAllowance(uint256 amount) public {
    _succeeding.safeDecreaseAllowance(address(0), amount);
  }

  function setAllowance(uint256 allowance_) public {
    ERC20SucceedingMock(_succeeding).setAllowance(allowance_);
  }

  function allowance() public view returns (uint256) {
    return _succeeding.allowance(address(0), address(0));
  }
}
