// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/SafeMath.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

/**
 * @title SafeMath
 * @author DODO Breeder
 *
 * @notice Math operations with safety checks that revert on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "MUL_ERROR");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "DIVIDING_ERROR");
        return a / b;
    }

    function divCeil(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 quotient = div(a, b);
        uint256 remainder = a - quotient * b;
        if (remainder > 0) {
            return quotient + 1;
        } else {
            return quotient;
        }
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SUB_ERROR");
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "ADD_ERROR");
        return c;
    }

    function sqrt(uint256 x) internal pure returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/DecimalMath.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

/**
 * @title DecimalMath
 * @author DODO Breeder
 *
 * @notice Functions for fixed point number with 18 decimals
 */
library DecimalMath {
    using SafeMath for uint256;

    uint256 constant ONE = 10**18;

    function mul(uint256 target, uint256 d) internal pure returns (uint256) {
        return target.mul(d) / ONE;
    }

    function divFloor(uint256 target, uint256 d) internal pure returns (uint256) {
        return target.mul(ONE).div(d);
    }

    function divCeil(uint256 target, uint256 d) internal pure returns (uint256) {
        return target.mul(ONE).divCeil(d);
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/DODOMath.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;


/**
 * @title DODOMath
 * @author DODO Breeder
 *
 * @notice Functions for complex calculating. Including ONE Integration and TWO Quadratic solutions
 */
library DODOMath {
    using SafeMath for uint256;

    /*
        Integrate dodo curve fron V1 to V2
        require V0>=V1>=V2>0
        res = (1-k)i(V1-V2)+ikV0*V0(1/V2-1/V1)
        let V1-V2=delta
        res = i*delta*(1-k+k(V0^2/V1/V2))
    */
    function _GeneralIntegrate(
        uint256 V0,
        uint256 V1,
        uint256 V2,
        uint256 i,
        uint256 k
    ) internal pure returns (uint256) {
        uint256 fairAmount = DecimalMath.mul(i, V1.sub(V2)); // i*delta
        uint256 V0V1 = DecimalMath.divCeil(V0, V1); // V0/V1
        uint256 V0V2 = DecimalMath.divCeil(V0, V2); // V0/V2
        uint256 penalty = DecimalMath.mul(DecimalMath.mul(k, V0V1), V0V2); // k(V0^2/V1/V2)
        return DecimalMath.mul(fairAmount, DecimalMath.ONE.sub(k).add(penalty));
    }

    /*
        The same with integration expression above, we have:
        i*deltaB = (Q2-Q1)*(1-k+kQ0^2/Q1/Q2)
        Given Q1 and deltaB, solve Q2
        This is a quadratic function and the standard version is
        aQ2^2 + bQ2 + c = 0, where
        a=1-k
        -b=(1-k)Q1-kQ0^2/Q1+i*deltaB
        c=-kQ0^2
        and Q2=(-b+sqrt(b^2+4(1-k)kQ0^2))/2(1-k)
        note: another root is negative, abondan
        if deltaBSig=true, then Q2>Q1
        if deltaBSig=false, then Q2<Q1
    */
    function _SolveQuadraticFunctionForTrade(
        uint256 Q0,
        uint256 Q1,
        uint256 ideltaB,
        bool deltaBSig,
        uint256 k
    ) internal pure returns (uint256) {
        // calculate -b value and sig
        // -b = (1-k)Q1-kQ0^2/Q1+i*deltaB
        uint256 kQ02Q1 = DecimalMath.mul(k, Q0).mul(Q0).div(Q1); // kQ0^2/Q1
        uint256 b = DecimalMath.mul(DecimalMath.ONE.sub(k), Q1); // (1-k)Q1
        bool minusbSig = true;
        if (deltaBSig) {
            b = b.add(ideltaB); // (1-k)Q1+i*deltaB
        } else {
            kQ02Q1 = kQ02Q1.add(ideltaB); // -i*(-deltaB)-kQ0^2/Q1
        }
        if (b >= kQ02Q1) {
            b = b.sub(kQ02Q1);
            minusbSig = true;
        } else {
            b = kQ02Q1.sub(b);
            minusbSig = false;
        }

        // calculate sqrt
        uint256 squareRoot = DecimalMath.mul(
            DecimalMath.ONE.sub(k).mul(4),
            DecimalMath.mul(k, Q0).mul(Q0)
        ); // 4(1-k)kQ0^2
        squareRoot = b.mul(b).add(squareRoot).sqrt(); // sqrt(b*b-4(1-k)kQ0*Q0)

        // final res
        uint256 denominator = DecimalMath.ONE.sub(k).mul(2); // 2(1-k)
        if (minusbSig) {
            return DecimalMath.divFloor(b.add(squareRoot), denominator);
        } else {
            return DecimalMath.divFloor(squareRoot.sub(b), denominator);
        }
    }

    /*
        Start from the integration function
        i*deltaB = (Q2-Q1)*(1-k+kQ0^2/Q1/Q2)
        Assume Q2=Q0, Given Q1 and deltaB, solve Q0
        let fairAmount = i*deltaB
    */
    function _SolveQuadraticFunctionForTarget(
        uint256 V1,
        uint256 k,
        uint256 fairAmount
    ) internal pure returns (uint256 V0) {
        // V0 = V1+V1*(sqrt-1)/2k
        uint256 sqrt = DecimalMath.divFloor(DecimalMath.mul(k, fairAmount), V1).mul(4);
        sqrt = sqrt.add(DecimalMath.ONE).mul(DecimalMath.ONE).sqrt();
        uint256 premium = DecimalMath.divFloor(sqrt.sub(DecimalMath.ONE), k.mul(2));
        // V0 is greater than or equal to V1 according to the solution
        return DecimalMath.mul(V1, DecimalMath.ONE.add(premium));
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/Types.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

library Types {
    enum RStatus {ONE, ABOVE_ONE, BELOW_ONE}
    enum EnterStatus {ENTERED, NOT_ENTERED}
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/intf/IDODOLpToken.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;


interface IDODOLpToken {
    function mint(address user, uint256 value) external;

    function burn(address user, uint256 value) external;

    function balanceOf(address owner) external view returns (uint256);

    function totalSupply() external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/Ownable.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

/**
 * @title Ownable
 * @author DODO Breeder
 *
 * @notice Ownership related functions
 */
contract Ownable {
    address public _OWNER_;

    // ============ Events ============

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // ============ Modifiers ============

    modifier onlyOwner() {
        require(msg.sender == _OWNER_, "NOT_OWNER");
        _;
    }

    // ============ Functions ============

    constructor() internal {
        _OWNER_ = msg.sender;
        emit OwnershipTransferred(address(0), _OWNER_);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "INVALID_OWNER");
        emit OwnershipTransferred(_OWNER_, newOwner);
        _OWNER_ = newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/ReentrancyGuard.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

/**
 * @title ReentrancyGuard
 * @author DODO Breeder
 *
 * @notice Protect functions from Reentrancy Attack
 */
contract ReentrancyGuard {
    Types.EnterStatus private _ENTER_STATUS_;

    constructor() internal {
        _ENTER_STATUS_ = Types.EnterStatus.NOT_ENTERED;
    }

    modifier preventReentrant() {
        require(_ENTER_STATUS_ != Types.EnterStatus.ENTERED, "ReentrancyGuard: reentrant call");
        _ENTER_STATUS_ = Types.EnterStatus.ENTERED;
        _;
        _ENTER_STATUS_ = Types.EnterStatus.NOT_ENTERED;
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/intf/IOracle.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;


interface IOracle {
    function getPrice() external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/impl/Storage.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;







/**
 * @title Storage
 * @author DODO Breeder
 *
 * @notice Local Variables
 */
contract Storage is Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    // ============ Variables for Control ============

    bool internal _INITIALIZED_;
    bool public _CLOSED_;
    bool public _DEPOSIT_QUOTE_ALLOWED_;
    bool public _DEPOSIT_BASE_ALLOWED_;
    bool public _TRADE_ALLOWED_;
    uint256 public _GAS_PRICE_LIMIT_;

    // ============ Core Address ============

    address public _SUPERVISOR_; // could freeze system in emergency
    address public _MAINTAINER_; // collect maintainer fee to buy food for DODO

    address public _BASE_TOKEN_;
    address public _QUOTE_TOKEN_;
    address public _ORACLE_;

    // ============ Variables for PMM Algorithm ============

    uint256 public _LP_FEE_RATE_;
    uint256 public _MT_FEE_RATE_;
    uint256 public _K_;

    Types.RStatus public _R_STATUS_;
    uint256 public _TARGET_BASE_TOKEN_AMOUNT_;
    uint256 public _TARGET_QUOTE_TOKEN_AMOUNT_;
    uint256 public _BASE_BALANCE_;
    uint256 public _QUOTE_BALANCE_;

    address public _BASE_CAPITAL_TOKEN_;
    address public _QUOTE_CAPITAL_TOKEN_;

    // ============ Variables for Final Settlement ============

    uint256 public _BASE_CAPITAL_RECEIVE_QUOTE_;
    uint256 public _QUOTE_CAPITAL_RECEIVE_BASE_;
    mapping(address => bool) public _CLAIMED_;

    // ============ Modifiers ============

    modifier onlySupervisorOrOwner() {
        require(msg.sender == _SUPERVISOR_ || msg.sender == _OWNER_, "NOT_SUPERVISOR_OR_OWNER");
        _;
    }

    modifier notClosed() {
        require(!_CLOSED_, "DODO_IS_CLOSED");
        _;
    }

    // ============ Helper Functions ============

    function _checkDODOParameters() internal view returns (uint256) {
        require(_K_ < DecimalMath.ONE, "K_MUST_BE_LESS_THAN_ONE");
        require(_K_ > 0, "K_MUST_BE_GREATER_THAN_ZERO");
        require(_LP_FEE_RATE_.add(_MT_FEE_RATE_) < DecimalMath.ONE, "FEE_MUST_BE_LESS_THAN_ONE");
    }

    function getOraclePrice() public view returns (uint256) {
        return IOracle(_ORACLE_).getPrice();
    }

    function getBaseCapitalBalanceOf(address lp) public view returns (uint256) {
        return IDODOLpToken(_BASE_CAPITAL_TOKEN_).balanceOf(lp);
    }

    function getTotalBaseCapital() public view returns (uint256) {
        return IDODOLpToken(_BASE_CAPITAL_TOKEN_).totalSupply();
    }

    function getQuoteCapitalBalanceOf(address lp) public view returns (uint256) {
        return IDODOLpToken(_QUOTE_CAPITAL_TOKEN_).balanceOf(lp);
    }

    function getTotalQuoteCapital() public view returns (uint256) {
        return IDODOLpToken(_QUOTE_CAPITAL_TOKEN_).totalSupply();
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/intf/IERC20.sol

// This is a file copied from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol
// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;


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
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

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

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/lib/SafeERC20.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0
    This is a simplified version of OpenZepplin's SafeERC20 library

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) {
            // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/impl/Settlement.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;






/**
 * @title Settlement
 * @author DODO Breeder
 *
 * @notice Functions for assets settlement
 */
contract Settlement is Storage {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // ============ Events ============

    event DonateBaseToken(uint256 amount);

    event DonateQuoteToken(uint256 amount);

    event Claim(address indexed user, uint256 baseTokenAmount, uint256 quoteTokenAmount);

    // ============ Assets IN/OUT Functions ============

    function _baseTokenTransferIn(address from, uint256 amount) internal {
        IERC20(_BASE_TOKEN_).safeTransferFrom(from, address(this), amount);
        _BASE_BALANCE_ = _BASE_BALANCE_.add(amount);
    }

    function _quoteTokenTransferIn(address from, uint256 amount) internal {
        IERC20(_QUOTE_TOKEN_).safeTransferFrom(from, address(this), amount);
        _QUOTE_BALANCE_ = _QUOTE_BALANCE_.add(amount);
    }

    function _baseTokenTransferOut(address to, uint256 amount) internal {
        IERC20(_BASE_TOKEN_).safeTransfer(to, amount);
        _BASE_BALANCE_ = _BASE_BALANCE_.sub(amount);
    }

    function _quoteTokenTransferOut(address to, uint256 amount) internal {
        IERC20(_QUOTE_TOKEN_).safeTransfer(to, amount);
        _QUOTE_BALANCE_ = _QUOTE_BALANCE_.sub(amount);
    }

    // ============ Donate to Liquidity Pool Functions ============

    function _donateBaseToken(uint256 amount) internal {
        _TARGET_BASE_TOKEN_AMOUNT_ = _TARGET_BASE_TOKEN_AMOUNT_.add(amount);
        emit DonateBaseToken(amount);
    }

    function _donateQuoteToken(uint256 amount) internal {
        _TARGET_QUOTE_TOKEN_AMOUNT_ = _TARGET_QUOTE_TOKEN_AMOUNT_.add(amount);
        emit DonateQuoteToken(amount);
    }

    function donateBaseToken(uint256 amount) external {
        _baseTokenTransferIn(msg.sender, amount);
        _donateBaseToken(amount);
    }

    function donateQuoteToken(uint256 amount) external {
        _quoteTokenTransferIn(msg.sender, amount);
        _donateQuoteToken(amount);
    }

    // ============ Final Settlement Functions ============

    // last step to shut down dodo
    function finalSettlement() external onlyOwner notClosed {
        _CLOSED_ = true;
        _DEPOSIT_QUOTE_ALLOWED_ = false;
        _DEPOSIT_BASE_ALLOWED_ = false;
        _TRADE_ALLOWED_ = false;
        uint256 totalBaseCapital = getTotalBaseCapital();
        uint256 totalQuoteCapital = getTotalQuoteCapital();

        if (_QUOTE_BALANCE_ > _TARGET_QUOTE_TOKEN_AMOUNT_) {
            uint256 spareQuote = _QUOTE_BALANCE_.sub(_TARGET_QUOTE_TOKEN_AMOUNT_);
            _BASE_CAPITAL_RECEIVE_QUOTE_ = DecimalMath.divFloor(spareQuote, totalBaseCapital);
        } else {
            _TARGET_QUOTE_TOKEN_AMOUNT_ = _QUOTE_BALANCE_;
        }

        if (_BASE_BALANCE_ > _TARGET_BASE_TOKEN_AMOUNT_) {
            uint256 spareBase = _BASE_BALANCE_.sub(_TARGET_BASE_TOKEN_AMOUNT_);
            _QUOTE_CAPITAL_RECEIVE_BASE_ = DecimalMath.divFloor(spareBase, totalQuoteCapital);
        } else {
            _TARGET_BASE_TOKEN_AMOUNT_ = _BASE_BALANCE_;
        }

        _R_STATUS_ = Types.RStatus.ONE;
    }

    // claim remaining assets after final settlement
    function claim() external preventReentrant {
        require(_CLOSED_, "DODO_IS_NOT_CLOSED");
        require(!_CLAIMED_[msg.sender], "ALREADY_CLAIMED");
        _CLAIMED_[msg.sender] = true;
        uint256 quoteAmount = DecimalMath.mul(
            getBaseCapitalBalanceOf(msg.sender),
            _BASE_CAPITAL_RECEIVE_QUOTE_
        );
        uint256 baseAmount = DecimalMath.mul(
            getQuoteCapitalBalanceOf(msg.sender),
            _QUOTE_CAPITAL_RECEIVE_BASE_
        );
        _baseTokenTransferOut(msg.sender, baseAmount);
        _quoteTokenTransferOut(msg.sender, quoteAmount);
        emit Claim(msg.sender, baseAmount, quoteAmount);
        return;
    }

    // in case someone transfer to contract directly
    function retrieve(address token, uint256 amount) external onlyOwner {
        if (token == _BASE_TOKEN_) {
            require(
                IERC20(_BASE_TOKEN_).balanceOf(address(this)) >= _BASE_BALANCE_.add(amount),
                "DODO_BASE_BALANCE_NOT_ENOUGH"
            );
        }
        if (token == _QUOTE_TOKEN_) {
            require(
                IERC20(_QUOTE_TOKEN_).balanceOf(address(this)) >= _QUOTE_BALANCE_.add(amount),
                "DODO_QUOTE_BALANCE_NOT_ENOUGH"
            );
        }
        IERC20(token).safeTransfer(msg.sender, amount);
    }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/impl/Pricing.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;





/**
 * @title Pricing
 * @author DODO Breeder
 *
 * @notice DODO Pricing model
 */
contract Pricing is Storage {
    using SafeMath for uint256;

    // ============ R = 1 cases ============

    function _ROneSellBaseToken(uint256 amount, uint256 targetQuoteTokenAmount)
        internal
        view
        returns (uint256 receiveQuoteToken)
    {
        uint256 i = getOraclePrice();
        uint256 Q2 = DODOMath._SolveQuadraticFunctionForTrade(
            targetQuoteTokenAmount,
            targetQuoteTokenAmount,
            DecimalMath.mul(i, amount),
            false,
            _K_
        );
        // in theory Q2 <= targetQuoteTokenAmount
        // however when amount is close to 0, precision problems may cause Q2 > targetQuoteTokenAmount
        return targetQuoteTokenAmount.sub(Q2);
    }

    function _ROneBuyBaseToken(uint256 amount, uint256 targetBaseTokenAmount)
        internal
        view
        returns (uint256 payQuoteToken)
    {
        require(amount < targetBaseTokenAmount, "DODO_BASE_TOKEN_BALANCE_NOT_ENOUGH");
        uint256 B2 = targetBaseTokenAmount.sub(amount);
        payQuoteToken = _RAboveIntegrate(targetBaseTokenAmount, targetBaseTokenAmount, B2);
        return payQuoteToken;
    }

    // ============ R < 1 cases ============

    function _RBelowSellBaseToken(
        uint256 amount,
        uint256 quoteBalance,
        uint256 targetQuoteAmount
    ) internal view returns (uint256 receieQuoteToken) {
        uint256 i = getOraclePrice();
        uint256 Q2 = DODOMath._SolveQuadraticFunctionForTrade(
            targetQuoteAmount,
            quoteBalance,
            DecimalMath.mul(i, amount),
            false,
            _K_
        );
        return quoteBalance.sub(Q2);
    }

    function _RBelowBuyBaseToken(
        uint256 amount,
        uint256 quoteBalance,
        uint256 targetQuoteAmount
    ) internal view returns (uint256 payQuoteToken) {
        // Here we don't require amount less than some value
        // Because it is limited at upper function
        // See Trader.queryBuyBaseToken
        uint256 i = getOraclePrice();
        uint256 Q2 = DODOMath._SolveQuadraticFunctionForTrade(
            targetQuoteAmount,
            quoteBalance,
            DecimalMath.mul(i, amount),
            true,
            _K_
        );
        return Q2.sub(quoteBalance);
    }

    function _RBelowBackToOne()
        internal
        view
        returns (uint256 payQuoteToken, uint256 receiveBaseToken)
    {
        // important: carefully design the system to make sure spareBase always greater than or equal to 0
        uint256 spareBase = _BASE_BALANCE_.sub(_TARGET_BASE_TOKEN_AMOUNT_);
        uint256 price = getOraclePrice();
        uint256 fairAmount = DecimalMath.mul(spareBase, price);
        uint256 newTargetQuote = DODOMath._SolveQuadraticFunctionForTarget(
            _QUOTE_BALANCE_,
            _K_,
            fairAmount
        );
        return (newTargetQuote.sub(_QUOTE_BALANCE_), spareBase);
    }

    // ============ R > 1 cases ============

    function _RAboveBuyBaseToken(
        uint256 amount,
        uint256 baseBalance,
        uint256 targetBaseAmount
    ) internal view returns (uint256 payQuoteToken) {
        require(amount < baseBalance, "DODO_BASE_TOKEN_BALANCE_NOT_ENOUGH");
        uint256 B2 = baseBalance.sub(amount);
        return _RAboveIntegrate(targetBaseAmount, baseBalance, B2);
    }

    function _RAboveSellBaseToken(
        uint256 amount,
        uint256 baseBalance,
        uint256 targetBaseAmount
    ) internal view returns (uint256 receiveQuoteToken) {
        // here we don't require B1 <= targetBaseAmount
        // Because it is limited at upper function
        // See Trader.querySellBaseToken
        uint256 B1 = baseBalance.add(amount);
        return _RAboveIntegrate(targetBaseAmount, B1, baseBalance);
    }

    function _RAboveBackToOne()
        internal
        view
        returns (uint256 payBaseToken, uint256 receiveQuoteToken)
    {
        // important: carefully design the system to make sure spareBase always greater than or equal to 0
        uint256 spareQuote = _QUOTE_BALANCE_.sub(_TARGET_QUOTE_TOKEN_AMOUNT_);
        uint256 price = getOraclePrice();
        uint256 fairAmount = DecimalMath.divFloor(spareQuote, price);
        uint256 newTargetBase = DODOMath._SolveQuadraticFunctionForTarget(
            _BASE_BALANCE_,
            _K_,
            fairAmount
        );
        return (newTargetBase.sub(_BASE_BALANCE_), spareQuote);
    }

    // ============ Helper functions ============

    function _getExpectedTarget() internal view returns (uint256 baseTarget, uint256 quoteTarget) {
        uint256 Q = _QUOTE_BALANCE_;
        uint256 B = _BASE_BALANCE_;
        if (_R_STATUS_ == Types.RStatus.ONE) {
            return (_TARGET_BASE_TOKEN_AMOUNT_, _TARGET_QUOTE_TOKEN_AMOUNT_);
        } else if (_R_STATUS_ == Types.RStatus.BELOW_ONE) {
            (uint256 payQuoteToken, uint256 receiveBaseToken) = _RBelowBackToOne();
            return (B.sub(receiveBaseToken), Q.add(payQuoteToken));
        } else if (_R_STATUS_ == Types.RStatus.ABOVE_ONE) {
            (uint256 payBaseToken, uint256 receiveQuoteToken) = _RAboveBackToOne();
            return (B.add(payBaseToken), Q.sub(receiveQuoteToken));
        }
    }

    function _RAboveIntegrate(
        uint256 B0,
        uint256 B1,
        uint256 B2
    ) internal view returns (uint256) {
        uint256 i = getOraclePrice();
        return DODOMath._GeneralIntegrate(B0, B1, B2, i, _K_);
    }

    // function _RBelowIntegrate(
    //     uint256 Q0,
    //     uint256 Q1,
    //     uint256 Q2
    // ) internal view returns (uint256) {
    //     uint256 i = getOraclePrice();
    //     i = DecimalMath.divFloor(DecimalMath.ONE, i); // 1/i
    //     return DODOMath._GeneralIntegrate(Q0, Q1, Q2, i, _K_);
    // }
}

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/impl/LiquidityProvider.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;








/**
 * @title LiquidityProvider
 * @author DODO Breeder
 *
 * @notice Functions for liquidity provider operations
 */
contract LiquidityProvider is Storage, Pricing, Settlement {
    using SafeMath for uint256;

    // ============ Events ============

    event DepositBaseToken(address indexed payer, address indexed receiver, uint256 amount);

    event DepositQuoteToken(address indexed payer, address indexed receiver, uint256 amount);

    event WithdrawBaseToken(address indexed payer, address indexed receiver, uint256 amount);

    event WithdrawQuoteToken(address indexed payer, address indexed receiver, uint256 amount);

    event ChargeBasePenalty(address indexed payer, uint256 amount);

    event ChargeQuotePenalty(address indexed payer, uint256 amount);

    // ============ Modifiers ============

    modifier depositQuoteAllowed() {
        require(_DEPOSIT_QUOTE_ALLOWED_, "DEPOSIT_QUOTE_TOKEN_NOT_ALLOWED");
        _;
    }

    modifier depositBaseAllowed() {
        require(_DEPOSIT_BASE_ALLOWED_, "DEPOSIT_BASE_TOKEN_NOT_ALLOWED");
        _;
    }

    // ============ Routine Functions ============

    function withdrawBase(uint256 amount) external returns (uint256) {
        return withdrawBaseTo(msg.sender, amount);
    }

    function depositBase(uint256 amount) external {
        depositBaseTo(msg.sender, amount);
    }

    function withdrawQuote(uint256 amount) external returns (uint256) {
        return withdrawQuoteTo(msg.sender, amount);
    }

    function depositQuote(uint256 amount) external {
        depositQuoteTo(msg.sender, amount);
    }

    function withdrawAllBase() external returns (uint256) {
        return withdrawAllBaseTo(msg.sender);
    }

    function withdrawAllQuote() external returns (uint256) {
        return withdrawAllQuoteTo(msg.sender);
    }

    // ============ Deposit Functions ============

    function depositQuoteTo(address to, uint256 amount)
        public
        preventReentrant
        depositQuoteAllowed
    {
        (, uint256 quoteTarget) = _getExpectedTarget();
        uint256 totalQuoteCapital = getTotalQuoteCapital();
        uint256 capital = amount;
        if (totalQuoteCapital == 0) {
            // give remaining quote token to lp as a gift
            capital = amount.add(quoteTarget);
        } else if (quoteTarget > 0) {
            capital = amount.mul(totalQuoteCapital).div(quoteTarget);
        }

        // settlement
        _quoteTokenTransferIn(msg.sender, amount);
        _mintQuoteCapital(to, capital);
        _TARGET_QUOTE_TOKEN_AMOUNT_ = _TARGET_QUOTE_TOKEN_AMOUNT_.add(amount);

        emit DepositQuoteToken(msg.sender, to, amount);
    }

    function depositBaseTo(address to, uint256 amount) public preventReentrant depositBaseAllowed {
        (uint256 baseTarget, ) = _getExpectedTarget();
        uint256 totalBaseCapital = getTotalBaseCapital();
        uint256 capital = amount;
        if (totalBaseCapital == 0) {
            // give remaining base token to lp as a gift
            capital = amount.add(baseTarget);
        } else if (baseTarget > 0) {
            capital = amount.mul(totalBaseCapital).div(baseTarget);
        }

        // settlement
        _baseTokenTransferIn(msg.sender, amount);
        _mintBaseCapital(to, capital);
        _TARGET_BASE_TOKEN_AMOUNT_ = _TARGET_BASE_TOKEN_AMOUNT_.add(amount);

        emit DepositBaseToken(msg.sender, to, amount);
    }

    // ============ Withdraw Functions ============

    function withdrawQuoteTo(address to, uint256 amount) public preventReentrant returns (uint256) {
        // calculate capital
        (, uint256 quoteTarget) = _getExpectedTarget();
        uint256 totalQuoteCapital = getTotalQuoteCapital();
        require(totalQuoteCapital > 0, "NO_QUOTE_LP");

        uint256 requireQuoteCapital = amount.mul(totalQuoteCapital).divCeil(quoteTarget);
        require(
            requireQuoteCapital <= getQuoteCapitalBalanceOf(msg.sender),
            "LP_QUOTE_CAPITAL_BALANCE_NOT_ENOUGH"
        );

        // handle penalty, penalty may exceed amount
        uint256 penalty = getWithdrawQuotePenalty(amount);
        require(penalty < amount, "COULD_NOT_AFFORD_LIQUIDITY_PENALTY");

        // settlement
        _TARGET_QUOTE_TOKEN_AMOUNT_ = _TARGET_QUOTE_TOKEN_AMOUNT_.sub(amount);
        _burnQuoteCapital(msg.sender, requireQuoteCapital);
        _quoteTokenTransferOut(to, amount.sub(penalty));
        _donateQuoteToken(penalty);

        emit WithdrawQuoteToken(msg.sender, to, amount.sub(penalty));
        emit ChargeQuotePenalty(msg.sender, penalty);

        return amount.sub(penalty);
    }

    function withdrawBaseTo(address to, uint256 amount) public preventReentrant returns (uint256) {
        // calculate capital
        (uint256 baseTarget, ) = _getExpectedTarget();
        uint256 totalBaseCapital = getTotalBaseCapital();
        require(totalBaseCapital > 0, "NO_BASE_LP");

        uint256 requireBaseCapital = amount.mul(totalBaseCapital).divCeil(baseTarget);
        require(
            requireBaseCapital <= getBaseCapitalBalanceOf(msg.sender),
            "LP_BASE_CAPITAL_BALANCE_NOT_ENOUGH"
        );

        // handle penalty, penalty may exceed amount
        uint256 penalty = getWithdrawBasePenalty(amount);
        require(penalty <= amount, "COULD_NOT_AFFORD_LIQUIDITY_PENALTY");

        // settlement
        _TARGET_BASE_TOKEN_AMOUNT_ = _TARGET_BASE_TOKEN_AMOUNT_.sub(amount);
        _burnBaseCapital(msg.sender, requireBaseCapital);
        _baseTokenTransferOut(to, amount.sub(penalty));
        _donateBaseToken(penalty);

        emit WithdrawBaseToken(msg.sender, to, amount.sub(penalty));
        emit ChargeBasePenalty(msg.sender, penalty);

        return amount.sub(penalty);
    }

    // ============ Withdraw all Functions ============

    function withdrawAllQuoteTo(address to) public preventReentrant returns (uint256) {
        uint256 withdrawAmount = getLpQuoteBalance(msg.sender);

        // handle penalty, penalty may exceed amount
        uint256 penalty = getWithdrawQuotePenalty(withdrawAmount);
        require(penalty <= withdrawAmount, "COULD_NOT_AFFORD_LIQUIDITY_PENALTY");

        // settlement
        _TARGET_QUOTE_TOKEN_AMOUNT_ = _TARGET_QUOTE_TOKEN_AMOUNT_.sub(withdrawAmount);
        _burnQuoteCapital(msg.sender, getQuoteCapitalBalanceOf(msg.sender));
        _quoteTokenTransferOut(to, withdrawAmount.sub(penalty));
        _donateQuoteToken(penalty);

        emit WithdrawQuoteToken(msg.sender, to, withdrawAmount);
        emit ChargeQuotePenalty(msg.sender, penalty);

        return withdrawAmount.sub(penalty);
    }

    function withdrawAllBaseTo(address to) public preventReentrant returns (uint256) {
        uint256 withdrawAmount = getLpBaseBalance(msg.sender);

        // handle penalty, penalty may exceed amount
        uint256 penalty = getWithdrawBasePenalty(withdrawAmount);
        require(penalty <= withdrawAmount, "COULD_NOT_AFFORD_LIQUIDITY_PENALTY");

        // settlement
        _TARGET_BASE_TOKEN_AMOUNT_ = _TARGET_BASE_TOKEN_AMOUNT_.sub(withdrawAmount);
        _burnBaseCapital(msg.sender, getBaseCapitalBalanceOf(msg.sender));
        _baseTokenTransferOut(to, withdrawAmount.sub(penalty));
        _donateBaseToken(penalty);

        emit WithdrawBaseToken(msg.sender, to, withdrawAmount);
        emit ChargeBasePenalty(msg.sender, penalty);

        return withdrawAmount.sub(penalty);
    }

    // ============ Helper Functions ============

    function _mintBaseCapital(address user, uint256 amount) internal {
        IDODOLpToken(_BASE_CAPITAL_TOKEN_).mint(user, amount);
    }

    function _mintQuoteCapital(address user, uint256 amount) internal {
        IDODOLpToken(_QUOTE_CAPITAL_TOKEN_).mint(user, amount);
    }

    function _burnBaseCapital(address user, uint256 amount) internal {
        IDODOLpToken(_BASE_CAPITAL_TOKEN_).burn(user, amount);
    }

    function _burnQuoteCapital(address user, uint256 amount) internal {
        IDODOLpToken(_QUOTE_CAPITAL_TOKEN_).burn(user, amount);
    }

    // ============ Getter Functions ============

    function getLpBaseBalance(address lp) public view returns (uint256 lpBalance) {
        uint256 totalBaseCapital = getTotalBaseCapital();
        (uint256 baseTarget, ) = _getExpectedTarget();
        if (totalBaseCapital == 0) {
            return 0;
        }
        lpBalance = getBaseCapitalBalanceOf(lp).mul(baseTarget).div(totalBaseCapital);
        return lpBalance;
    }

    function getLpQuoteBalance(address lp) public view returns (uint256 lpBalance) {
        uint256 totalQuoteCapital = getTotalQuoteCapital();
        (, uint256 quoteTarget) = _getExpectedTarget();
        if (totalQuoteCapital == 0) {
            return 0;
        }
        lpBalance = getQuoteCapitalBalanceOf(lp).mul(quoteTarget).div(totalQuoteCapital);
        return lpBalance;
    }

    function getWithdrawQuotePenalty(uint256 amount) public view returns (uint256 penalty) {
        require(amount <= _QUOTE_BALANCE_, "DODO_QUOTE_TOKEN_BALANCE_NOT_ENOUGH");
        if (_R_STATUS_ == Types.RStatus.BELOW_ONE) {
            uint256 spareBase = _BASE_BALANCE_.sub(_TARGET_BASE_TOKEN_AMOUNT_);
            uint256 price = getOraclePrice();
            uint256 fairAmount = DecimalMath.mul(spareBase, price);
            uint256 targetQuote = DODOMath._SolveQuadraticFunctionForTarget(
                _QUOTE_BALANCE_,
                _K_,
                fairAmount
            );
            // if amount = _QUOTE_BALANCE_, div error
            uint256 targetQuoteWithWithdraw = DODOMath._SolveQuadraticFunctionForTarget(
                _QUOTE_BALANCE_.sub(amount),
                _K_,
                fairAmount
            );
            return targetQuote.sub(targetQuoteWithWithdraw.add(amount));
        } else {
            return 0;
        }
    }

    function getWithdrawBasePenalty(uint256 amount) public view returns (uint256 penalty) {
        require(amount <= _BASE_BALANCE_, "DODO_BASE_TOKEN_BALANCE_NOT_ENOUGH");
        if (_R_STATUS_ == Types.RStatus.ABOVE_ONE) {
            uint256 spareQuote = _QUOTE_BALANCE_.sub(_TARGET_QUOTE_TOKEN_AMOUNT_);
            uint256 price = getOraclePrice();
            uint256 fairAmount = DecimalMath.divFloor(spareQuote, price);
            uint256 targetBase = DODOMath._SolveQuadraticFunctionForTarget(
                _BASE_BALANCE_,
                _K_,
                fairAmount
            );
            // if amount = _BASE_BALANCE_, div error
            uint256 targetBaseWithWithdraw = DODOMath._SolveQuadraticFunctionForTarget(
                _BASE_BALANCE_.sub(amount),
                _K_,
                fairAmount
            );
            return targetBase.sub(targetBaseWithWithdraw.add(amount));
        } else {
            return 0;
        }
    }
}
