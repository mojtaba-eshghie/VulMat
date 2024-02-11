// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Common/Context.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }

    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Math/SafeMath.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

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
     *
     * _Available since v2.4.0._
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
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
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
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;


/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Misc_AMOs/finnexus/IFNX_IntegratedStake.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

// Original at https://etherscan.io/address/0x23e54F9bBe26eD55F93F19541bC30AAc2D5569b2
// Some functions were omitted for brevity. See the contract for details

interface IFNX_IntegratedStake {
    function stake(address[] memory fpta_tokens,uint256[] memory fpta_amounts,
            address[] memory fptb_tokens, uint256[] memory fptb_amounts,uint256 lockedPeriod) external;

}


// contract integratedStake is Ownable{
//     using SafeERC20 for IERC20;
//     address public _FPTA;
//     address public _FPTB;
//     address public _FPTAColPool;//the option manager address
//     address public _FPTBColPool;//the option manager address
//     address public _minePool;    //the fixed minePool address
//     mapping (address=>bool) approveMapA;
//     mapping (address=>bool) approveMapB;
//     uint256  constant internal MAX_UINT = (2**256 - 1); 
//     /**
//      * @dev constructor.
//      */
//     constructor(address FPTA,address FPTB,address FPTAColPool,address FPTBColPool,address minePool)public{
//         setAddress(FPTA,FPTB,FPTAColPool,FPTBColPool,minePool);
//     }
//     function setAddress(address FPTA,address FPTB,address FPTAColPool,address FPTBColPool,address minePool) onlyOwner public{
//         _FPTA = FPTA;
//         _FPTB = FPTB;
//         _FPTAColPool = FPTAColPool;
//         _FPTBColPool = FPTBColPool;
//         _minePool = minePool;
//         if (IERC20(_FPTA).allowance(msg.sender, _minePool) == 0){
//             IERC20(_FPTA).safeApprove(_minePool,MAX_UINT);
//         }
//         if (IERC20(_FPTB).allowance(msg.sender, _minePool) == 0){
//             IERC20(_FPTB).safeApprove(_minePool,MAX_UINT);
//         }
//     }
//     function stake(address[] memory fpta_tokens,uint256[] memory fpta_amounts,
//             address[] memory fptb_tokens,uint256[] memory fptb_amounts,uint256 lockedPeriod) public{
//         require(fpta_tokens.length==fpta_amounts.length && fptb_tokens.length==fptb_amounts.length,"the input array length is not equal");
//         uint256 i = 0;
//         for(i = 0;i<fpta_tokens.length;i++) {
//             if (!approveMapA[fpta_tokens[i]]){
//                 IERC20(fpta_tokens[i]).safeApprove(_FPTAColPool,MAX_UINT);
//                 approveMapA[fpta_tokens[i]] = true;
//             }
//             uint256 amount = getPayableAmount(fpta_tokens[i],fpta_amounts[i]);
//             IOptionMgrPoxy(_FPTAColPool).addCollateral(fpta_tokens[i],amount);
//             IERC20(_FPTA).safeTransfer(msg.sender,0);
//         }
//         for(i = 0;i<fptb_tokens.length;i++) {
//             if (!approveMapB[fptb_tokens[i]]){
//                 IERC20(fptb_tokens[i]).safeApprove(_FPTBColPool,MAX_UINT);
//                 approveMapB[fptb_tokens[i]] = true;
//             }
//             uint256 amount = getPayableAmount(fptb_tokens[i],fptb_amounts[i]);
//             IOptionMgrPoxy(_FPTBColPool).addCollateral(fptb_tokens[i],amount);
//             IERC20(_FPTB).safeTransfer(msg.sender,0);
//         }
//         IMinePool(_minePool).lockAirDrop(msg.sender,lockedPeriod);
//     }
//     /**
//      * @dev Auxiliary function. getting user's payment
//      * @param settlement user's payment coin.
//      * @param settlementAmount user's payment amount.
//      */
//     function getPayableAmount(address settlement,uint256 settlementAmount) internal returns (uint256) {
//         if (settlement == address(0)){
//             settlementAmount = msg.value;
//         }else if (settlementAmount > 0){
//             IERC20 oToken = IERC20(settlement);
//             uint256 preBalance = oToken.balanceOf(address(this));
//             oToken.safeTransferFrom(msg.sender, address(this), settlementAmount);
//             //oToken.transferFrom(msg.sender, address(this), settlementAmount);
//             uint256 afterBalance = oToken.balanceOf(address(this));
//             require(afterBalance-preBalance==settlementAmount,"settlement token transfer error!");
//         }
//         return settlementAmount;
//     }
// }
