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

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Misc_AMOs/finnexus/IFNX_MinePool.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

// Original at https://etherscan.io/address/0x4e6005396F80a737cE80d50B2162C0a7296c9620
// Some functions were omitted for brevity. See the contract for details

interface IFNX_MinePool {
    /**
     * @dev getting function. Retrieve FPT-A coin's address
     */
    function getFPTAAddress() external view returns (address);
    /**
     * @dev getting function. Retrieve FPT-B coin's address
     */
    function getFPTBAddress() external view returns (address);
    /**
     * @dev getting function. Retrieve mine pool's start time.
     */
    function getStartTime() external view returns (uint256);
    /**
     * @dev getting current mine period ID.
     */
    function getCurrentPeriodID() external view returns (uint256);
    /**
     * @dev getting user's staking FPT-A balance.
     * account user's account
     */
    function getUserFPTABalance(address /*account*/) external view returns (uint256);
    /**
     * @dev getting user's staking FPT-B balance.
     * account user's account
     */
    function getUserFPTBBalance(address /*account*/) external view returns (uint256);
    /**
     * @dev getting user's maximium locked period ID.
     * account user's account
     */
    function getUserMaxPeriodId(address /*account*/) external view returns (uint256);
    /**
     * @dev getting user's locked expired time. After this time user can unstake FPTB coins.
     * account user's account
     */
    function getUserExpired(address /*account*/) external view returns (uint256);
    function getCurrentTotalAPY(address /*mineCoin*/) external view returns (uint256);
    /**
     * @dev Calculate user's current APY.
     * account user's account.
     * mineCoin mine coin address
     */
    function getUserCurrentAPY(address /*account*/,address /*mineCoin*/) external view returns (uint256);
    function getAverageLockedTime() external view returns (uint256);
    /**
     * @dev foundation redeem out mine coins.
     *  mineCoin mineCoin address
     *  amount redeem amount.
     */
    function redeemOut(address /*mineCoin*/,uint256 /*amount*/) external;
    /**
     * @dev retrieve total distributed mine coins.
     *  mineCoin mineCoin address
     */
    function getTotalMined(address /*mineCoin*/) external view returns(uint256);
    /**
     * @dev retrieve minecoin distributed informations.
     *  mineCoin mineCoin address
     * @return distributed amount and distributed time interval.
     */
    function getMineInfo(address /*mineCoin*/) external view returns(uint256,uint256);
    /**
     * @dev retrieve user's mine balance.
     *  account user's account
     *  mineCoin mineCoin address
     */
    function getMinerBalance(address /*account*/,address /*mineCoin*/) external view returns(uint256);
    /**
     * @dev Set mineCoin mine info, only foundation owner can invoked.
     *  mineCoin mineCoin address
     *  _mineAmount mineCoin distributed amount
     *  _mineInterval mineCoin distributied time interval
     */
    function setMineCoinInfo(address /*mineCoin*/,uint256 /*_mineAmount*/,uint256 /*_mineInterval*/) external ;

    /**
     * @dev user redeem mine rewards.
     *  mineCoin mine coin address
     *  amount redeem amount.
     */
    function redeemMinerCoin(address /*mineCoin*/,uint256 /*amount*/) external;
    /**
     * @dev getting whole pool's mine production weight ratio.
     *      Real mine production equals base mine production multiply weight ratio.
     */
    function getMineWeightRatio() external view returns (uint256);
    /**
     * @dev getting whole pool's mine shared distribution. All these distributions will share base mine production.
     */
    function getTotalDistribution() external view returns (uint256);
    /**
     * @dev convert timestamp to period ID.
     * _time timestamp. 
     */ 
    function getPeriodIndex(uint256 /*_time*/) external view returns (uint256);
    /**
     * @dev convert period ID to period's finish timestamp.
     * periodID period ID. 
     */
    function getPeriodFinishTime(uint256 /*periodID*/) external view returns (uint256);
    /**
     * @dev Stake FPT-A coin and get distribution for mining.
     * amount FPT-A amount that transfer into mine pool.
     */
    function stakeFPTA(uint256 /*amount*/) external ;
    /**
     * @dev Air drop to user some FPT-B coin and lock one period and get distribution for mining.
     * user air drop's recieptor.
     * ftp_b_amount FPT-B amount that transfer into mine pool.
     */
    function lockAirDrop(address /*user*/,uint256 /*ftp_b_amount*/) external;
    /**
     * @dev Stake FPT-B coin and lock locedPreiod and get distribution for mining.
     * amount FPT-B amount that transfer into mine pool.
     * lockedPeriod locked preiod number.
     */
    function stakeFPTB(uint256 /*amount*/,uint256 /*lockedPeriod*/) external;
    /**
     * @dev withdraw FPT-A coin.
     * amount FPT-A amount that withdraw from mine pool.
     */
    function unstakeFPTA(uint256 /*amount*/) external ;
    /**
     * @dev withdraw FPT-B coin.
     * amount FPT-B amount that withdraw from mine pool.
     */
    function unstakeFPTB(uint256 /*amount*/) external;
    /**
     * @dev Add FPT-B locked period.
     * lockedPeriod FPT-B locked preiod number.
     */
    function changeFPTBLockedPeriod(uint256 /*lockedPeriod*/) external;

       /**
     * @dev retrieve total distributed premium coins.
     */
    function getTotalPremium() external view returns(uint256);
    /**
     * @dev user redeem his options premium rewards.
     */
    function redeemPremium() external;
    /**
     * @dev user redeem his options premium rewards.
     * amount redeem amount.
     */
    function redeemPremiumCoin(address /*premiumCoin*/,uint256 /*amount*/) external;
    /**
     * @dev get user's premium balance.
     * account user's account
     */ 
    function getUserLatestPremium(address /*account*/,address /*premiumCoin*/) external view returns(uint256);
 
    /**
     * @dev Distribute premium from foundation.
     * periodID period ID
     * amount premium amount.
     */ 
    function distributePremium(address /*premiumCoin*/,uint256 /*periodID*/,uint256 /*amount*/) external ;
}

// /**
//  *Submitted for verification at Etherscan.io on 2021-01-26
// */

// // File: contracts\Proxy\newBaseProxy.sol

// pragma solidity =0.5.16;
// /**
//  * @title  newBaseProxy Contract

//  */
// contract newBaseProxy {
//     bytes32 private constant implementPositon = keccak256("org.Finnexus.implementation.storage");
//     bytes32 private constant proxyOwnerPosition  = keccak256("org.Finnexus.Owner.storage");
//     constructor(address implementation_) public {
//         // Creator of the contract is admin during initialization
//         _setProxyOwner(msg.sender);
//         _setImplementation(implementation_);
//         (bool success,) = implementation_.delegatecall(abi.encodeWithSignature("initialize()"));
//         require(success);
//     }
//     /**
//      * @dev Allows the current owner to transfer ownership
//      * @param _newOwner The address to transfer ownership to
//      */
//     function transferProxyOwnership(address _newOwner) public onlyProxyOwner 
//     {
//         require(_newOwner != address(0));
//         _setProxyOwner(_newOwner);
//     }
//     function _setProxyOwner(address _newOwner) internal 
//     {
//         bytes32 position = proxyOwnerPosition;
//         assembly {
//             sstore(position, _newOwner)
//         }
//     }
//     function proxyOwner() public view returns (address owner) {
//         bytes32 position = proxyOwnerPosition;
//         assembly {
//             owner := sload(position)
//         }
//     }
//     /**
//      * @dev Tells the address of the current implementation
//      * @return address of the current implementation
//      */
//     function getImplementation() public view returns (address impl) {
//         bytes32 position = implementPositon;
//         assembly {
//             impl := sload(position)
//         }
//     }
//     function _setImplementation(address _newImplementation) internal 
//     {
//         bytes32 position = implementPositon;
//         assembly {
//             sstore(position, _newImplementation)
//         }
//     }
//     function setImplementation(address _newImplementation)public onlyProxyOwner{
//         address currentImplementation = getImplementation();
//         require(currentImplementation != _newImplementation);
//         _setImplementation(_newImplementation);
//         (bool success,) = _newImplementation.delegatecall(abi.encodeWithSignature("update()"));
//         require(success);
//     }

//     /**
//      * @notice Delegates execution to the implementation contract
//      * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//      * @param data The raw data to delegatecall
//      * @return The returned bytes from the delegatecall
//      */
//     function delegateToImplementation(bytes memory data) public returns (bytes memory) {
//         (bool success, bytes memory returnData) = getImplementation().delegatecall(data);
//         assembly {
//             if eq(success, 0) {
//                 revert(add(returnData, 0x20), returndatasize)
//             }
//         }
//         return returnData;
//     }

//     /**
//      * @notice Delegates execution to an implementation contract
//      * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//      *  There are an additional 2 prefix uints from the wrapper returndata, which we ignore since we make an extra hop.
//      * @param data The raw data to delegatecall
//      * @return The returned bytes from the delegatecall
//      */
//     function delegateToViewImplementation(bytes memory data) public view returns (bytes memory) {
//         (bool success, bytes memory returnData) = address(this).staticcall(abi.encodeWithSignature("delegateToImplementation(bytes)", data));
//         assembly {
//             if eq(success, 0) {
//                 revert(add(returnData, 0x20), returndatasize)
//             }
//         }
//         return abi.decode(returnData, (bytes));
//     }

//     function delegateToViewAndReturn() internal view returns (bytes memory) {
//         (bool success, ) = address(this).staticcall(abi.encodeWithSignature("delegateToImplementation(bytes)", msg.data));

//         assembly {
//             let free_mem_ptr := mload(0x40)
//             returndatacopy(free_mem_ptr, 0, returndatasize)

//             switch success
//             case 0 { revert(free_mem_ptr, returndatasize) }
//             default { return(add(free_mem_ptr, 0x40), sub(returndatasize, 0x40)) }
//         }
//     }

//     function delegateAndReturn() internal returns (bytes memory) {
//         (bool success, ) = getImplementation().delegatecall(msg.data);

//         assembly {
//             let free_mem_ptr := mload(0x40)
//             returndatacopy(free_mem_ptr, 0, returndatasize)

//             switch success
//             case 0 { revert(free_mem_ptr, returndatasize) }
//             default { return(free_mem_ptr, returndatasize) }
//         }
//     }
//         /**
//     * @dev Throws if called by any account other than the owner.
//     */
//     modifier onlyProxyOwner() {
//         require (msg.sender == proxyOwner());
//         _;
//     }
// }

// // File: contracts\fixedMinePool\fixedMinePoolProxy.sol

// pragma solidity =0.5.16;


// /**
//  * @title FNX period mine pool.
//  * @dev A smart-contract which distribute some mine coins when user stake FPT-A and FPT-B coins.
//  *
//  */
// contract fixedMinePoolProxy is newBaseProxy {
//     /**
//     * @dev constructor.
//     * FPTA FPT-A coin's address,staking coin
//     * FPTB FPT-B coin's address,staking coin
//     * startTime the start time when this mine pool begin.
//     */
//     constructor (address implementation_,address FPTA,address FPTB,uint256 startTime) newBaseProxy(implementation_) public{
//         (bool success,) = implementation_.delegatecall(abi.encodeWithSignature(
//                 "setAddresses(address,address,uint256)",
//                 FPTA,
//                 FPTB,
//                 startTime));
//         require(success);
//     }
//         /**
//      * @dev default function for foundation input miner coins.
//      */
//     function()external payable{

//     }
//         /**
//      * @dev Returns the address of the current owner.
//      */
//     function owner() public view returns (address) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev Returns true if the caller is the current owner.
//      */
//     function isOwner() public view returns (bool) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev Leaves the contract without owner. It will not be possible to call
//      * `onlyOwner` functions anymore. Can only be called by the current owner.
//      *
//      * NOTE: Renouncing ownership will leave the contract without an owner,
//      * thereby removing any functionality that is only available to the owner.
//      */
//     function renounceOwnership() public {
//         delegateAndReturn();
//     }
//     /**
//      * @dev Transfers ownership of the contract to a new account (`newOwner`).
//      * Can only be called by the current owner.
//      */
//     function transferOwnership(address /*newOwner*/) public {
//         delegateAndReturn();
//     }
//     function setHalt(bool /*halt*/) public  {
//         delegateAndReturn();
//     }
//      function addWhiteList(address /*addAddress*/)public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev Implementation of revoke an invalid address from the whitelist.
//      *  removeAddress revoked address.
//      */
//     function removeWhiteList(address /*removeAddress*/)public returns (bool){
//         delegateAndReturn();
//     }
//     /**
//      * @dev Implementation of getting the eligible whitelist.
//      */
//     function getWhiteList()public view returns (address[] memory){
//         delegateToViewAndReturn();
//     }
//     /**
//      * @dev Implementation of testing whether the input address is eligible.
//      *  tmpAddress input address for testing.
//      */    
//     function isEligibleAddress(address /*tmpAddress*/) public view returns (bool){
//         delegateToViewAndReturn();
//     }
//     function setOperator(uint256 /*index*/,address /*addAddress*/)public{
//         delegateAndReturn();
//     }
//     function getOperator(uint256 /*index*/)public view returns (address) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting function. Retrieve FPT-A coin's address
//      */
//     function getFPTAAddress()public view returns (address) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting function. Retrieve FPT-B coin's address
//      */
//     function getFPTBAddress()public view returns (address) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting function. Retrieve mine pool's start time.
//      */
//     function getStartTime()public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting current mine period ID.
//      */
//     function getCurrentPeriodID()public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting user's staking FPT-A balance.
//      * account user's account
//      */
//     function getUserFPTABalance(address /*account*/)public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting user's staking FPT-B balance.
//      * account user's account
//      */
//     function getUserFPTBBalance(address /*account*/)public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting user's maximium locked period ID.
//      * account user's account
//      */
//     function getUserMaxPeriodId(address /*account*/)public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting user's locked expired time. After this time user can unstake FPTB coins.
//      * account user's account
//      */
//     function getUserExpired(address /*account*/)public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     function getCurrentTotalAPY(address /*mineCoin*/)public view returns (uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev Calculate user's current APY.
//      * account user's account.
//      * mineCoin mine coin address
//      */
//     function getUserCurrentAPY(address /*account*/,address /*mineCoin*/)public view returns (uint256){
//         delegateToViewAndReturn(); 
//     }
//     function getAverageLockedTime()public view returns (uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev foundation redeem out mine coins.
//      *  mineCoin mineCoin address
//      *  amount redeem amount.
//      */
//     function redeemOut(address /*mineCoin*/,uint256 /*amount*/)public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev retrieve total distributed mine coins.
//      *  mineCoin mineCoin address
//      */
//     function getTotalMined(address /*mineCoin*/)public view returns(uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev retrieve minecoin distributed informations.
//      *  mineCoin mineCoin address
//      * @return distributed amount and distributed time interval.
//      */
//     function getMineInfo(address /*mineCoin*/)public view returns(uint256,uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev retrieve user's mine balance.
//      *  account user's account
//      *  mineCoin mineCoin address
//      */
//     function getMinerBalance(address /*account*/,address /*mineCoin*/)public view returns(uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev Set mineCoin mine info, only foundation owner can invoked.
//      *  mineCoin mineCoin address
//      *  _mineAmount mineCoin distributed amount
//      *  _mineInterval mineCoin distributied time interval
//      */
//     function setMineCoinInfo(address /*mineCoin*/,uint256 /*_mineAmount*/,uint256 /*_mineInterval*/)public {
//         delegateAndReturn();
//     }

//     /**
//      * @dev user redeem mine rewards.
//      *  mineCoin mine coin address
//      *  amount redeem amount.
//      */
//     function redeemMinerCoin(address /*mineCoin*/,uint256 /*amount*/)public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev getting whole pool's mine production weight ratio.
//      *      Real mine production equals base mine production multiply weight ratio.
//      */
//     function getMineWeightRatio()public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev getting whole pool's mine shared distribution. All these distributions will share base mine production.
//      */
//     function getTotalDistribution() public view returns (uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev convert timestamp to period ID.
//      * _time timestamp. 
//      */ 
//     function getPeriodIndex(uint256 /*_time*/) public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev convert period ID to period's finish timestamp.
//      * periodID period ID. 
//      */
//     function getPeriodFinishTime(uint256 /*periodID*/)public view returns (uint256) {
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev Stake FPT-A coin and get distribution for mining.
//      * amount FPT-A amount that transfer into mine pool.
//      */
//     function stakeFPTA(uint256 /*amount*/)public {
//         delegateAndReturn();
//     }
//     /**
//      * @dev Air drop to user some FPT-B coin and lock one period and get distribution for mining.
//      * user air drop's recieptor.
//      * ftp_b_amount FPT-B amount that transfer into mine pool.
//      */
//     function lockAirDrop(address /*user*/,uint256 /*ftp_b_amount*/) external{
//         delegateAndReturn();
//     }
//     /**
//      * @dev Stake FPT-B coin and lock locedPreiod and get distribution for mining.
//      * amount FPT-B amount that transfer into mine pool.
//      * lockedPeriod locked preiod number.
//      */
//     function stakeFPTB(uint256 /*amount*/,uint256 /*lockedPeriod*/)public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev withdraw FPT-A coin.
//      * amount FPT-A amount that withdraw from mine pool.
//      */
//     function unstakeFPTA(uint256 /*amount*/)public {
//         delegateAndReturn();
//     }
//     /**
//      * @dev withdraw FPT-B coin.
//      * amount FPT-B amount that withdraw from mine pool.
//      */
//     function unstakeFPTB(uint256 /*amount*/)public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev Add FPT-B locked period.
//      * lockedPeriod FPT-B locked preiod number.
//      */
//     function changeFPTBLockedPeriod(uint256 /*lockedPeriod*/)public{
//         delegateAndReturn();
//     }

//        /**
//      * @dev retrieve total distributed premium coins.
//      */
//     function getTotalPremium()public view returns(uint256){
//         delegateToViewAndReturn(); 
//     }
//     /**
//      * @dev user redeem his options premium rewards.
//      */
//     function redeemPremium()public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev user redeem his options premium rewards.
//      * amount redeem amount.
//      */
//     function redeemPremiumCoin(address /*premiumCoin*/,uint256 /*amount*/)public{
//         delegateAndReturn();
//     }
//     /**
//      * @dev get user's premium balance.
//      * account user's account
//      */ 
//     function getUserLatestPremium(address /*account*/,address /*premiumCoin*/)public view returns(uint256){
//         delegateToViewAndReturn(); 
//     }
 
//     /**
//      * @dev Distribute premium from foundation.
//      * periodID period ID
//      * amount premium amount.
//      */ 
//     function distributePremium(address /*premiumCoin*/,uint256 /*periodID*/,uint256 /*amount*/)public {
//         delegateAndReturn();
//     }
//         /**
//      * @dev Emitted when `account` stake `amount` FPT-A coin.
//      */
//     event StakeFPTA(address indexed account,uint256 amount);
//     /**
//      * @dev Emitted when `from` airdrop `recieptor` `amount` FPT-B coin.
//      */
//     event LockAirDrop(address indexed from,address indexed recieptor,uint256 amount);
//     /**
//      * @dev Emitted when `account` stake `amount` FPT-B coin and locked `lockedPeriod` periods.
//      */
//     event StakeFPTB(address indexed account,uint256 amount,uint256 lockedPeriod);
//     /**
//      * @dev Emitted when `account` unstake `amount` FPT-A coin.
//      */
//     event UnstakeFPTA(address indexed account,uint256 amount);
//     /**
//      * @dev Emitted when `account` unstake `amount` FPT-B coin.
//      */
//     event UnstakeFPTB(address indexed account,uint256 amount);
//     /**
//      * @dev Emitted when `account` change `lockedPeriod` locked periods for FPT-B coin.
//      */
//     event ChangeLockedPeriod(address indexed account,uint256 lockedPeriod);
//     /**
//      * @dev Emitted when owner `account` distribute `amount` premium in `periodID` period.
//      */
//     event DistributePremium(address indexed account,address indexed premiumCoin,uint256 indexed periodID,uint256 amount);
//     /**
//      * @dev Emitted when `account` redeem `amount` premium.
//      */
//     event RedeemPremium(address indexed account,address indexed premiumCoin,uint256 amount);

//     /**
//      * @dev Emitted when `account` redeem `value` mineCoins.
//      */
//     event RedeemMineCoin(address indexed account, address indexed mineCoin, uint256 value);

// }
