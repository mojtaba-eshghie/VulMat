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

// File: ../sc_datasets/DAppSCAN/PeckShield-dodo/dodo-smart-contract-d74964085d115022635dbfa07cf8396b8f450ab0/contracts/impl/Admin.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

/**
 * @title Admin
 * @author DODO Breeder
 *
 * @notice Functions for admin operations
 */
contract Admin is Storage {
    // ============ Events ============

    event UpdateGasPriceLimit(uint256 newGasPriceLimit);

    // ============ Params Setting Functions ============

    function setOracle(address newOracle) external onlyOwner {
        _ORACLE_ = newOracle;
    }

    function setSupervisor(address newSupervisor) external onlyOwner {
        _SUPERVISOR_ = newSupervisor;
    }

    function setMaintainer(address newMaintainer) external onlyOwner {
        _MAINTAINER_ = newMaintainer;
    }

    function setLiquidityProviderFeeRate(uint256 newLiquidityPorviderFeeRate) external onlyOwner {
        _LP_FEE_RATE_ = newLiquidityPorviderFeeRate;
        _checkDODOParameters();
    }

    function setMaintainerFeeRate(uint256 newMaintainerFeeRate) external onlyOwner {
        _MT_FEE_RATE_ = newMaintainerFeeRate;
        _checkDODOParameters();
    }

    function setK(uint256 newK) external onlyOwner {
        _K_ = newK;
        _checkDODOParameters();
    }

    function setGasPriceLimit(uint256 newGasPriceLimit) external onlySupervisorOrOwner {
        _GAS_PRICE_LIMIT_ = newGasPriceLimit;
        emit UpdateGasPriceLimit(newGasPriceLimit);
    }

    // ============ System Control Functions ============

    function disableTrading() external onlySupervisorOrOwner {
        _TRADE_ALLOWED_ = false;
    }

    function enableTrading() external onlyOwner notClosed {
        _TRADE_ALLOWED_ = true;
    }

    function disableQuoteDeposit() external onlySupervisorOrOwner {
        _DEPOSIT_QUOTE_ALLOWED_ = false;
    }

    function enableQuoteDeposit() external onlyOwner notClosed {
        _DEPOSIT_QUOTE_ALLOWED_ = true;
    }

    function disableBaseDeposit() external onlySupervisorOrOwner {
        _DEPOSIT_BASE_ALLOWED_ = false;
    }

    function enableBaseDeposit() external onlyOwner notClosed {
        _DEPOSIT_BASE_ALLOWED_ = true;
    }
}
