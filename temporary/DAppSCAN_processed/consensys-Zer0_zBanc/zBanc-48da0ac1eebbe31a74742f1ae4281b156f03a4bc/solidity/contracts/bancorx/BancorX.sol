// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/bancorx/interfaces/IBancorXUpgrader.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    Bancor X Upgrader interface
*/
interface IBancorXUpgrader {
    function upgrade(uint16 _version, address[] memory _reporters) external;
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/token/interfaces/IERC20Token.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    ERC20 Standard Token interface
*/
interface IERC20Token {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256);
    function allowance(address _owner, address _spender) external view returns (uint256);

    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
    function approve(address _spender, uint256 _value) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/bancorx/interfaces/IBancorX.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

interface IBancorX {
    function token() external view returns (IERC20Token);
    function xTransfer(bytes32 _toBlockchain, bytes32 _to, uint256 _amount, uint256 _id) external;
    function getXTransferAmount(uint256 _xTransferId, address _for) external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/interfaces/IOwned.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    Owned contract interface
*/
interface IOwned {
    // this function isn't since the compiler emits automatically generated getter functions as external
    function owner() external view returns (address);

    function transferOwnership(address _newOwner) external;
    function acceptOwnership() external;
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/Owned.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/**
  * @dev Provides support and utilities for contract ownership
*/
contract Owned is IOwned {
    address public override owner;
    address public newOwner;

    /**
      * @dev triggered when the owner is updated
      *
      * @param _prevOwner previous owner
      * @param _newOwner  new owner
    */
    event OwnerUpdate(address indexed _prevOwner, address indexed _newOwner);

    /**
      * @dev initializes a new Owned instance
    */
    constructor() public {
        owner = msg.sender;
    }

    // allows execution by the owner only
    modifier ownerOnly {
        _ownerOnly();
        _;
    }

    // error message binary size optimization
    function _ownerOnly() internal view {
        require(msg.sender == owner, "ERR_ACCESS_DENIED");
    }

    /**
      * @dev allows transferring the contract ownership
      * the new owner still needs to accept the transfer
      * can only be called by the contract owner
      *
      * @param _newOwner    new contract owner
    */
    function transferOwnership(address _newOwner) public override ownerOnly {
        require(_newOwner != owner, "ERR_SAME_OWNER");
        newOwner = _newOwner;
    }

    /**
      * @dev used by a new owner to accept an ownership transfer
    */
    function acceptOwnership() override public {
        require(msg.sender == newOwner, "ERR_ACCESS_DENIED");
        emit OwnerUpdate(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/Utils.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/**
  * @dev Utilities & Common Modifiers
*/
contract Utils {
    // verifies that a value is greater than zero
    modifier greaterThanZero(uint256 _value) {
        _greaterThanZero(_value);
        _;
    }

    // error message binary size optimization
    function _greaterThanZero(uint256 _value) internal pure {
        require(_value > 0, "ERR_ZERO_VALUE");
    }

    // validates an address - currently only checks that it isn't null
    modifier validAddress(address _address) {
        _validAddress(_address);
        _;
    }

    // error message binary size optimization
    function _validAddress(address _address) internal pure {
        require(_address != address(0), "ERR_INVALID_ADDRESS");
    }

    // verifies that the address is different than this contract address
    modifier notThis(address _address) {
        _notThis(_address);
        _;
    }

    // error message binary size optimization
    function _notThis(address _address) internal view {
        require(_address != address(this), "ERR_ADDRESS_IS_SELF");
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/interfaces/IContractRegistry.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    Contract Registry interface
*/
interface IContractRegistry {
    function addressOf(bytes32 _contractName) external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/ContractRegistryClient.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;



/**
  * @dev Base contract for ContractRegistry clients
*/
contract ContractRegistryClient is Owned, Utils {
    bytes32 internal constant CONTRACT_REGISTRY = "ContractRegistry";
    bytes32 internal constant BANCOR_NETWORK = "BancorNetwork";
    bytes32 internal constant BANCOR_FORMULA = "BancorFormula";
    bytes32 internal constant CONVERTER_FACTORY = "ConverterFactory";
    bytes32 internal constant CONVERSION_PATH_FINDER = "ConversionPathFinder";
    bytes32 internal constant CONVERTER_UPGRADER = "BancorConverterUpgrader";
    bytes32 internal constant CONVERTER_REGISTRY = "BancorConverterRegistry";
    bytes32 internal constant CONVERTER_REGISTRY_DATA = "BancorConverterRegistryData";
    bytes32 internal constant BNT_TOKEN = "BNTToken";
    bytes32 internal constant BANCOR_X = "BancorX";
    bytes32 internal constant BANCOR_X_UPGRADER = "BancorXUpgrader";
    bytes32 internal constant CHAINLINK_ORACLE_WHITELIST = "ChainlinkOracleWhitelist";

    IContractRegistry public registry;      // address of the current contract-registry
    IContractRegistry public prevRegistry;  // address of the previous contract-registry
    bool public onlyOwnerCanUpdateRegistry; // only an owner can update the contract-registry

    /**
      * @dev verifies that the caller is mapped to the given contract name
      *
      * @param _contractName    contract name
    */
    modifier only(bytes32 _contractName) {
        _only(_contractName);
        _;
    }

    // error message binary size optimization
    function _only(bytes32 _contractName) internal view {
        require(msg.sender == addressOf(_contractName), "ERR_ACCESS_DENIED");
    }

    /**
      * @dev initializes a new ContractRegistryClient instance
      *
      * @param  _registry   address of a contract-registry contract
    */
    constructor(IContractRegistry _registry) internal validAddress(address(_registry)) {
        registry = IContractRegistry(_registry);
        prevRegistry = IContractRegistry(_registry);
    }

    /**
      * @dev updates to the new contract-registry
     */
    function updateRegistry() public {
        // verify that this function is permitted
        require(msg.sender == owner || !onlyOwnerCanUpdateRegistry, "ERR_ACCESS_DENIED");

        // get the new contract-registry
        IContractRegistry newRegistry = IContractRegistry(addressOf(CONTRACT_REGISTRY));

        // verify that the new contract-registry is different and not zero
        require(newRegistry != registry && address(newRegistry) != address(0), "ERR_INVALID_REGISTRY");

        // verify that the new contract-registry is pointing to a non-zero contract-registry
        require(newRegistry.addressOf(CONTRACT_REGISTRY) != address(0), "ERR_INVALID_REGISTRY");

        // save a backup of the current contract-registry before replacing it
        prevRegistry = registry;

        // replace the current contract-registry with the new contract-registry
        registry = newRegistry;
    }

    /**
      * @dev restores the previous contract-registry
    */
    function restoreRegistry() public ownerOnly {
        // restore the previous contract-registry
        registry = prevRegistry;
    }

    /**
      * @dev restricts the permission to update the contract-registry
      *
      * @param _onlyOwnerCanUpdateRegistry  indicates whether or not permission is restricted to owner only
    */
    function restrictRegistryUpdate(bool _onlyOwnerCanUpdateRegistry) public ownerOnly {
        // change the permission to update the contract-registry
        onlyOwnerCanUpdateRegistry = _onlyOwnerCanUpdateRegistry;
    }

    /**
      * @dev returns the address associated with the given contract name
      *
      * @param _contractName    contract name
      *
      * @return contract address
    */
    function addressOf(bytes32 _contractName) internal view returns (address) {
        return registry.addressOf(_contractName);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/SafeMath.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/**
  * @dev Library for basic math operations with overflow/underflow protection
*/
library SafeMath {
    /**
      * @dev returns the sum of _x and _y, reverts if the calculation overflows
      *
      * @param _x   value 1
      * @param _y   value 2
      *
      * @return sum
    */
    function add(uint256 _x, uint256 _y) internal pure returns (uint256) {
        uint256 z = _x + _y;
        require(z >= _x, "ERR_OVERFLOW");
        return z;
    }

    /**
      * @dev returns the difference of _x minus _y, reverts if the calculation underflows
      *
      * @param _x   minuend
      * @param _y   subtrahend
      *
      * @return difference
    */
    function sub(uint256 _x, uint256 _y) internal pure returns (uint256) {
        require(_x >= _y, "ERR_UNDERFLOW");
        return _x - _y;
    }

    /**
      * @dev returns the product of multiplying _x by _y, reverts if the calculation overflows
      *
      * @param _x   factor 1
      * @param _y   factor 2
      *
      * @return product
    */
    function mul(uint256 _x, uint256 _y) internal pure returns (uint256) {
        // gas optimization
        if (_x == 0)
            return 0;

        uint256 z = _x * _y;
        require(z / _x == _y, "ERR_OVERFLOW");
        return z;
    }

    /**
      * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
      *
      * @param _x   dividend
      * @param _y   divisor
      *
      * @return quotient
    */
    function div(uint256 _x, uint256 _y) internal pure returns (uint256) {
        require(_y > 0, "ERR_DIVIDE_BY_ZERO");
        uint256 c = _x / _y;
        return c;
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/TokenHandler.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

contract TokenHandler {
    bytes4 private constant APPROVE_FUNC_SELECTOR = bytes4(keccak256("approve(address,uint256)"));
    bytes4 private constant TRANSFER_FUNC_SELECTOR = bytes4(keccak256("transfer(address,uint256)"));
    bytes4 private constant TRANSFER_FROM_FUNC_SELECTOR = bytes4(keccak256("transferFrom(address,address,uint256)"));

    /**
      * @dev executes the ERC20 token's `approve` function and reverts upon failure
      * the main purpose of this function is to prevent a non standard ERC20 token
      * from failing silently
      *
      * @param _token   ERC20 token address
      * @param _spender approved address
      * @param _value   allowance amount
    */
    function safeApprove(IERC20Token _token, address _spender, uint256 _value) internal {
        (bool success, bytes memory data) = address(_token).call(abi.encodeWithSelector(APPROVE_FUNC_SELECTOR, _spender, _value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'ERR_APPROVE_FAILED');
    }

    /**
      * @dev executes the ERC20 token's `transfer` function and reverts upon failure
      * the main purpose of this function is to prevent a non standard ERC20 token
      * from failing silently
      *
      * @param _token   ERC20 token address
      * @param _to      target address
      * @param _value   transfer amount
    */
    function safeTransfer(IERC20Token _token, address _to, uint256 _value) internal {
       (bool success, bytes memory data) = address(_token).call(abi.encodeWithSelector(TRANSFER_FUNC_SELECTOR, _to, _value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'ERR_TRANSFER_FAILED');
    }

    /**
      * @dev executes the ERC20 token's `transferFrom` function and reverts upon failure
      * the main purpose of this function is to prevent a non standard ERC20 token
      * from failing silently
      *
      * @param _token   ERC20 token address
      * @param _from    source address
      * @param _to      target address
      * @param _value   transfer amount
    */
    function safeTransferFrom(IERC20Token _token, address _from, address _to, uint256 _value) internal {
       (bool success, bytes memory data) = address(_token).call(abi.encodeWithSelector(TRANSFER_FROM_FUNC_SELECTOR, _from, _to, _value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'ERR_TRANSFER_FROM_FAILED');
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/interfaces/ITokenHolder.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;


/*
    Token Holder interface
*/
interface ITokenHolder is IOwned {
    function withdrawTokens(IERC20Token _token, address _to, uint256 _amount) external;
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/TokenHolder.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;





/**
  * @dev We consider every contract to be a 'token holder' since it's currently not possible
  * for a contract to deny receiving tokens.
  *
  * The TokenHolder's contract sole purpose is to provide a safety mechanism that allows
  * the owner to send tokens that were sent to the contract by mistake back to their sender.
  *
  * Note that we use the non standard ERC-20 interface which has no return value for transfer
  * in order to support both non standard as well as standard token contracts.
  * see https://github.com/ethereum/solidity/issues/4116
*/
contract TokenHolder is ITokenHolder, TokenHandler, Owned, Utils {
    /**
      * @dev withdraws tokens held by the contract and sends them to an account
      * can only be called by the owner
      *
      * @param _token   ERC20 token contract address
      * @param _to      account to receive the new amount
      * @param _amount  amount to withdraw
    */
    function withdrawTokens(IERC20Token _token, address _to, uint256 _amount)
        public
        virtual
        override
        ownerOnly
        validAddress(address(_token))
        validAddress(_to)
        notThis(_to)
    {
        safeTransfer(_token, _to, _amount);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/bancorx/BancorX.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;






/**
  * @dev The BancorX contract allows cross chain token transfers.
  *
  * There are two processes that take place in the contract -
  * - Initiate a cross chain transfer to a target blockchain (locks tokens from the caller account on Ethereum)
  * - Report a cross chain transfer initiated on a source blockchain (releases tokens to an account on Ethereum)
  *
  * Reporting cross chain transfers works similar to standard multisig contracts, meaning that multiple
  * callers are required to report a transfer before tokens are released to the target account.
*/
contract BancorX is IBancorX, TokenHandler, TokenHolder, ContractRegistryClient {
    using SafeMath for uint256;

    // represents a transaction on another blockchain where tokens were destroyed/locked
    struct Transaction {
        uint256 amount;
        bytes32 fromBlockchain;
        address to;
        uint8 numOfReports;
        bool completed;
    }

    uint16 public constant version = 4;

    uint256 public maxLockLimit;            // the maximum amount of tokens that can be locked in one transaction
    uint256 public maxReleaseLimit;         // the maximum amount of tokens that can be released in one transaction
    uint256 public minLimit;                // the minimum amount of tokens that can be transferred in one transaction
    uint256 public prevLockLimit;           // the lock limit *after* the last transaction
    uint256 public prevReleaseLimit;        // the release limit *after* the last transaction
    uint256 public limitIncPerBlock;        // how much the limit increases per block
    uint256 public prevLockBlockNumber;     // the block number of the last lock transaction
    uint256 public prevReleaseBlockNumber;  // the block number of the last release transaction
    uint8 public minRequiredReports;        // minimum number of required reports to release tokens

    IERC20Token public override token;      // erc20 token

    bool public xTransfersEnabled = true;   // true if x transfers are enabled, false if not
    bool public reportingEnabled = true;    // true if reporting is enabled, false if not

    // txId -> Transaction
    mapping (uint256 => Transaction) public transactions;

    // xTransferId -> txId
    mapping (uint256 => uint256) public transactionIds;

    // txId -> reporter -> true if reporter already reported txId
    mapping (uint256 => mapping (address => bool)) public reportedTxs;

    // address -> true if address is reporter
    mapping (address => bool) public reporters;

    /**
      * @dev triggered when tokens are locked in smart contract
      *
      * @param _from    wallet address that the tokens are locked from
      * @param _amount  amount locked
    */
    event TokensLock(
        address indexed _from,
        uint256 _amount
    );

    /**
      * @dev triggered when tokens are released by the smart contract
      *
      * @param _to      wallet address that the tokens are released to
      * @param _amount  amount released
    */
    event TokensRelease(
        address indexed _to,
        uint256 _amount
    );

    /**
      * @dev triggered when xTransfer is successfully called
      *
      * @param _from            wallet address that initiated the xtransfer
      * @param _toBlockchain    target blockchain
      * @param _to              target wallet
      * @param _amount          transfer amount
      * @param _id              xtransfer id
    */
    event XTransfer(
        address indexed _from,
        bytes32 _toBlockchain,
        bytes32 indexed _to,
        uint256 _amount,
        uint256 _id
    );

    /**
      * @dev triggered when report is successfully submitted
      *
      * @param _reporter        reporter wallet
      * @param _fromBlockchain  source blockchain
      * @param _txId            tx id on the source blockchain
      * @param _to              target wallet
      * @param _amount          transfer amount
      * @param _xTransferId     xtransfer id
    */
    event TxReport(
        address indexed _reporter,
        bytes32 _fromBlockchain,
        uint256 _txId,
        address _to,
        uint256 _amount,
        uint256 _xTransferId
    );

    /**
      * @dev triggered when final report is successfully submitted
      *
      * @param _to  target wallet
      * @param _id  xtransfer id
    */
    event XTransferComplete(
        address _to,
        uint256 _id
    );

    /**
      * @dev initializes a new BancorX instance
      *
      * @param _maxLockLimit          maximum amount of tokens that can be locked in one transaction
      * @param _maxReleaseLimit       maximum amount of tokens that can be released in one transaction
      * @param _minLimit              minimum amount of tokens that can be transferred in one transaction
      * @param _limitIncPerBlock      how much the limit increases per block
      * @param _minRequiredReports    minimum number of reporters to report transaction before tokens can be released
      * @param _registry              address of contract registry
      * @param _token                 erc20 token
     */
    constructor(
        uint256 _maxLockLimit,
        uint256 _maxReleaseLimit,
        uint256 _minLimit,
        uint256 _limitIncPerBlock,
        uint8 _minRequiredReports,
        IContractRegistry _registry,
        IERC20Token _token
    )   ContractRegistryClient(_registry)
        public
        greaterThanZero(_maxLockLimit)
        greaterThanZero(_maxReleaseLimit)
        greaterThanZero(_minLimit)
        greaterThanZero(_limitIncPerBlock)
        greaterThanZero(_minRequiredReports)
        validAddress(address(_token))
        notThis(address(_token))
    {
        // validate input
        require(_minLimit <= _maxLockLimit && _minLimit <= _maxReleaseLimit, "ERR_INVALID_MIN_LIMIT");

        // the maximum limits, minimum limit, and limit increase per block
        maxLockLimit = _maxLockLimit;
        maxReleaseLimit = _maxReleaseLimit;
        minLimit = _minLimit;
        limitIncPerBlock = _limitIncPerBlock;
        minRequiredReports = _minRequiredReports;

        // previous limit is _maxLimit, and previous block number is current block number
        prevLockLimit = _maxLockLimit;
        prevReleaseLimit = _maxReleaseLimit;
        prevLockBlockNumber = block.number;
        prevReleaseBlockNumber = block.number;

        token = _token;
    }

    // validates that the caller is a reporter
    modifier reporterOnly {
        _reporterOnly();
        _;
    }

    // error message binary size optimization
    function _reporterOnly() internal view {
        require(reporters[msg.sender], "ERR_ACCESS_DENIED");
    }

    // allows execution only when x transfers are enabled
    modifier xTransfersAllowed {
        _xTransfersAllowed();
        _;
    }

    // error message binary size optimization
    function _xTransfersAllowed() internal view {
        require(xTransfersEnabled, "ERR_DISABLED");
    }

    // allows execution only when reporting is enabled
    modifier reportingAllowed {
        _reportingAllowed();
        _;
    }

    // error message binary size optimization
    function _reportingAllowed() internal view {
        require(reportingEnabled, "ERR_DISABLED");
    }

    /**
      * @dev setter
      *
      * @param _maxLockLimit    new maxLockLimit
     */
    function setMaxLockLimit(uint256 _maxLockLimit) public ownerOnly greaterThanZero(_maxLockLimit) {
        maxLockLimit = _maxLockLimit;
    }

    /**
      * @dev setter
      *
      * @param _maxReleaseLimit    new maxReleaseLimit
     */
    function setMaxReleaseLimit(uint256 _maxReleaseLimit) public ownerOnly greaterThanZero(_maxReleaseLimit) {
        maxReleaseLimit = _maxReleaseLimit;
    }

    /**
      * @dev setter
      *
      * @param _minLimit    new minLimit
     */
    function setMinLimit(uint256 _minLimit) public ownerOnly greaterThanZero(_minLimit) {
        // validate input
        require(_minLimit <= maxLockLimit && _minLimit <= maxReleaseLimit, "ERR_INVALID_MIN_LIMIT");

        minLimit = _minLimit;
    }

    /**
      * @dev setter
      *
      * @param _limitIncPerBlock    new limitIncPerBlock
     */
    function setLimitIncPerBlock(uint256 _limitIncPerBlock) public ownerOnly greaterThanZero(_limitIncPerBlock) {
        limitIncPerBlock = _limitIncPerBlock;
    }

    /**
      * @dev setter
      *
      * @param _minRequiredReports    new minRequiredReports
     */
    function setMinRequiredReports(uint8 _minRequiredReports) public ownerOnly greaterThanZero(_minRequiredReports) {
        minRequiredReports = _minRequiredReports;
    }

    /**
      * @dev allows the owner to set/remove reporters
      *
      * @param _reporter    reporter whos status is to be set
      * @param _active      true if the reporter is approved, false otherwise
     */
    function setReporter(address _reporter, bool _active) public ownerOnly {
        reporters[_reporter] = _active;
    }

    /**
      * @dev allows the owner enable/disable the xTransfer method
      *
      * @param _enable     true to enable, false to disable
     */
    function enableXTransfers(bool _enable) public ownerOnly {
        xTransfersEnabled = _enable;
    }

    /**
      * @dev allows the owner enable/disable the reportTransaction method
      *
      * @param _enable     true to enable, false to disable
     */
    function enableReporting(bool _enable) public ownerOnly {
        reportingEnabled = _enable;
    }

    /**
      * @dev upgrades the contract to the latest version
      * can only be called by the owner
      * note that the owner needs to call acceptOwnership on the new contract after the upgrade
      *
      * @param _reporters    new list of reporters
    */
    function upgrade(address[] memory _reporters) public ownerOnly {
        IBancorXUpgrader bancorXUpgrader = IBancorXUpgrader(addressOf(BANCOR_X_UPGRADER));

        transferOwnership(address(bancorXUpgrader));
        bancorXUpgrader.upgrade(version, _reporters);
        acceptOwnership();
    }

    /**
      * @dev claims tokens from msg.sender to be converted to tokens on another blockchain
      *
      * @param _toBlockchain    blockchain on which tokens will be issued
      * @param _to              address to send the tokens to
      * @param _amount          the amount of tokens to transfer
     */
    function xTransfer(bytes32 _toBlockchain, bytes32 _to, uint256 _amount) public xTransfersAllowed {
        // get the current lock limit
        uint256 currentLockLimit = getCurrentLockLimit();

        // verify lock limit
        require(_amount >= minLimit && _amount <= currentLockLimit, "ERR_AMOUNT_TOO_HIGH");

        lockTokens(_amount);

        // set the previous lock limit and block number
        prevLockLimit = currentLockLimit.sub(_amount);
        prevLockBlockNumber = block.number;

        // emit XTransfer event with id of 0
        emit XTransfer(msg.sender, _toBlockchain, _to, _amount, 0);
    }

    /**
      * @dev claims tokens from msg.sender to be converted to tokens on another blockchain
      *
      * @param _toBlockchain    blockchain on which tokens will be issued
      * @param _to              address to send the tokens to
      * @param _amount          the amount of tokens to transfer
      * @param _id              pre-determined unique (if non zero) id which refers to this transaction
     */
    function xTransfer(bytes32 _toBlockchain, bytes32 _to, uint256 _amount, uint256 _id) public override xTransfersAllowed {
        // get the current lock limit
        uint256 currentLockLimit = getCurrentLockLimit();

        // require that; minLimit <= _amount <= currentLockLimit
        require(_amount >= minLimit && _amount <= currentLockLimit, "ERR_AMOUNT_TOO_HIGH");

        lockTokens(_amount);

        // set the previous lock limit and block number
        prevLockLimit = currentLockLimit.sub(_amount);
        prevLockBlockNumber = block.number;

        // emit XTransfer event
        emit XTransfer(msg.sender, _toBlockchain, _to, _amount, _id);
    }

    /**
      * @dev allows reporter to report transaction which occured on another blockchain
      *
      * @param _fromBlockchain  blockchain in which tokens were destroyed
      * @param _txId            transactionId of transaction thats being reported
      * @param _to              address to receive tokens
      * @param _amount          amount of tokens destroyed on another blockchain
      * @param _xTransferId     unique (if non zero) pre-determined id (unlike _txId which is determined after the transactions been mined)
     */
    function reportTx(
        bytes32 _fromBlockchain,
        uint256 _txId,
        address _to,
        uint256 _amount,
        uint256 _xTransferId
    )
        public
        reporterOnly
        reportingAllowed
        validAddress(_to)
        greaterThanZero(_amount)
    {
        // require that the transaction has not been reported yet by the reporter
        require(!reportedTxs[_txId][msg.sender], "ERR_ALREADY_REPORTED");

        // set reported as true
        reportedTxs[_txId][msg.sender] = true;

        Transaction storage txn = transactions[_txId];

        // If the caller is the first reporter, set the transaction details
        if (txn.numOfReports == 0) {
            txn.to = _to;
            txn.amount = _amount;
            txn.fromBlockchain = _fromBlockchain;

            if (_xTransferId != 0) {
                // verify uniqueness of xTransfer id to prevent overwriting
                require(transactionIds[_xTransferId] == 0, "ERR_TX_ALREADY_EXISTS");
                transactionIds[_xTransferId] = _txId;
            }
        }
        else {
            // otherwise, verify transaction details
            require(txn.to == _to && txn.amount == _amount && txn.fromBlockchain == _fromBlockchain, "ERR_TX_MISMATCH");

            if (_xTransferId != 0)
                require(transactionIds[_xTransferId] == _txId, "ERR_TX_ALREADY_EXISTS");
        }

        // increment the number of reports
        txn.numOfReports++;

        emit TxReport(msg.sender, _fromBlockchain, _txId, _to, _amount, _xTransferId);

        // if theres enough reports, try to release tokens
        if (txn.numOfReports >= minRequiredReports) {
            require(!transactions[_txId].completed, "ERR_TX_ALREADY_COMPLETED");

            // set the transaction as completed
            transactions[_txId].completed = true;

            emit XTransferComplete(_to, _xTransferId);

            releaseTokens(_to, _amount);
        }
    }

    /**
      * @dev gets x transfer amount by xTransferId (not txId)
      *
      * @param _xTransferId    unique (if non zero) pre-determined id (unlike _txId which is determined after the transactions been broadcasted)
      * @param _for            address corresponding to xTransferId
      *
      * @return amount that was sent in xTransfer corresponding to _xTransferId
    */
    function getXTransferAmount(uint256 _xTransferId, address _for) public view override returns (uint256) {
        // xTransferId -> txId -> Transaction
        Transaction memory transaction = transactions[transactionIds[_xTransferId]];

        // verify that the xTransferId is for _for
        require(transaction.to == _for, "ERR_TX_MISMATCH");

        return transaction.amount;
    }

    /**
      * @dev method for calculating current lock limit
      *
      * @return the current maximum limit of tokens that can be locked
     */
    function getCurrentLockLimit() public view returns (uint256) {
        // prevLockLimit + ((currBlockNumber - prevLockBlockNumber) * limitIncPerBlock)
        uint256 currentLockLimit = prevLockLimit.add(((block.number).sub(prevLockBlockNumber)).mul(limitIncPerBlock));
        if (currentLockLimit > maxLockLimit)
            return maxLockLimit;
        return currentLockLimit;
    }

    /**
      * @dev method for calculating current release limit
      *
      * @return the current maximum limit of tokens that can be released
     */
    function getCurrentReleaseLimit() public view returns (uint256) {
        // prevReleaseLimit + ((currBlockNumber - prevReleaseBlockNumber) * limitIncPerBlock)
        uint256 currentReleaseLimit = prevReleaseLimit.add(((block.number).sub(prevReleaseBlockNumber)).mul(limitIncPerBlock));
        if (currentReleaseLimit > maxReleaseLimit)
            return maxReleaseLimit;
        return currentReleaseLimit;
    }

    /**
      * @dev claims and locks tokens from msg.sender to be converted to tokens on another blockchain
      *
      * @param _amount  the amount of tokens to lock
     */
    function lockTokens(uint256 _amount) private {
        safeTransferFrom(token, msg.sender, address(this), _amount);
        emit TokensLock(msg.sender, _amount);
    }

    /**
      * @dev private method to release tokens held by the contract
      *
      * @param _to      the address to release tokens to
      * @param _amount  the amount of tokens to release
     */
    function releaseTokens(address _to, uint256 _amount) private {
        // get the current release limit
        uint256 currentReleaseLimit = getCurrentReleaseLimit();

        require(_amount >= minLimit && _amount <= currentReleaseLimit, "ERR_AMOUNT_TOO_HIGH");

        // update the previous release limit and block number
        prevReleaseLimit = currentReleaseLimit.sub(_amount);
        prevReleaseBlockNumber = block.number;

        // no need to require, reverts on failure
        safeTransfer(token, _to, _amount);

        emit TokensRelease(_to, _amount);
    }
}
