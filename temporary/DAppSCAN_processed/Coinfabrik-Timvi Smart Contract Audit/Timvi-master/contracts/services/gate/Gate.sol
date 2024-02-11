// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/SafeMath.sol

pragma solidity 0.4.25;

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
        require(c / a == b, 'mul');

        return c;
    }

    /**
    * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, 'div');
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
    * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, 'sub');
        uint256 c = a - b;

        return c;
    }

    /**
    * @dev Adds two numbers, reverts on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'add');

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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ISettings.sol

pragma solidity 0.4.25;


/// @title ISettings
/// @dev Interface for getting the data from settings contract.
interface ISettings {
    function oracleAddress() external view returns(address);
    function minDeposit() external view returns(uint256);
    function sysFee() external view returns(uint256);
    function userFee() external view returns(uint256);
    function ratio() external view returns(uint256);
    function globalTargetCollateralization() external view returns(uint256);
    function tmvAddress() external view returns(uint256);
    function maxStability() external view returns(uint256);
    function minStability() external view returns(uint256);
    function gasPriceLimit() external view returns(uint256);
    function isFeeManager(address account) external view returns (bool);
    function tBoxManager() external view returns(address);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IToken.sol

pragma solidity 0.4.25;


/// @title IToken
/// @dev Interface for interaction with the TMV token contract.
interface IToken {
    function burnLogic(address from, uint256 value) external;
    function balanceOf(address who) external view returns (uint256);
    function mint(address to, uint256 value) external returns (bool);
    function totalSupply() external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 tokenId) external;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IOracle.sol

pragma solidity 0.4.25;


/// @title IOracle
/// @dev Interface for getting the data from the oracle contract.
interface IOracle {
    function ethUsdPrice() external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ITBoxManager.sol

pragma solidity 0.4.25;


/// @title ITBoxManager
/// @dev Interface for interaction with the TMV logic contract to manage Boxes.
interface ITBoxManager {
    function create(uint256 withdraw) external payable returns (uint256);
    function precision() external view returns (uint256);
    function rate() external view returns (uint256);
    function transferFrom(address from, address to, uint256 tokenId) external;
    function close(uint256 id) external;
    function withdrawPercent(uint256 _collateral) external view returns(uint256);
    function boxes(uint256 id) external view returns(uint256, uint256);
    function withdrawEth(uint256 _id, uint256 _amount) external;
    function withdrawTmv(uint256 _id, uint256 _amount) external;
    function withdrawableEth(uint256 id) external view returns(uint256);
    function withdrawableTmv(uint256 collateral) external view returns(uint256);
    function maxCapAmount(uint256 _id) external view returns (uint256);
    function collateralPercent(uint256 _id) external view returns (uint256);
    function capitalize(uint256 _id, uint256 _tmv) external;
    function boxWithdrawableTmv(uint256 _id) external view returns(uint256);
    function addEth(uint256 _id) external payable;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/services/gate/Gate.sol

pragma solidity 0.4.25;





/// @title Gate
contract Gate {
    using SafeMath for uint256;

    /// @notice The address of the admin account.
    address public admin;

    // Fee percentage for TMV exchange
    uint256 public feePercentTMV;

    // Fee percentage for ETH exchange
    uint256 public feePercentETH;

    // Minimum amount to create order in TMV (18 decimals)
    uint256 public minOrder;

    // The address to transfer tokens
    address public timviWallet;

    ISettings public settings;

    /// @dev An array containing the Order struct for all Orders in existence. The ID
    ///  of each Order is actually an index into this array.
    Order[] public orders;

    /// @dev The Order struct. Every Order is represented by a copy
    ///  of this structure.
    struct Order {
        address owner;
        uint256 amount;
    }

    /// @dev The OrderCreated event is fired whenever a new Order comes into existence.
    event OrderCreated(uint256 id, address owner, uint256 tmv);

    /// @dev The OrderCancelled event is fired whenever an Order is cancelled.
    event OrderCancelled(uint256 id, address owner, uint256 tmv);

    /// @dev The OrderFilled event is fired whenever an Order is filled.
    event OrderFilled(uint256 id, address owner, uint256 tmvTotal, uint256 tmvExecution, uint256 ethTotal, uint256 ethExecution);

    /// @dev The OrderFilledPool event is fired whenever an Order is filled.
    event OrderFilledPool(uint256 id, address owner, uint256 tmv, uint256 eth);

    /// @dev The Converted event is fired whenever an exchange is processed immediately.
    event Converted(address owner, uint256 tmv, uint256 eth);

    /// @dev The Funded event is fired whenever the contract is funded.
    event Funded(uint256 eth);

    /// @dev The AdminChanged event is fired whenever the admin is changed.
    event AdminChanged(address admin);

    event GateTmvFeeUpdated(uint256 value);
    event GateEthFeeUpdated(uint256 value);
    event GateMinOrderUpdated(uint256 value);
    event TimviWalletChanged(address wallet);
    event GateFundsWithdrawn(uint256 value);

    /// @dev Access modifier for admin-only functionality.
    modifier onlyAdmin() {
        require(admin == msg.sender, "You have no access");
        _;
    }

    /// @dev Defends against front-running attacks.
    modifier validTx() {
        require(tx.gasprice <= settings.gasPriceLimit(), "Gas price is greater than allowed");
        _;
    }

    /// @notice ISettings address can't be changed later.
    /// @dev The contract constructor sets the original `admin` of the contract to the sender
    //   account and sets the settings contract with provided address.
    /// @param _settings The address of the settings contract.
    constructor(ISettings _settings) public {
        admin = msg.sender;
        timviWallet = msg.sender;
        settings = ISettings(_settings);

        feePercentTMV = 500; // 0.5%
        feePercentETH = 500; // 0.5%
        minOrder = 10 ** 18; // 1 TMV by default

        emit GateTmvFeeUpdated(feePercentTMV);
        emit GateEthFeeUpdated(feePercentETH);
        emit GateMinOrderUpdated(minOrder);
        emit TimviWalletChanged(timviWallet);
        emit AdminChanged(admin);
    }

    function fundAdmin() external payable {
        emit Funded(msg.value);
    }

    /// @dev Withdraws ETH.
    function withdraw(address _beneficiary, uint256 _amount) external onlyAdmin {
        require(_beneficiary != address(0), "Zero address, be careful");
        require(address(this).balance >= _amount, "Insufficient funds");
        _beneficiary.transfer(_amount);
        emit GateFundsWithdrawn(_amount);
    }

    /// @dev Sets feePercentTMV.
    function setTmvFee(uint256 _value) external onlyAdmin {
        require(_value <= 10000, "Too much");
        feePercentTMV = _value;
        emit GateTmvFeeUpdated(_value);
    }

    /// @dev Sets feePercentETH.
    function setEthFee(uint256 _value) external onlyAdmin {
        require(_value <= 10000, "Too much");
        feePercentETH = _value;
        emit GateEthFeeUpdated(_value);
    }

    /// @dev Sets minimum order amount.
    function setMinOrder(uint256 _value) external onlyAdmin {
        // The "ether" word just multiplies given value by 10 ** 18
        require(_value <= 100 ether, "Too much");

        minOrder = _value;
        emit GateMinOrderUpdated(_value);
    }

    /// @dev Sets timvi wallet address.
    function setTimviWallet(address _wallet) external onlyAdmin {
        require(_wallet != address(0), "Zero address, be careful");

        timviWallet = _wallet;
        emit TimviWalletChanged(_wallet);
    }

    /// @dev Sets admin address.
    function changeAdmin(address _newAdmin) external onlyAdmin {
        require(_newAdmin != address(0), "Zero address, be careful");
        admin = _newAdmin;
        emit AdminChanged(msg.sender);
    }

    function convert(uint256 _amount) external validTx {
        require(_amount >= minOrder, "Too small amount");
        require(IToken(settings.tmvAddress()).allowance(msg.sender, address(this)) >= _amount, "Gate is not approved to transfer enough tokens");
        uint256 eth = tmv2eth(_amount);
        if (address(this).balance >= eth) {
            IToken(settings.tmvAddress()).transferFrom(msg.sender, timviWallet, _amount);
            msg.sender.transfer(eth);
            emit Converted(msg.sender, _amount, eth);
        } else {
            IToken(settings.tmvAddress()).transferFrom(msg.sender, address(this), _amount);
            uint256 id = orders.push(Order(msg.sender, _amount)).sub(1);
            emit OrderCreated(id, msg.sender, _amount);
        }
    }

    /// @dev Cancels an Order.
    function cancel(uint256 _id) external {
        require(orders[_id].owner == msg.sender, "Order isn't yours");

        uint256 tmv = orders[_id].amount;
        delete orders[_id];
        IToken(settings.tmvAddress()).transfer(msg.sender, tmv);
        emit OrderCancelled(_id, msg.sender, tmv);
    }

    /// @dev Fills Orders by ids array.
    function multiFill(uint256[] _ids) external onlyAdmin() payable {

        if (msg.value > 0) {
            emit Funded(msg.value);
        }

        for (uint256 i = 0; i < _ids.length; i++) {
            uint256 id = _ids[i];

            require(orders[id].owner != address(0), "Order doesn't exist");

            uint256 tmv = orders[id].amount;
            uint256 eth = tmv2eth(tmv);

            require(address(this).balance >= eth, "Not enough funds");

            address owner = orders[id].owner;
            if (owner.send(eth)) {
                delete orders[id];
                IToken(settings.tmvAddress()).transfer(timviWallet, tmv);
                emit OrderFilledPool(id, owner, tmv, eth);
            }
        }
    }

    /// @dev Fills an Order by id.
    function fill(uint256 _id) external payable validTx {
        require(orders[_id].owner != address(0), "Order doesn't exist");

        // Retrieve values from storage
        uint256 tmv = orders[_id].amount;
        address owner = orders[_id].owner;

        // Calculate the demand amount of Ether
        uint256 eth = tmv.mul(precision()).div(rate());

        require(msg.value >= eth, "Not enough funds");

        emit Funded(eth);

        // Calculate execution values
        uint256 tmvFee = tmv.mul(feePercentTMV).div(precision());
        uint256 ethFee = eth.mul(feePercentETH).div(precision());

        uint256 tmvExecution = tmv.sub(tmvFee);
        uint256 ethExecution = eth.sub(ethFee);

        // Remove record about an order
        delete orders[_id];

        // Transfer order' funds
        owner.transfer(ethExecution);
        IToken(settings.tmvAddress()).transfer(msg.sender, tmvExecution);
        IToken(settings.tmvAddress()).transfer(timviWallet, tmvFee);

        // Return Ether rest if exist
        msg.sender.transfer(msg.value.sub(eth));

        emit OrderFilled(_id, owner, tmv, tmvExecution, eth, ethExecution);
    }

    /// @dev Returns current oracle ETH/USD price with precision.
    function rate() public view returns(uint256) {
        return IOracle(settings.oracleAddress()).ethUsdPrice();
    }

    /// @dev Returns precision using for USD and commission calculation.
    function precision() public view returns(uint256) {
        return ITBoxManager(settings.tBoxManager()).precision();
    }

    /// @dev Calculates the ether amount to pay for a provided TMV amount.
    function tmv2eth(uint256 _amount) public view returns(uint256) {
        uint256 equivalent = _amount.mul(precision()).div(rate());
        return chargeFee(equivalent, feePercentETH);
    }

    /// @dev Reduces the amount by system fee.
    function chargeFee(uint256 _amount, uint256 _percent) public view returns(uint256) {
        uint256 fee = _amount.mul(_percent).div(precision());
        return _amount.sub(fee);
    }
}
