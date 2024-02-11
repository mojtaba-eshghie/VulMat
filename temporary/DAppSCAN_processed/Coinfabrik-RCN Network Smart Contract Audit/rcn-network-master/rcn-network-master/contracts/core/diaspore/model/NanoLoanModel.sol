// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/interfaces/IERC165.sol

pragma solidity ^0.5.11;


interface IERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceID The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function
    ///  uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/core/diaspore/interfaces/Model.sol

pragma solidity ^0.5.11;

/**
    The abstract contract Model defines the whole lifecycle of a debt on the DebtEngine.

    Models can be used without previous approbation, this is meant
    to avoid centralization on the development of RCN; this implies that not all models are secure.
    Models can have back-doors, bugs and they have not guarantee of being autonomous.

    The DebtEngine is meant to be the User of this model,
    so all the methods with the ability to perform state changes should only be callable by the DebtEngine.

    All models should implement the 0xaf498c35 interface.

    @author Agustin Aguilar
*/
contract Model is IERC165 {
    // ///
    // Events
    // ///

    /**
        @dev This emits when create a new debt.
    */
    event Created(bytes32 indexed _id);

    /**
        @dev This emits when the status of debt change.

        @param _timestamp Timestamp of the registry
        @param _status New status of the registry
    */
    event ChangedStatus(bytes32 indexed _id, uint256 _timestamp, uint256 _status);

    /**
        @dev This emits when the obligation of debt change.

        @param _timestamp Timestamp of the registry
        @param _debt New debt of the registry
    */
    event ChangedObligation(bytes32 indexed _id, uint256 _timestamp, uint256 _debt);

    /**
        @dev This emits when the frequency of debt change.

        @param _timestamp Timestamp of the registry
        @param _frequency New frequency of each installment
    */
    event ChangedFrequency(bytes32 indexed _id, uint256 _timestamp, uint256 _frequency);

    /**
        @param _timestamp Timestamp of the registry
    */
    event ChangedDueTime(bytes32 indexed _id, uint256 _timestamp, uint256 _status);

    /**
        @param _timestamp Timestamp of the registry
        @param _dueTime New dueTime of each installment
    */
    event ChangedFinalTime(bytes32 indexed _id, uint256 _timestamp, uint64 _dueTime);

    /**
        @dev This emits when the call addDebt function.

        @param _amount New amount of the debt, old amount plus added
    */
    event AddedDebt(bytes32 indexed _id, uint256 _amount);

    /**
        @dev This emits when the call addPaid function.

        If the registry is fully paid on the call and the amount parameter exceeds the required
            payment amount, the event emits the real amount paid on the payment.

        @param _paid Real amount paid
    */
    event AddedPaid(bytes32 indexed _id, uint256 _paid);

    // Model interface selector
    bytes4 internal constant MODEL_INTERFACE = 0xaf498c35;

    uint256 public constant STATUS_ONGOING = 1;
    uint256 public constant STATUS_PAID = 2;
    uint256 public constant STATUS_ERROR = 4;

    // ///
    // Meta
    // ///

    /**
        @return Identifier of the model
    */
    function modelId() external view returns (bytes32);

    /**
        Returns the address of the contract used as Descriptor of the model

        @dev The descriptor contract should follow the ModelDescriptor.sol scheme

        @return Address of the descriptor
    */
    function descriptor() external view returns (address);

    /**
        If called for any address with the ability to modify the state of the model registries,
            this method should return True.

        @dev Some contracts may check if the DebtEngine is
            an operator to know if the model is operative or not.

        @param operator Address of the target request operator

        @return True if operator is able to modify the state of the model
    */
    function isOperator(address operator) external view returns (bool canOperate);

    /**
        Validates the data for the creation of a new registry, if returns True the
            same data should be compatible with the create method.

        @dev This method can revert the call or return false, and both meant an invalid data.

        @param data Data to validate

        @return True if the data can be used to create a new registry
    */
    function validate(bytes calldata data) external view returns (bool isValid);

    // ///
    // Getters
    // ///

    /**
        Exposes the current status of the registry. The possible values are:

        1: Ongoing - The debt is still ongoing and waiting to be paid
        2: Paid - The debt is already paid and
        4: Error - There was an Error with the registry

        @dev This method should always be called by the DebtEngine

        @param id Id of the registry

        @return The current status value
    */
    function getStatus(bytes32 id) external view returns (uint256 status);

    /**
        Returns the total paid amount on the registry.

        @dev it should equal to the sum of all real addPaid

        @param id Id of the registry

        @return Total paid amount
    */
    function getPaid(bytes32 id) external view returns (uint256 paid);

    /**
        If the returned amount does not depend on any interactions and only on the model logic,
            the defined flag will be True; if the amount is an estimation of the future debt,
            the flag will be set to False.

        If timestamp equals the current moment, the defined flag should always be True.

        @dev This can be a gas-intensive method to call, consider calling the run method before.

        @param id Id of the registry
        @param timestamp Timestamp of the obligation query

        @return amount Amount pending to pay on the given timestamp
        @return defined True If the amount returned is fixed and can't change
    */
    function getObligation(bytes32 id, uint64 timestamp) external view returns (uint256 amount, bool defined);

    /**
        The amount required to fully paid a registry.

        All registries should be payable in a single time, even when it has multiple installments.

        If the registry discounts interest for early payment, those discounts should be
            taken into account in the returned amount.

        @dev This can be a gas-intensive method to call, consider calling the run method before.

        @param id Id of the registry

        @return amount Amount required to fully paid the loan on the current timestamp
    */
    function getClosingObligation(bytes32 id) external view returns (uint256 amount);

    /**
        The timestamp of the next required payment.

        After this moment, if the payment goal is not met the debt will be considered overdue.

            The getObligation method can be used to know the required payment on the future timestamp.

        @param id Id of the registry

        @return timestamp The timestamp of the next due time
    */
    function getDueTime(bytes32 id) external view returns (uint256 timestamp);

    // ///
    // Metadata
    // ///

    /**
        If the loan has multiple installments returns the duration of each installment in seconds,
            if the loan has not installments it should return 1.

        @param id Id of the registry

        @return frequency Frequency of each installment
    */
    function getFrequency(bytes32 id) external view returns (uint256 frequency);

    /**
        If the loan has multiple installments returns the total of installments,
            if the loan has not installments it should return 1.

        @param id Id of the registry

        @return installments Total of installments
    */
    function getInstallments(bytes32 id) external view returns (uint256 installments);

    /**
        The registry could be paid before or after the date, but the debt will always be
            considered overdue if paid after this timestamp.

        This is the estimated final payment date of the debt if it's always paid on each exact dueTime.

        @param id Id of the registry

        @return timestamp Timestamp of the final due time
    */
    function getFinalTime(bytes32 id) external view returns (uint256 timestamp);

    /**
        Similar to getFinalTime returns the expected payment remaining if paid always on the exact dueTime.

        If the model has no interest discounts for early payments,
            this method should return the same value as getClosingObligation.

        @param id Id of the registry

        @return amount Expected payment amount
    */
    function getEstimateObligation(bytes32 id) external view returns (uint256 amount);

    // ///
    // State interface
    // ///

    /**
        Creates a new registry using the provided data and id, it should fail if the id already exists
            or if calling validate(data) returns false or throws.

        @dev This method should only be callable by an operator

        @param id Id of the registry to create
        @param data Data to construct the new registry

        @return success True if the registry was created
    */
    function create(bytes32 id, bytes calldata data) external returns (bool success);

    /**
        If the registry is fully paid on the call and the amount parameter exceeds the required
            payment amount, the method returns the real amount used on the payment.

        The payment taken should always be the same as the requested unless the registry
            is fully paid on the process.

        @dev This method should only be callable by an operator

        @param id If of the registry
        @param amount Amount to pay

        @return real Real amount paid
    */
    function addPaid(bytes32 id, uint256 amount) external returns (uint256 real);

    /**
        Adds a new amount to be paid on the debt model,
            each model can handle the addition of more debt freely.

        @dev This method should only be callable by an operator

        @param id Id of the registry
        @param amount Debt amount to add to the registry

        @return added True if the debt was added
    */
    function addDebt(bytes32 id, uint256 amount) external returns (bool added);

    // ///
    // Utils
    // ///

    /**
        Runs the internal clock of a registry, this is used to compute the last changes on the state.
            It can make transactions cheaper by avoiding multiple calculations when calling views.

        Not all models have internal clocks, a model without an internal clock should always return false.

        Calls to this method should be possible from any address,
            multiple calls to run shouldn't affect the internal calculations of the model.

        @dev If the call had no effect the method would return False,
            that is no sign of things going wrong, and the call shouldn't be wrapped on a require

        @param id If of the registry

        @return effect True if the run performed a change on the state
    */
    function run(bytes32 id) external returns (bool effect);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/core/diaspore/interfaces/ModelDescriptor.sol

pragma solidity ^0.5.11;


contract ModelDescriptor {
    bytes4 internal constant MODEL_DESCRIPTOR_INTERFACE = 0x02735375;

    function simFirstObligation(bytes calldata data) external view returns (uint256 amount, uint256 time);
    function simTotalObligation(bytes calldata data) external view returns (uint256 amount);
    function simDuration(bytes calldata data) external view returns (uint256 duration);
    function simPunitiveInterestRate(bytes calldata data) external view returns (uint256 punitiveInterestRate);
    function simFrequency(bytes calldata data) external view returns (uint256 frequency);
    function simInstallments(bytes calldata data) external view returns (uint256 installments);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/interfaces/IERC173.sol

pragma solidity ^0.5.11;


/// @title ERC-173 Contract Ownership Standard
/// @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-173.md
///  Note: the ERC-165 identifier for this interface is 0x7f5828d0
contract IERC173 {
    /// @dev This emits when ownership of a contract changes.
    event OwnershipTransferred(address indexed _previousOwner, address indexed _newOwner);

    /// @notice Get the address of the owner
    /// @return The address of the owner.
    //// function owner() external view returns (address);

    /// @notice Set the address of the new owner of the contract
    /// @param _newOwner The address of the new owner of the contract
    function transferOwnership(address _newOwner) external;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/commons/Ownable.sol

pragma solidity ^0.5.11;

contract Ownable is IERC173 {
    address internal _owner;

    modifier onlyOwner() {
        require(msg.sender == _owner, "The owner should be the sender");
        _;
    }

    constructor() public {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0x0), msg.sender);
    }

    function owner() external view returns (address) {
        return _owner;
    }

    /**
        @dev Transfers the ownership of the contract.

        @param _newOwner Address of the new owner
    */
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "0x0 Is not a valid owner");
        emit OwnershipTransferred(_owner, _newOwner);
        _owner = _newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/commons/ERC165.sol

pragma solidity ^0.5.11;

/**
 * @title ERC165
 * @author Matt Condon (@shrugs)
 * @dev Implements ERC165 using a lookup table.
 */
contract ERC165 is IERC165 {
    bytes4 private constant _InterfaceId_ERC165 = 0x01ffc9a7;
    /**
    * 0x01ffc9a7 ===
    *   bytes4(keccak256('supportsInterface(bytes4)'))
    */

    /**
    * @dev a mapping of interface id to whether or not it's supported
    */
    mapping(bytes4 => bool) private _supportedInterfaces;

    /**
    * @dev A contract implementing SupportsInterfaceWithLookup
    * implement ERC165 itself
    */
    constructor()
        internal
    {
        _registerInterface(_InterfaceId_ERC165);
    }

    /**
    * @dev implement supportsInterface(bytes4) using a lookup table
    */
    function supportsInterface(bytes4 interfaceId)
        external
        view
        returns (bool)
    {
        return _supportedInterfaces[interfaceId];
    }

    /**
    * @dev internal method for registering an interface
    */
    function _registerInterface(bytes4 interfaceId)
        internal
    {
        require(interfaceId != 0xffffffff, "Can't register 0xffffffff");
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/utils/SafeMath.sol

pragma solidity ^0.5.11;


library SafeMath {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "Add overflow");
        return z;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256) {
        require(x >= y, "Sub overflow");
        return x - y;
    }

    function mult(uint256 x, uint256 y) internal pure returns (uint256) {
        if (x == 0) {
            return 0;
        }

        uint256 z = x * y;
        require(z/x == y, "Mult overflow");
        return z;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/utils/BytesUtils.sol

pragma solidity ^0.5.11;


contract BytesUtils {
    function readBytes32(bytes memory data, uint256 index) internal pure returns (bytes32 o) {
        require(data.length / 32 > index, "Reading bytes out of bounds");
        assembly {
            o := mload(add(data, add(32, mul(32, index))))
        }
    }

    function read(bytes memory data, uint256 offset, uint256 length) internal pure returns (bytes32 o) {
        require(data.length >= offset + length, "Reading bytes out of bounds");
        assembly {
            o := mload(add(data, add(32, offset)))
            let lb := sub(32, length)
            if lb { o := div(o, exp(2, mul(lb, 8))) }
        }
    }

    function decode(
        bytes memory _data,
        uint256 _la
    ) internal pure returns (bytes32 _a) {
        require(_data.length >= _la, "Reading bytes out of bounds");
        assembly {
            _a := mload(add(_data, 32))
            let l := sub(32, _la)
            if l { _a := div(_a, exp(2, mul(l, 8))) }
        }
    }

    function decode(
        bytes memory _data,
        uint256 _la,
        uint256 _lb
    ) internal pure returns (bytes32 _a, bytes32 _b) {
        uint256 o;
        assembly {
            let s := add(_data, 32)
            _a := mload(s)
            let l := sub(32, _la)
            if l { _a := div(_a, exp(2, mul(l, 8))) }
            o := add(s, _la)
            _b := mload(o)
            l := sub(32, _lb)
            if l { _b := div(_b, exp(2, mul(l, 8))) }
            o := sub(o, s)
        }
        require(_data.length >= o, "Reading bytes out of bounds");
    }

    function decode(
        bytes memory _data,
        uint256 _la,
        uint256 _lb,
        uint256 _lc
    ) internal pure returns (bytes32 _a, bytes32 _b, bytes32 _c) {
        uint256 o;
        assembly {
            let s := add(_data, 32)
            _a := mload(s)
            let l := sub(32, _la)
            if l { _a := div(_a, exp(2, mul(l, 8))) }
            o := add(s, _la)
            _b := mload(o)
            l := sub(32, _lb)
            if l { _b := div(_b, exp(2, mul(l, 8))) }
            o := add(o, _lb)
            _c := mload(o)
            l := sub(32, _lc)
            if l { _c := div(_c, exp(2, mul(l, 8))) }
            o := sub(o, s)
        }
        require(_data.length >= o, "Reading bytes out of bounds");
    }

    function decode(
        bytes memory _data,
        uint256 _la,
        uint256 _lb,
        uint256 _lc,
        uint256 _ld
    ) internal pure returns (bytes32 _a, bytes32 _b, bytes32 _c, bytes32 _d) {
        uint256 o;
        assembly {
            let s := add(_data, 32)
            _a := mload(s)
            let l := sub(32, _la)
            if l { _a := div(_a, exp(2, mul(l, 8))) }
            o := add(s, _la)
            _b := mload(o)
            l := sub(32, _lb)
            if l { _b := div(_b, exp(2, mul(l, 8))) }
            o := add(o, _lb)
            _c := mload(o)
            l := sub(32, _lc)
            if l { _c := div(_c, exp(2, mul(l, 8))) }
            o := add(o, _lc)
            _d := mload(o)
            l := sub(32, _ld)
            if l { _d := div(_d, exp(2, mul(l, 8))) }
            o := sub(o, s)
        }
        require(_data.length >= o, "Reading bytes out of bounds");
    }

    function decode(
        bytes memory _data,
        uint256 _la,
        uint256 _lb,
        uint256 _lc,
        uint256 _ld,
        uint256 _le
    ) internal pure returns (bytes32 _a, bytes32 _b, bytes32 _c, bytes32 _d, bytes32 _e) {
        uint256 o;
        assembly {
            let s := add(_data, 32)
            _a := mload(s)
            let l := sub(32, _la)
            if l { _a := div(_a, exp(2, mul(l, 8))) }
            o := add(s, _la)
            _b := mload(o)
            l := sub(32, _lb)
            if l { _b := div(_b, exp(2, mul(l, 8))) }
            o := add(o, _lb)
            _c := mload(o)
            l := sub(32, _lc)
            if l { _c := div(_c, exp(2, mul(l, 8))) }
            o := add(o, _lc)
            _d := mload(o)
            l := sub(32, _ld)
            if l { _d := div(_d, exp(2, mul(l, 8))) }
            o := add(o, _ld)
            _e := mload(o)
            l := sub(32, _le)
            if l { _e := div(_e, exp(2, mul(l, 8))) }
            o := sub(o, s)
        }
        require(_data.length >= o, "Reading bytes out of bounds");
    }

    function decode(
        bytes memory _data,
        uint256 _la,
        uint256 _lb,
        uint256 _lc,
        uint256 _ld,
        uint256 _le,
        uint256 _lf
    ) internal pure returns (
        bytes32 _a,
        bytes32 _b,
        bytes32 _c,
        bytes32 _d,
        bytes32 _e,
        bytes32 _f
    ) {
        uint256 o;
        assembly {
            let s := add(_data, 32)
            _a := mload(s)
            let l := sub(32, _la)
            if l { _a := div(_a, exp(2, mul(l, 8))) }
            o := add(s, _la)
            _b := mload(o)
            l := sub(32, _lb)
            if l { _b := div(_b, exp(2, mul(l, 8))) }
            o := add(o, _lb)
            _c := mload(o)
            l := sub(32, _lc)
            if l { _c := div(_c, exp(2, mul(l, 8))) }
            o := add(o, _lc)
            _d := mload(o)
            l := sub(32, _ld)
            if l { _d := div(_d, exp(2, mul(l, 8))) }
            o := add(o, _ld)
            _e := mload(o)
            l := sub(32, _le)
            if l { _e := div(_e, exp(2, mul(l, 8))) }
            o := add(o, _le)
            _f := mload(o)
            l := sub(32, _lf)
            if l { _f := div(_f, exp(2, mul(l, 8))) }
            o := sub(o, s)
        }
        require(_data.length >= o, "Reading bytes out of bounds");
    }

}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/core/diaspore/model/NanoLoanModel.sol

pragma solidity ^0.5.11;






contract MinMax {
    function min(uint256 a, uint256 b) internal pure returns(uint256) {
        return (a < b) ? a : b;
    }

    function max(uint256 a, uint256 b) internal pure returns(uint256) {
        return (a > b) ? a : b;
    }
}


contract NanoLoanModel is ERC165, BytesUtils, Ownable, Model, ModelDescriptor, MinMax  {
    using SafeMath for uint256;
    using SafeMath for uint128;
    using SafeMath for uint64;

    address public engine;
    address private altDescriptor;

    mapping(bytes32 => Config) public configs;
    mapping(bytes32 => State) public states;
    mapping(bytes4 => bool) private _supportedInterface;

    uint256 public constant L_DATA = 16 + 32 + 32 + 8 + 8; // amount + interestRate + interestRatePunitory + duesIn + cancelableAt

    uint256 private constant U_128_OVERFLOW = 2 ** 128;
    uint256 private constant U_64_OVERFLOW = 2 ** 64;

    event _setEngine(address _engine);
    event _setDescriptor(address _descriptor);
    event _setInterest(bytes32 _id, uint128 _interest);
    event _setPunitoryInterest(bytes32 _id, uint128 _punitoryInterest);
    event _setInterestTimestamp(bytes32 _id, uint256 _interestTimestamp);

    constructor() public {
        _registerInterface(MODEL_INTERFACE);
        _registerInterface(MODEL_DESCRIPTOR_INTERFACE);
    }

    struct Config {
        uint128 amount;
        uint256 interestRate;
        uint256 interestRatePunitory;
        uint64 dueTime;
        bytes32 id;
    }

    struct State {
        uint128 paid;
        uint128 interest;
        uint128 punitoryInterest;
        uint64 interestTimestamp;
        uint8 status;
    }

    modifier onlyEngine {
        require(msg.sender == engine, "Only engine allowed");
        _;
    }

    function modelId() external view returns (bytes32) {
        // NanoLoanModel 1.0
        return bytes32(0x0000000000000000000000000000004e616e6f4c6f616e4d6f64656c20312e30);
    }

    function descriptor() external view returns (address) {
        return altDescriptor == address(0) ? address(this) : address(altDescriptor);
    }

    function setEngine(address _engine) external onlyOwner returns (bool) {
        engine = _engine;
        emit _setEngine(_engine);
        return true;
    }

    function setDescriptor(address _descriptor) external onlyOwner returns (bool) {
        altDescriptor = _descriptor;
        emit _setDescriptor(_descriptor);
        return true;
    }

    function encodeData(
        uint128 _amount,
        uint256 _interestRate,
        uint256 _interestRatePunitory,
        uint64  _dueTime,
        uint64  _cancelableAt
    ) external pure returns (bytes memory) {
        return abi.encodePacked(
            _amount,
            _interestRate,
            _interestRatePunitory,
            _dueTime,
            _cancelableAt
        );
    }

    function isOperator(address _target) external view returns (bool) {
        return engine == _target;
    }

    /**
        @dev Look in _validate function documentation for more info

        @param data Array of bytes parameters, used to create a loan
            * look in _decodeData function documentation for more info
    */
    function validate(bytes calldata data) external view returns (bool) {
        (
            uint128 amount, uint256 interestRate, uint256 interestRatePunitory,
            uint64 duesIn, uint64 cancelableAt
        ) = _decodeData(data);

        _validate(
            amount,
            interestRate,
            interestRatePunitory,
            duesIn,
            cancelableAt
        );

        return true;
    }

    /**
        @dev Validate the loan parameters
            The duesIn should be less or equal than cancelableAt and not 0
            The interestRate should be more than 1000
            The interestRatePunitory should be more than 1000
            The amount should not be 0
    */
    function _validate(
        uint128 _amount,
        uint256 _interestRate,
        uint256 _interestRatePunitory,
        uint64 _duesIn,
        uint64 _cancelableAt
    ) internal view {
        require(_cancelableAt <= _duesIn, "The cancelableAt should be less or equal than duesIn");
        require(_interestRate > 1000, "Interest rate too high");
        require(_interestRatePunitory > 1000, "Punitory interest rate too high");
        require(_amount != 0, "amount can't be 0");

        require(uint64(now) + _duesIn > uint64(now), "duesIn should be not 0 or overflow now plus duesIn");
        // cancelableAt cant make overflow because:
        //     cancelableAt <= duesIn
        // and we check the sum of duesIn and now in the previus requiere
    }

    function getStatus(bytes32 id) external view returns (uint256) {
        return states[id].status;
    }

    function getPaid(bytes32 id) external view returns (uint256) {
        return states[id].paid;
    }

    function getObligation(bytes32 id, uint64 timestamp) external view returns (uint256 amount, bool defined) {
        amount = _getObligation(id, timestamp);
        defined = timestamp == now || timestamp <= states[id].interestTimestamp;
    }

    function _getObligation(bytes32 id, uint256 timestamp) internal view returns (uint256 total){
        State storage state = states[id];
        if (state.status == STATUS_PAID)
            return 0;
        Config storage config = configs[id];

        uint256 calcInterest;
        uint256 endNonPunitory = min(timestamp, config.dueTime);

        if (state.paid < config.amount)
            total = config.amount - state.paid;

        if (state.interestTimestamp < endNonPunitory)
            (, calcInterest) = _calculateInterest(endNonPunitory - state.interestTimestamp, config.interestRate, total);

        if (timestamp > config.dueTime && timestamp > state.interestTimestamp) {
            uint256 debt = config.amount.add(calcInterest).add(state.interest);
            uint256 pending = min(debt, debt.add(state.punitoryInterest).sub(state.paid));

            (, debt) = _calculateInterest(timestamp - max(config.dueTime, state.interestTimestamp), config.interestRatePunitory, pending);// cant overflow, check in the previus if
            calcInterest = debt.add(calcInterest);
        }

        total = total.add(calcInterest).add(state.interest).add(state.punitoryInterest);
    }

    function getClosingObligation(bytes32 id) external view returns (uint256 total){
        return _getObligation(id, now);
    }

    function getDueTime(bytes32 id) external view returns (uint256) {
        return states[id].status == STATUS_PAID ? 0 : configs[id].dueTime;
    }

    function getFinalTime(bytes32 id) external view returns (uint256) {
        return configs[id].dueTime;
    }

    function getFrequency(bytes32 id) external view returns (uint256) {
        return configs[id].dueTime == 0 ? 0 : 1;
    }

    function getInstallments(bytes32 id) external view returns (uint256) {
        return configs[id].dueTime == 0 ? 0 : 1;
    }

    function getEstimateObligation(bytes32 id) external view returns (uint256 total) {
        return _getObligation(id, now);
    }

    /**
        @dev Before create the loan the data should be validate with call _validate function

        @param id Index of the loan
        @param data Array of bytes parameters, used to create a loan
            * look in _decodeData function documentation for more info
    */
    function create(bytes32 id, bytes calldata data) external onlyEngine returns (bool) {
        require(configs[id].interestRate == 0, "Entry already exist");

        (uint128 amount, uint256 interestRate, uint256 interestRatePunitory,
            uint64 duesIn, uint64 cancelableAt) = _decodeData(data);

        _validate(
            amount,
            interestRate,
            interestRatePunitory,
            duesIn,
            cancelableAt
        );

        configs[id] = Config({
            amount: amount,
            interestRate: interestRate,
            interestRatePunitory: interestRatePunitory,
            dueTime: uint64(now) + duesIn, // check overflow in validate
            id: id
        });
        emit Created(id);

        states[id].interestTimestamp = uint64(now);
        emit _setInterestTimestamp(id, now);

        if (cancelableAt != 0)
            _addInterest(id, now + uint256(cancelableAt)); // check overflow in validate

        return true;
    }

    /**
        @notice Pay loan

        Does a payment of a given Loan, before performing the payment the accumulated
        interest is computed and added to the total pending amount.

        If the paid pending amount equals zero, the loan changes status to "paid" and it is considered closed.

        @param id Index of the loan
        @param amount Amount to pay

        @return toPay if the payment was executed successfully
    */
    function addPaid(bytes32 id, uint256 amount) external onlyEngine returns (uint256 toPay) {
        State storage state = states[id];

        require(state.status != STATUS_PAID, "The loan status should not be paid");
        _addInterest(id, now);

        uint256 totalDebt = configs[id].amount.add(state.interest).add(state.punitoryInterest);

        toPay = min(totalDebt.sub(state.paid), amount);

        uint256 newPay = toPay.add(state.paid);
        require(newPay < U_128_OVERFLOW, "Paid overflow");
        state.paid = uint128(newPay);
        emit AddedPaid(id, newPay);

        if (totalDebt - newPay == 0) { // check overflow in min
            state.status = uint8(STATUS_PAID);
            emit ChangedStatus(id, now, uint8(STATUS_PAID));
        }
    }

    /**
        @notice Computes loan interest

        Computes the punitory and non-punitory interest of a given loan and only applies the change.

        @param id Index of the loan to compute interest
        @param timestamp Target absolute unix time to calculate interest.
    */
    function _addInterest(bytes32 id, uint256 timestamp) internal returns(bool) {
        Config storage config = configs[id];
        State storage state = states[id];

        uint256 newInterest = state.interest;

        uint256 realDelta;
        uint256 calculatedInterest;

        uint256 newTimestamp;
        uint256 pending;
        if (state.interestTimestamp < timestamp) {
            uint256 endNonPunitory = min(timestamp, config.dueTime);
            if (state.interestTimestamp < endNonPunitory) {
                if (state.paid < config.amount)
                    pending = config.amount - state.paid;// cant overflow, check in if-condition

                (realDelta, calculatedInterest) = _calculateInterest(endNonPunitory - state.interestTimestamp, config.interestRate, pending);// cant overflow, check in if-condition
                newInterest = calculatedInterest.add(newInterest);
                newTimestamp = state.interestTimestamp.add(realDelta);
            }

            uint256 startPunitory;
            uint256 newPunitoryInterest;
            if (config.dueTime < timestamp) {
                startPunitory = max(config.dueTime, state.interestTimestamp);
                uint256 debt = config.amount.add(newInterest);
                newPunitoryInterest = state.punitoryInterest;
                pending = min(debt, debt.add(newPunitoryInterest).sub(state.paid));

                (realDelta, calculatedInterest) = _calculateInterest(timestamp - startPunitory, config.interestRatePunitory, pending);// cant overflow, check in the previus if
                newPunitoryInterest = newPunitoryInterest.add(calculatedInterest);
                newTimestamp = startPunitory.add(realDelta);
            }

            if (newInterest != state.interest || newPunitoryInterest != state.punitoryInterest) {
                require(newTimestamp < U_64_OVERFLOW, "newTimestamp overflow");
                state.interestTimestamp = uint64(newTimestamp);
                emit _setInterestTimestamp(id, newTimestamp);

                if (newInterest != state.interest) {
                    require(newInterest < U_128_OVERFLOW, "newInterest overflow");
                    state.interest = uint128(newInterest);
                    emit _setInterest(id, uint128(newInterest));
                }

                if (newPunitoryInterest != state.punitoryInterest) {
                    require(newPunitoryInterest < U_128_OVERFLOW, "newPunitoryInterest overflow");
                    state.punitoryInterest = uint128(newPunitoryInterest);
                    emit _setPunitoryInterest(id, uint128(newPunitoryInterest));
                }
                return true;
            }
        }
    }

    /**
        @notice Calculates the interest of a given amount, interest rate and delta time.

        @param timeDelta Elapsed time
        @param interestRate Interest rate expressed as the denominator of 10 000 000.
        @param amount Amount to apply interest

        @return realDelta The real timeDelta applied
        @return interest The interest gained in the realDelta time
    */
    function _calculateInterest(
        uint256 timeDelta,
        uint256 interestRate,
        uint256 amount
    ) internal pure returns (uint256 realDelta, uint256 interest) {
        if (amount == 0) {
            realDelta = timeDelta;
        } else {
            interest = timeDelta.mult(amount * 100000) / interestRate;
            realDelta = interest.mult(interestRate) / (amount * 100000);
        }
    }

    function addDebt(bytes32, uint256) external onlyEngine returns (bool) {
        revert("Not implemented!");
    }

    /**
        @notice Updates the loan accumulated interests up to the current Unix time.

        @param id Index of the loan

        @return true If the interest was updated
    */
    function run(bytes32 id) external returns (bool) {
        return _addInterest(id, now);
    }

    /**
        @notice Decode bytes array and returns the parameters of a loan

        @dev The length of data should be L_DATA (the sum of the length of thr loan parameters in bytes)
        @param _data Index of the loan
            from-to bytes
            0 -16: amount
            16-48: interestRate
            48-80: interestRatePunitory
            80-88: duesIn
            88-96: cancelableAt

        @return amount The requested amount
        @return interestRate The non-punitory interest rate by second, defined as a denominator of 10 000 000.
        @return interestRatePunitory The punitory interest rate by second, defined as a denominator of 10 000 000.
            Ej: interestRate 11108571428571 = 28% Anual interest
        @return duesIn The time in seconds that the borrower has in order to pay the debt after the lender lends the money.
        @return cancelableAt Delta in seconds specifying how much interest should be added in advance, if the borrower pays
            entirely or partially the loan before this term, no extra interest will be deducted.
    */
    function _decodeData(
        bytes memory _data
    ) internal pure returns (uint128, uint256, uint256, uint64, uint64) {
        require(_data.length == L_DATA, "Invalid data length");
        (bytes32 amount, bytes32 interestRate, bytes32 interestRatePunitory,
            bytes32 duesIn, bytes32 cancelableAt) = decode(_data, 16, 32, 32, 8, 8);
        return (
            uint128(uint256(amount)),
            uint256(interestRate),
            uint256(interestRatePunitory),
            uint64(uint256(duesIn)),
            uint64(uint256(cancelableAt))
        );
    }

    // implements modelDescriptor interface
    function simFirstObligation(bytes calldata _data) external view returns (uint256 amount, uint256 cancelableAt) {
        uint256 interestRate;
        (amount, interestRate,,, cancelableAt) = _decodeData(_data);
        (, interestRate) = _calculateInterest(cancelableAt, interestRate, amount);
        amount += interestRate;
    }

    function simTotalObligation(bytes calldata _data) external view returns (uint256 amount) {
        uint256 interestRate;
        uint256 cancelableAt;
        (amount, interestRate,,, cancelableAt) = _decodeData(_data);
        (, interestRate) = _calculateInterest(cancelableAt, interestRate, amount);
        amount += interestRate;
    }

    function simDuration(bytes calldata _data) external view returns (uint256 duration) {
        (,,, duration,) = _decodeData(_data);
    }

    function simPunitiveInterestRate(bytes calldata _data) external view returns (uint256 punitiveInterestRate) {
        (,, punitiveInterestRate,,) = _decodeData(_data);
    }

    function simFrequency(bytes calldata _data) external view returns (uint256 frequency) {
        return 1;
    }

    function simInstallments(bytes calldata _data) external view returns (uint256 installments) {
        return 1;
    }
}
