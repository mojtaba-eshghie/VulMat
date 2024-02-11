// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IWETH.sol

pragma solidity ^0.6.6;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IUniswapV2Pair.sol

pragma solidity ^0.6.6;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IUniswapV2Callee.sol

pragma solidity ^0.6.6;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IUniswapV2Factory.sol

pragma solidity ^0.6.6;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/libs/SafeMath.sol

pragma solidity ^0.6.6;

// Contract on https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/libs/UniswapV2Library.sol

pragma solidity ^0.6.6;


library UniswapV2Library {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(997);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(1000);
        uint denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IERC20.sol

pragma solidity ^0.6.6;

// Contract on https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/interfaces/IACOToken.sol

pragma solidity ^0.6.6;

interface IACOToken is IERC20 {
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function decimals() external view returns(uint8);
    function underlying() external view returns (address);
    function strikeAsset() external view returns (address);
    function feeDestination() external view returns (address);
    function isCall() external view returns (bool);
    function strikePrice() external view returns (uint256);
    function expiryTime() external view returns (uint256);
    function totalCollateral() external view returns (uint256);
    function acoFee() external view returns (uint256);
    function underlyingSymbol() external view returns (string memory);
    function strikeAssetSymbol() external view returns (string memory);
    function underlyingDecimals() external view returns (uint8);
    function strikeAssetDecimals() external view returns (uint8);
    function currentCollateral(address account) external view returns(uint256);
    function unassignableCollateral(address account) external view returns(uint256);
    function assignableCollateral(address account) external view returns(uint256);
    function currentCollateralizedTokens(address account) external view returns(uint256);
    function unassignableTokens(address account) external view returns(uint256);
    function assignableTokens(address account) external view returns(uint256);
    function getCollateralAmount(uint256 tokenAmount) external view returns(uint256);
    function getTokenAmount(uint256 collateralAmount) external view returns(uint256);
    function getExerciseData(uint256 tokenAmount) external view returns(address, uint256);
    function getCollateralOnExercise(uint256 tokenAmount) external view returns(uint256, uint256);
    function collateral() external view returns(address);
    function mintPayable() external payable;
    function mintToPayable(address account) external payable;
    function mint(uint256 collateralAmount) external;
    function mintTo(address account, uint256 collateralAmount) external;
    function burn(uint256 tokenAmount) external;
    function burnFrom(address account, uint256 tokenAmount) external;
    function redeem() external;
    function redeemFrom(address account) external;
    function exercise(uint256 tokenAmount) external payable;
    function exerciseFrom(address account, uint256 tokenAmount) external payable;
    function exerciseAccounts(uint256 tokenAmount, address[] calldata accounts) external payable;
    function exerciseAccountsFrom(address account, uint256 tokenAmount, address[] calldata accounts) external payable;
    function clear() external;
    function clearFrom(address account) external;
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-ACO_Protocol/aco-36bcab024c9781d799381f8f973e99fd5b0f4d2d/smart-contracts/contracts/periphery/ACOFlashExercise.sol

pragma solidity ^0.6.6;






/**
 * @title ACOFlashExercise
 * @dev Contract to exercise ACO tokens using Uniswap Flash Swap.
 */
contract ACOFlashExercise is IUniswapV2Callee {
    
    /**
     * @dev The Uniswap factory address.
     */
    address immutable public uniswapFactory;

    /**
     * @dev The WETH address used on Uniswap.
     */
    address immutable public weth;
    
    /**
     * @dev Selector for ERC20 approve function.
     */
    bytes4 immutable internal _approveSelector;
    
    /**
     * @dev Selector for ERC20 transfer function.
     */
    bytes4 immutable internal _transferSelector;
    
    constructor(address _uniswapFactory, address _weth) public {
        uniswapFactory = _uniswapFactory;
        weth = _weth;
        
        _approveSelector = bytes4(keccak256(bytes("approve(address,uint256)")));
        _transferSelector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }
    
    /**
     * @dev To accept ether from the WETH.
     */
    receive() external payable {}
    
    /**
     * @dev Function to get the Uniswap pair for an ACO token.
     * @param acoToken Address of the ACO token.
     * @return The Uniswap pair for the ACO token.
     */
    function getUniswapPair(address acoToken) public view returns(address) {
        address underlying = _getUniswapToken(IACOToken(acoToken).underlying());
        address strikeAsset = _getUniswapToken(IACOToken(acoToken).strikeAsset());
        return IUniswapV2Factory(uniswapFactory).getPair(underlying, strikeAsset);
    }
    
    /**
     * @dev Function to get the required amount of collateral to be paid to Uniswap and the expected amount to exercise the ACO token.
     * @param acoToken Address of the ACO token.
     * @param tokenAmount Amount of tokens to be exercised.
     * @return The required amount of collateral to be paid to Uniswap and the expected amount to exercise the ACO token.
     */
    function getExerciseData(address acoToken, uint256 tokenAmount) public view returns(uint256, uint256) {
        if (tokenAmount > 0) {
            address pair = getUniswapPair(acoToken);
            if (pair != address(0)) {
                address token0 = IUniswapV2Pair(pair).token0();
                address token1 = IUniswapV2Pair(pair).token1();
                (uint256 reserve0, uint256 reserve1,) = IUniswapV2Pair(pair).getReserves();
                
                (address exerciseAddress, uint256 expectedAmount) = IACOToken(acoToken).getExerciseData(tokenAmount);
                exerciseAddress = _getUniswapToken(exerciseAddress);
                
                uint256 reserveIn = 0; 
                uint256 reserveOut = 0;
                if (exerciseAddress == token0 && expectedAmount < reserve0) {
                    reserveIn = reserve1;
                    reserveOut = reserve0;
                } else if (exerciseAddress == token1 && expectedAmount < reserve1) {
                    reserveIn = reserve0;
                    reserveOut = reserve1;
                }
                
                if (reserveIn > 0 && reserveOut > 0) {
                    uint256 amountRequired = UniswapV2Library.getAmountIn(expectedAmount, reserveIn, reserveOut);
                    return (amountRequired, expectedAmount);
                }
            }
        }
        return (0, 0);
    }
    
    /**
     * @dev Function to get the estimated collateral to be received through a flash exercise.
     * @param acoToken Address of the ACO token.
     * @param tokenAmount Amount of tokens to be exercised.
     * @return The estimated collateral to be received through a flash exercise.
     */
    function getEstimatedReturn(address acoToken, uint256 tokenAmount) public view returns(uint256) {
        (uint256 amountRequired,) = getExerciseData(acoToken, tokenAmount);
        if (amountRequired > 0) {
            (uint256 collateralAmount,) = IACOToken(acoToken).getCollateralOnExercise(tokenAmount);
            if (amountRequired < collateralAmount) {
                return collateralAmount - amountRequired;
            }
        }
        return 0;
    }
    
    /**
     * @dev Function to flash exercise ACO tokens.
     * The flash exercise uses the flash swap functionality on Uniswap.
     * No asset is required to exercise the ACO token because the own collateral redeemed is used to fulfill the terms of the contract.
     * The account will receive the remaining difference.
     * @param acoToken Address of the ACO token.
     * @param tokenAmount Amount of tokens to be exercised.
     * @param minimumCollateral The minimum amount of collateral accepted to be received on the flash exercise.
     */
    function flashExercise(address acoToken, uint256 tokenAmount, uint256 minimumCollateral) public {
        _flashExercise(acoToken, tokenAmount, minimumCollateral, new address[](0));
    }
    
    /**
     * @dev Function to flash exercise ACO tokens.
     * The flash exercise uses the flash swap functionality on Uniswap.
     * No asset is required to exercise the ACO token because the own collateral redeemed is used to fulfill the terms of the contract.
     * The account will receive the remaining difference.
     * @param acoToken Address of the ACO token.
     * @param tokenAmount Amount of tokens to be exercised.
     * @param minimumCollateral The minimum amount of collateral accepted to be received on the flash exercise.
     * @param accounts The array of addresses to get the deposited collateral. 
     */
    function flashExerciseAccounts(
        address acoToken, 
        uint256 tokenAmount, 
        uint256 minimumCollateral, 
        address[] memory accounts
    ) public {
        require(accounts.length > 0, "ACOFlashExercise::flashExerciseAccounts: Accounts are required");
        _flashExercise(acoToken, tokenAmount, minimumCollateral, accounts);
    }
    
     /**
     * @dev External function to called by the Uniswap pair on flash swap transaction.
     * @param sender Address of the sender of the Uniswap swap. It must be the ACOFlashExercise contract.
     * @param amount0Out Amount of token0 on Uniswap pair to be received on the flash swap.
     * @param amount1Out Amount of token1 on Uniswap pair to be received on the flash swap.
     * @param data The ABI encoded with ACO token flash exercise data.
     */
    function uniswapV2Call(
        address sender, 
        uint256 amount0Out, 
        uint256 amount1Out, 
        bytes calldata data
    ) external override {
        require(sender == address(this), "ACOFlashExercise::uniswapV2Call: Invalid sender");
        
        uint256 amountRequired;
        {
        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();
        require(msg.sender == IUniswapV2Factory(uniswapFactory).getPair(token0, token1), "ACOFlashExercise::uniswapV2Call: Invalid transaction sender"); 
        require(amount0Out == 0 || amount1Out == 0, "ACOFlashExercise::uniswapV2Call: Invalid out amounts"); 
        
        (uint256 reserve0, uint256 reserve1,) = IUniswapV2Pair(msg.sender).getReserves();
        uint256 reserveIn = amount0Out == 0 ? reserve0 : reserve1; 
        uint256 reserveOut = amount0Out == 0 ? reserve1 : reserve0; 
        amountRequired = UniswapV2Library.getAmountIn((amount0Out + amount1Out), reserveIn, reserveOut);
        }
        
        address acoToken;
        uint256 tokenAmount; 
        uint256 ethValue = 0;
        uint256 remainingAmount;
        address from;
        address[] memory accounts;
        {
        uint256 minimumCollateral;
        (from, acoToken, tokenAmount, minimumCollateral, accounts) = abi.decode(data, (address, address, uint256, uint256, address[]));
        (address exerciseAddress, uint256 expectedAmount) = IACOToken(acoToken).getExerciseData(tokenAmount);
        
        require(expectedAmount == (amount1Out + amount0Out), "ACOFlashExercise::uniswapV2Call: Invalid expected amount");
        
        (uint256 collateralAmount,) = IACOToken(acoToken).getCollateralOnExercise(tokenAmount);
        require(amountRequired <= collateralAmount, "ACOFlashExercise::uniswapV2Call: Insufficient collateral amount");
        
        remainingAmount = collateralAmount - amountRequired;
        require(remainingAmount >= minimumCollateral, "ACOFlashExercise::uniswapV2Call: Minimum amount not satisfied");
        
        if (_isEther(exerciseAddress)) {
            ethValue = expectedAmount;
            IWETH(weth).withdraw(expectedAmount);
        } else {
            _callApproveERC20(exerciseAddress, acoToken, expectedAmount);
        }
        }
        
        if (accounts.length == 0) {
            IACOToken(acoToken).exerciseFrom{value: ethValue}(from, tokenAmount);
        } else {
            IACOToken(acoToken).exerciseAccountsFrom{value: ethValue}(from, tokenAmount, accounts);
        }
        
        address collateral = IACOToken(acoToken).collateral();
        address uniswapPayment;
        if (_isEther(collateral)) {
            payable(from).transfer(remainingAmount);
            IWETH(weth).deposit{value: amountRequired}();
            uniswapPayment = weth;
        } else {
            _callTransferERC20(collateral, from, remainingAmount); 
            uniswapPayment = collateral;
        }
        
        _callTransferERC20(uniswapPayment, msg.sender, amountRequired); 
    }
    
    /**
     * @dev Internal function to flash exercise ACO tokens.
     * @param acoToken Address of the ACO token.
     * @param tokenAmount Amount of tokens to be exercised.
     * @param minimumCollateral The minimum amount of collateral accepted to be received on the flash exercise.
     * @param accounts The array of addresses to get the deposited collateral. Whether the array is empty the exercise will be executed using the standard method.
     */
    function _flashExercise(
        address acoToken, 
        uint256 tokenAmount, 
        uint256 minimumCollateral, 
        address[] memory accounts
    ) internal {
        address pair = getUniswapPair(acoToken);
        require(pair != address(0), "ACOFlashExercise::_flashExercise: Invalid Uniswap pair");
        
        (address exerciseAddress, uint256 expectedAmount) = IACOToken(acoToken).getExerciseData(tokenAmount);
        
        uint256 amount0Out = 0;
        uint256 amount1Out = 0;
        if (_getUniswapToken(exerciseAddress) == IUniswapV2Pair(pair).token0()) {
            amount0Out = expectedAmount;
        } else {
            amount1Out = expectedAmount;  
        }
        
        IUniswapV2Pair(pair).swap(amount0Out, amount1Out, address(this), abi.encode(msg.sender, acoToken, tokenAmount, minimumCollateral, accounts));
    }
    
    /**
     * @dev Internal function to get Uniswap token address.
     * The Ethereum address on ACO must be swapped to WETH to be used on Uniswap.
     * @param token Address of the token on ACO.
     * @return Uniswap token address.
     */
    function _getUniswapToken(address token) internal view returns(address) {
        if (_isEther(token)) {
            return weth;
        } else {
            return token;
        }
    }
    
    /**
     * @dev Internal function to get if the token is for Ethereum (0x0).
     * @param token Address to be checked.
     * @return Whether the address is for Ethereum.
     */ 
    function _isEther(address token) internal pure returns(bool) {
        return token == address(0);
    }
    
    /**
     * @dev Internal function to approve ERC20 tokens.
     * @param token Address of the token.
     * @param spender Authorized address.
     * @param amount Amount to transfer.
     */
    function _callApproveERC20(address token, address spender, uint256 amount) internal {
        (bool success, bytes memory returndata) = token.call(abi.encodeWithSelector(_approveSelector, spender, amount));
        require(success && (returndata.length == 0 || abi.decode(returndata, (bool))), "ACOTokenExercise::_callApproveERC20");
    }
    
    /**
     * @dev Internal function to transfer ERC20 tokens.
     * @param token Address of the token.
     * @param recipient Address of the transfer destination.
     * @param amount Amount to transfer.
     */
    function _callTransferERC20(address token, address recipient, uint256 amount) internal {
        (bool success, bytes memory returndata) = token.call(abi.encodeWithSelector(_transferSelector, recipient, amount));
        require(success && (returndata.length == 0 || abi.decode(returndata, (bool))), "ACOTokenExercise::_callTransferERC20");
    }
}
