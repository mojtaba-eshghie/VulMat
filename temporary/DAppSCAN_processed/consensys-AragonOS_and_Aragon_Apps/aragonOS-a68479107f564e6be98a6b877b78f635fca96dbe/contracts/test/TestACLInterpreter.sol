// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/UnstructuredStorage.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


library UnstructuredStorage {
    function getStorageBool(bytes32 position) internal view returns (bool data) {
        assembly { data := sload(position) }
    }

    function getStorageAddress(bytes32 position) internal view returns (address data) {
        assembly { data := sload(position) }
    }

    function getStorageBytes32(bytes32 position) internal view returns (bytes32 data) {
        assembly { data := sload(position) }
    }

    function getStorageUint256(bytes32 position) internal view returns (uint256 data) {
        assembly { data := sload(position) }
    }

    function setStorageBool(bytes32 position, bool data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageAddress(bytes32 position, address data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageBytes32(bytes32 position, bytes32 data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageUint256(bytes32 position, uint256 data) internal {
        assembly { sstore(position, data) }
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/acl/IACL.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IACL {
    function initialize(address permissionsCreator) external;

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/IVaultRecoverable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IVaultRecoverable {
    function transferToVault(address token) external;

    function allowRecoverability(address token) external view returns (bool);
    function getRecoveryVault() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/kernel/IKernel.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


// This should be an interface, but interfaces can't inherit yet :(
contract IKernel is IVaultRecoverable {
    event SetApp(bytes32 indexed namespace, bytes32 indexed appId, address app);

    function acl() public view returns (IACL);
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);

    function setApp(bytes32 namespace, bytes32 appId, address app) public;
    function getApp(bytes32 namespace, bytes32 appId) public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/apps/AppStorage.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract AppStorage {
    using UnstructuredStorage for bytes32;

    // keccak256("aragonOS.appStorage.kernel")
    bytes32 internal constant KERNEL_POSITION = 0x4172f0f7d2289153072b0a6ca36959e0cbe2efc3afe50fc81636caa96338137b;
    // keccak256("aragonOS.appStorage.appId")
    bytes32 internal constant APP_ID_POSITION = 0xd625496217aa6a3453eecb9c3489dc5a53e6c67b444329ea2b2cbc9ff547639b;
    // keccak256("aragonOS.appStorage.pinnedCode"), used by Proxy Pinned
    bytes32 internal constant PINNED_CODE_POSITION = 0xdee64df20d65e53d7f51cb6ab6d921a0a6a638a91e942e1d8d02df28e31c038e;

    function kernel() public view returns (IKernel) {
        return IKernel(KERNEL_POSITION.getStorageAddress());
    }

    function appId() public view returns (bytes32) {
        return APP_ID_POSITION.getStorageBytes32();
    }

    function setKernel(IKernel _kernel) internal {
        KERNEL_POSITION.setStorageAddress(address(_kernel));
    }

    function setAppId(bytes32 _appId) internal {
        APP_ID_POSITION.setStorageBytes32(_appId);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/Uint256Helpers.sol

pragma solidity ^0.4.24;


library Uint256Helpers {
    uint256 public constant MAX_UINT64 = uint64(-1);

    string private constant ERROR_NUMBER_TOO_BIG = "UINT64_NUMBER_TOO_BIG";

    function toUint64(uint256 a) internal pure returns (uint64) {
        require(a <= MAX_UINT64, ERROR_NUMBER_TOO_BIG);
        return uint64(a);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/TimeHelpers.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;

contract TimeHelpers {
    using Uint256Helpers for uint256;

    /**
    * @dev Returns the current block number.
    *      Using a function rather than `block.number` allows us to easily mock the block number in
    *      tests.
    */
    function getBlockNumber() internal view returns (uint256) {
        return block.number;
    }

    /**
    * @dev Returns the current block number, converted to uint64.
    *      Using a function rather than `block.number` allows us to easily mock the block number in
    *      tests.
    */
    function getBlockNumber64() internal view returns (uint64) {
        return getBlockNumber().toUint64();
    }

    /**
    * @dev Returns the current timestamp.
    *      Using a function rather than `block.timestamp` allows us to easily mock it in
    *      tests.
    */
    // SWC-Code With No Effects: L37-L39
    function getTimestamp() internal view returns (uint256) {
        return block.timestamp; // solium-disable-line security/no-block-members
    }

    /**
    * @dev Returns the current timestamp, converted to uint64.
    *      Using a function rather than `block.timestamp` allows us to easily mock it in
    *      tests.
    */
    function getTimestamp64() internal view returns (uint64) {
        return getTimestamp().toUint64();
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/Initializable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract Initializable is TimeHelpers {
    using UnstructuredStorage for bytes32;

    // keccak256("aragonOS.initializable.initializationBlock")
    bytes32 internal constant INITIALIZATION_BLOCK_POSITION = 0xebb05b386a8d34882b8711d156f463690983dc47815980fb82aeeff1aa43579e;

    string private constant ERROR_ALREADY_INITIALIZED = "INIT_ALREADY_INITIALIZED";
    string private constant ERROR_NOT_INITIALIZED = "INIT_NOT_INITIALIZED";

    modifier onlyInit {
        require(getInitializationBlock() == 0, ERROR_ALREADY_INITIALIZED);
        _;
    }

    modifier isInitialized {
        require(hasInitialized(), ERROR_NOT_INITIALIZED);
        _;
    }

    /**
    * @return Block number in which the contract was initialized
    */
    function getInitializationBlock() public view returns (uint256) {
        return INITIALIZATION_BLOCK_POSITION.getStorageUint256();
    }

    /**
    * @return Whether the contract has been initialized by the time of the current block
    */
    function hasInitialized() public view returns (bool) {
        uint256 initializationBlock = getInitializationBlock();
        return initializationBlock != 0 && getBlockNumber() >= initializationBlock;
    }

    /**
    * @dev Function to be called by top level contract after initialization has finished.
    */
    function initialized() internal onlyInit {
        INITIALIZATION_BLOCK_POSITION.setStorageUint256(getBlockNumber());
    }

    /**
    * @dev Function to be called by top level contract after initialization to enable the contract
    *      at a future block number rather than immediately.
    */
    function initializedAt(uint256 _blockNumber) internal onlyInit {
        INITIALIZATION_BLOCK_POSITION.setStorageUint256(_blockNumber);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/Petrifiable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;

contract Petrifiable is Initializable {
    // Use block UINT256_MAX (which should be never) as the initializable date
    uint256 internal constant PETRIFIED_BLOCK = uint256(-1);

    function isPetrified() public view returns (bool) {
        return getInitializationBlock() == PETRIFIED_BLOCK;
    }

    /**
    * @dev Function to be called by top level contract to prevent being initialized.
    *      Useful for freezing base contracts when they're used behind proxies.
    */
    function petrify() internal onlyInit {
        initializedAt(PETRIFIED_BLOCK);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/Autopetrified.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;

contract Autopetrified is Petrifiable {
    constructor() public {
        // Immediately petrify base (non-proxy) instances of inherited contracts on deploy.
        // This renders them uninitializable (and unusable without a proxy).
        petrify();
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/lib/token/ERC20.sol

// See https://github.com/OpenZeppelin/openzeppelin-solidity/blob/a9f910d34f0ab33a1ae5e714f69f9596a02b4d91/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.4.24;


/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 {
    function totalSupply() public view returns (uint256);

    function balanceOf(address _who) public view returns (uint256);

    function allowance(address _owner, address _spender)
        public view returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

    function approve(address _spender, uint256 _value)
        public returns (bool);

    function transferFrom(address _from, address _to, uint256 _value)
        public returns (bool);

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

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/EtherTokenConstant.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


// aragonOS and aragon-apps rely on address(0) to denote native ETH, in
// contracts where both tokens and ETH are accepted
contract EtherTokenConstant {
    address public constant ETH = address(0);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/IsContract.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract IsContract {
    function isContract(address _target) internal view returns (bool) {
        if (_target == address(0)) {
            return false;
        }

        uint256 size;
        assembly { size := extcodesize(_target) }
        return size > 0;
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/common/VaultRecoverable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;




contract VaultRecoverable is IVaultRecoverable, EtherTokenConstant, IsContract {
    string private constant ERROR_DISALLOWED = "RECOVER_DISALLOWED";
    string private constant ERROR_VAULT_NOT_CONTRACT = "RECOVER_VAULT_NOT_CONTRACT";

    /**
     * @notice Send funds to recovery Vault. This contract should never receive funds,
     *         but in case it does, this function allows one to recover them.
     * @param _token Token balance to be sent to recovery vault.
     */
    function transferToVault(address _token) external {
        require(allowRecoverability(_token), ERROR_DISALLOWED);
        address vault = getRecoveryVault();
        require(isContract(vault), ERROR_VAULT_NOT_CONTRACT);

        if (_token == ETH) {
            vault.transfer(address(this).balance);
        } else {
            uint256 amount = ERC20(_token).balanceOf(this);
            ERC20(_token).transfer(vault, amount);
        }
    }

    /**
    * @dev By default deriving from AragonApp makes it recoverable
    * @param token Token address that would be recovered
    * @return bool whether the app allows the recovery
    */
    function allowRecoverability(address token) public view returns (bool) {
        return true;
    }

    // Cast non-implemented interface to be public so we can use it internally
    function getRecoveryVault() public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/evmscript/IEVMScriptExecutor.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IEVMScriptExecutor {
    function execScript(bytes script, bytes input, address[] blacklist) external returns (bytes);
    function executorType() external pure returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/evmscript/IEVMScriptRegistry.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;

contract EVMScriptRegistryConstants {
    /* Hardcoded constants to save gas
    bytes32 public constant EVMSCRIPT_REGISTRY_APP_ID = apmNamehash("evmreg");
    */
    bytes32 public constant EVMSCRIPT_REGISTRY_APP_ID = 0xddbcfd564f642ab5627cf68b9b7d374fb4f8a36e941a75d89c87998cef03bd61;
}


interface IEVMScriptRegistry {
    function addScriptExecutor(IEVMScriptExecutor executor) external returns (uint id);
    function disableScriptExecutor(uint256 executorId) external;

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function getScriptExecutor(bytes script) public view returns (IEVMScriptExecutor);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/kernel/KernelConstants.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract KernelConstants {
    /*
    bytes32 public constant CORE_NAMESPACE = keccak256("core");
    bytes32 public constant APP_BASES_NAMESPACE = keccak256("base");
    bytes32 public constant APP_ADDR_NAMESPACE = keccak256("app");

    bytes32 public constant KERNEL_APP_ID = apmNamehash("kernel");
    bytes32 public constant ACL_APP_ID = apmNamehash("acl");
    */
    bytes32 public constant CORE_NAMESPACE = 0xc681a85306374a5ab27f0bbc385296a54bcd314a1948b6cf61c4ea1bc44bb9f8;
    bytes32 public constant APP_BASES_NAMESPACE = 0xf1f3eb40f5bc1ad1344716ced8b8a0431d840b5783aea1fd01786bc26f35ac0f;
    bytes32 public constant APP_ADDR_NAMESPACE = 0xd6f028ca0e8edb4a8c9757ca4fdccab25fa1e0317da1188108f7d2dee14902fb;

    bytes32 public constant KERNEL_APP_ID = 0x3b4bf6bf3ad5000ecf0f989d5befde585c6860fea3e574a4fab4c49d1c177d9c;
    bytes32 public constant ACL_APP_ID = 0xe3262375f45a6e2026b7e7b18c2b807434f2508fe1a2a3dfb493c7df8f4aad6a;
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/evmscript/EVMScriptRunner.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;




contract EVMScriptRunner is AppStorage, Initializable, EVMScriptRegistryConstants, KernelConstants {
    string private constant ERROR_EXECUTOR_UNAVAILABLE = "EVMRUN_EXECUTOR_UNAVAILABLE";
    string private constant ERROR_EXECUTION_REVERTED = "EVMRUN_EXECUTION_REVERTED";
    string private constant ERROR_PROTECTED_STATE_MODIFIED = "EVMRUN_PROTECTED_STATE_MODIFIED";

    event ScriptResult(address indexed executor, bytes script, bytes input, bytes returnData);

    function getExecutor(bytes _script) public view returns (IEVMScriptExecutor) {
        return IEVMScriptExecutor(getExecutorRegistry().getScriptExecutor(_script));
    }

    function runScript(bytes _script, bytes _input, address[] _blacklist)
        internal
        isInitialized
        protectState
        returns (bytes)
    {
        // TODO: Too much data flying around, maybe extracting spec id here is cheaper
        IEVMScriptExecutor executor = getExecutor(_script);
        require(address(executor) != address(0), ERROR_EXECUTOR_UNAVAILABLE);

        bytes4 sig = executor.execScript.selector;
        bytes memory calldata = abi.encodeWithSelector(sig, _script, _input, _blacklist);
        require(address(executor).delegatecall(calldata), ERROR_EXECUTION_REVERTED);

        bytes memory output = returnedDataDecoded();

        emit ScriptResult(address(executor), _script, _input, output);

        return output;
    }

    function getExecutorRegistry() internal view returns (IEVMScriptRegistry) {
        address registryAddr = kernel().getApp(APP_ADDR_NAMESPACE, EVMSCRIPT_REGISTRY_APP_ID);
        return IEVMScriptRegistry(registryAddr);
    }

    /**
    * @dev copies and returns last's call data. Needs to ABI decode first
    */
    function returnedDataDecoded() internal pure returns (bytes ret) {
        assembly {
            let size := returndatasize
            switch size
            case 0 {}
            default {
                ret := mload(0x40) // free mem ptr get
                mstore(0x40, add(ret, add(size, 0x20))) // free mem ptr set
                returndatacopy(ret, 0x20, sub(size, 0x20)) // copy return data
            }
        }
        return ret;
    }

    modifier protectState {
        address preKernel = address(kernel());
        bytes32 preAppId = appId();
        _; // exec
        require(address(kernel()) == preKernel, ERROR_PROTECTED_STATE_MODIFIED);
        require(appId() == preAppId, ERROR_PROTECTED_STATE_MODIFIED);
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/acl/ACLSyntaxSugar.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract ACLSyntaxSugar {
    function arr() internal pure returns (uint256[]) {}

    function arr(bytes32 _a) internal pure returns (uint256[] r) {
        return arr(uint256(_a));
    }

    function arr(bytes32 _a, bytes32 _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a) internal pure returns (uint256[] r) {
        return arr(uint256(_a));
    }

    function arr(address _a, address _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a, uint256 _b, uint256 _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), _b, _c);
    }

    function arr(address _a, uint256 _b, uint256 _c, uint256 _d) internal pure returns (uint256[] r) {
        return arr(uint256(_a), _b, _c, _d);
    }

    function arr(address _a, uint256 _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a, address _b, uint256 _c, uint256 _d, uint256 _e) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), _c, _d, _e);
    }

    function arr(address _a, address _b, address _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), uint256(_c));
    }

    function arr(address _a, address _b, uint256 _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), uint256(_c));
    }

    function arr(uint256 _a) internal pure returns (uint256[] r) {
        r = new uint256[](1);
        r[0] = _a;
    }

    function arr(uint256 _a, uint256 _b) internal pure returns (uint256[] r) {
        r = new uint256[](2);
        r[0] = _a;
        r[1] = _b;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c) internal pure returns (uint256[] r) {
        r = new uint256[](3);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c, uint256 _d) internal pure returns (uint256[] r) {
        r = new uint256[](4);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
        r[3] = _d;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c, uint256 _d, uint256 _e) internal pure returns (uint256[] r) {
        r = new uint256[](5);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
        r[3] = _d;
        r[4] = _e;
    }
}


contract ACLHelpers {
    function decodeParamOp(uint256 _x) internal pure returns (uint8 b) {
        return uint8(_x >> (8 * 30));
    }

    function decodeParamId(uint256 _x) internal pure returns (uint8 b) {
        return uint8(_x >> (8 * 31));
    }

    function decodeParamsList(uint256 _x) internal pure returns (uint32 a, uint32 b, uint32 c) {
        a = uint32(_x);
        b = uint32(_x >> (8 * 4));
        c = uint32(_x >> (8 * 8));
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/apps/AragonApp.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;





// Contracts inheriting from AragonApp are, by default, immediately petrified upon deployment so
// that they can never be initialized.
// Unless overriden, this behaviour enforces those contracts to be usable only behind an AppProxy.
// ACLSyntaxSugar and EVMScriptRunner are not directly used by this contract, but are included so
// that they are automatically usable by subclassing contracts
contract AragonApp is AppStorage, Autopetrified, VaultRecoverable, EVMScriptRunner, ACLSyntaxSugar {
    string private constant ERROR_AUTH_FAILED = "APP_AUTH_FAILED";

    modifier auth(bytes32 _role) {
        require(canPerform(msg.sender, _role, new uint256[](0)), ERROR_AUTH_FAILED);
        _;
    }

    modifier authP(bytes32 _role, uint256[] _params) {
        require(canPerform(msg.sender, _role, _params), ERROR_AUTH_FAILED);
        _;
    }

    /**
    * @dev Check whether an action can be performed by a sender for a particular role on this app
    * @param _sender Sender of the call
    * @param _role Role on this app
    * @param _params Permission params for the role
    * @return Boolean indicating whether the sender has the permissions to perform the action.
    *         Always returns false if the app hasn't been initialized yet.
    */
    function canPerform(address _sender, bytes32 _role, uint256[] _params) public view returns (bool) {
        if (!hasInitialized()) {
            return false;
        }

        IKernel linkedKernel = kernel();
        if (address(linkedKernel) == address(0)) {
            return false;
        }

        bytes memory how; // no need to init memory as it is never used
        if (_params.length > 0) {
            uint256 byteLength = _params.length * 32;
            assembly {
                how := _params // forced casting
                mstore(how, byteLength)
            }
        }
        return linkedKernel.hasPermission(_sender, address(this), _role, how);
    }

    /**
    * @dev Get the recovery vault for the app
    * @return Recovery vault address for the app
    */
    function getRecoveryVault() public view returns (address) {
        // Funds recovery via a vault is only available when used with a kernel
        return kernel().getRecoveryVault(); // if kernel is not set, it will revert
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/acl/IACLOracle.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IACLOracle {
    function canPerform(address who, address where, bytes32 what, uint256[] how) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/acl/ACL.sol

pragma solidity 0.4.24;





/* solium-disable function-order */
// Allow public initialize() to be first
contract ACL is IACL, TimeHelpers, AragonApp, ACLHelpers {
    // Hardcoded constant to save gas
    //bytes32 public constant CREATE_PERMISSIONS_ROLE = keccak256("CREATE_PERMISSIONS_ROLE");
    bytes32 public constant CREATE_PERMISSIONS_ROLE = 0x0b719b33c83b8e5d300c521cb8b54ae9bd933996a14bef8c2f4e0285d2d2400a;

    // Whether someone has a permission
    mapping (bytes32 => bytes32) internal permissions; // permissions hash => params hash
    mapping (bytes32 => Param[]) internal permissionParams; // params hash => params

    // Who is the manager of a permission
    mapping (bytes32 => address) internal permissionManager;

    enum Op { NONE, EQ, NEQ, GT, LT, GTE, LTE, RET, NOT, AND, OR, XOR, IF_ELSE } // op types

    struct Param {
        uint8 id;
        uint8 op;
        uint240 value; // even though value is an uint240 it can store addresses
        // in the case of 32 byte hashes losing 2 bytes precision isn't a huge deal
        // op and id take less than 1 byte each so it can be kept in 1 sstore
    }

    uint8 internal constant BLOCK_NUMBER_PARAM_ID = 200;
    uint8 internal constant TIMESTAMP_PARAM_ID    = 201;
    // 202 is unused
    uint8 internal constant ORACLE_PARAM_ID       = 203;
    uint8 internal constant LOGIC_OP_PARAM_ID     = 204;
    uint8 internal constant PARAM_VALUE_PARAM_ID  = 205;
    // TODO: Add execution times param type?

    // Hardcoded constant to save gas
    //bytes32 public constant EMPTY_PARAM_HASH = keccak256(uint256(0));
    bytes32 public constant EMPTY_PARAM_HASH = 0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563;
    bytes32 public constant NO_PERMISSION = bytes32(0);
    address public constant ANY_ENTITY = address(-1);
    address public constant BURN_ENTITY = address(1); // address(0) is already used as "no permission manager"

    uint256 internal constant ORACLE_CHECK_GAS = 30000;

    string private constant ERROR_AUTH_INIT_KERNEL = "ACL_AUTH_INIT_KERNEL";
    string private constant ERROR_AUTH_NO_MANAGER = "ACL_AUTH_NO_MANAGER";
    string private constant ERROR_EXISTENT_MANAGER = "ACL_EXISTENT_MANAGER";

    modifier onlyPermissionManager(address _app, bytes32 _role) {
        require(msg.sender == getPermissionManager(_app, _role), ERROR_AUTH_NO_MANAGER);
        _;
    }

    modifier noPermissionManager(address _app, bytes32 _role) {
        // only allow permission creation (or re-creation) when there is no manager
        require(getPermissionManager(_app, _role) == address(0), ERROR_EXISTENT_MANAGER);
        _;
    }

    event SetPermission(address indexed entity, address indexed app, bytes32 indexed role, bool allowed);
    event SetPermissionParams(address indexed entity, address indexed app, bytes32 indexed role, bytes32 paramsHash);
    event ChangePermissionManager(address indexed app, bytes32 indexed role, address indexed manager);

    /**
    * @dev Initialize can only be called once. It saves the block number in which it was initialized.
    * @notice Initialize an ACL instance and set `_permissionsCreator` as the entity that can create other permissions
    * @param _permissionsCreator Entity that will be given permission over createPermission
    */
    function initialize(address _permissionsCreator) public onlyInit {
        initialized();
        require(msg.sender == address(kernel()), ERROR_AUTH_INIT_KERNEL);

        _createPermission(_permissionsCreator, this, CREATE_PERMISSIONS_ROLE, _permissionsCreator);
    }

    /**
    * @dev Creates a permission that wasn't previously set and managed.
    *      If a created permission is removed it is possible to reset it with createPermission.
    *      This is the **ONLY** way to create permissions and set managers to permissions that don't
    *      have a manager.
    *      In terms of the ACL being initialized, this function implicitly protects all the other
    *      state-changing external functions, as they all require the sender to be a manager.
    * @notice Create a new permission granting `_entity` the ability to perform actions requiring `_role` on `_app`, setting `_manager` as the permission's manager
    * @param _entity Address of the whitelisted entity that will be able to perform the role
    * @param _app Address of the app in which the role will be allowed (requires app to depend on kernel for ACL)
    * @param _role Identifier for the group of actions in app given access to perform
    * @param _manager Address of the entity that will be able to grant and revoke the permission further.
    */
    function createPermission(address _entity, address _app, bytes32 _role, address _manager)
        external
        auth(CREATE_PERMISSIONS_ROLE)
        noPermissionManager(_app, _role)
    {
        _createPermission(_entity, _app, _role, _manager);
    }

    /**
    * @dev Grants permission if allowed. This requires `msg.sender` to be the permission manager
    * @notice Grant `_entity` the ability to perform actions requiring `_role` on `_app`
    * @param _entity Address of the whitelisted entity that will be able to perform the role
    * @param _app Address of the app in which the role will be allowed (requires app to depend on kernel for ACL)
    * @param _role Identifier for the group of actions in app given access to perform
    */
    function grantPermission(address _entity, address _app, bytes32 _role)
        external
    {
        grantPermissionP(_entity, _app, _role, new uint256[](0));
    }

    /**
    * @dev Grants a permission with parameters if allowed. This requires `msg.sender` to be the permission manager
    * @notice Grant `_entity` the ability to perform actions requiring `_role` on `_app`
    * @param _entity Address of the whitelisted entity that will be able to perform the role
    * @param _app Address of the app in which the role will be allowed (requires app to depend on kernel for ACL)
    * @param _role Identifier for the group of actions in app given access to perform
    * @param _params Permission parameters
    */
    function grantPermissionP(address _entity, address _app, bytes32 _role, uint256[] _params)
        public
        onlyPermissionManager(_app, _role)
    {
        bytes32 paramsHash = _params.length > 0 ? _saveParams(_params) : EMPTY_PARAM_HASH;
        _setPermission(_entity, _app, _role, paramsHash);
    }

    /**
    * @dev Revokes permission if allowed. This requires `msg.sender` to be the the permission manager
    * @notice Revoke from `_entity` the ability to perform actions requiring `_role` on `_app`
    * @param _entity Address of the whitelisted entity to revoke access from
    * @param _app Address of the app in which the role will be revoked
    * @param _role Identifier for the group of actions in app being revoked
    */
    function revokePermission(address _entity, address _app, bytes32 _role)
        external
        onlyPermissionManager(_app, _role)
    {
        _setPermission(_entity, _app, _role, NO_PERMISSION);
    }

    /**
    * @notice Set `_newManager` as the manager of `_role` in `_app`
    * @param _newManager Address for the new manager
    * @param _app Address of the app in which the permission management is being transferred
    * @param _role Identifier for the group of actions being transferred
    */
    function setPermissionManager(address _newManager, address _app, bytes32 _role)
        external
        onlyPermissionManager(_app, _role)
    {
        _setPermissionManager(_newManager, _app, _role);
    }

    /**
    * @notice Remove the manager of `_role` in `_app`
    * @param _app Address of the app in which the permission is being unmanaged
    * @param _role Identifier for the group of actions being unmanaged
    */
    function removePermissionManager(address _app, bytes32 _role)
        external
        onlyPermissionManager(_app, _role)
    {
        _setPermissionManager(address(0), _app, _role);
    }

    /**
    * @notice Burn non-existent `_role` in `_app`, so no modification can be made to it (grant, revoke, permission manager)
    * @param _app Address of the app in which the permission is being burned
    * @param _role Identifier for the group of actions being burned
    */
    function createBurnedPermission(address _app, bytes32 _role)
        external
        auth(CREATE_PERMISSIONS_ROLE)
        noPermissionManager(_app, _role)
    {
        _setPermissionManager(BURN_ENTITY, _app, _role);
    }

    /**
    * @notice Burn `_role` in `_app`, so no modification can be made to it (grant, revoke, permission manager)
    * @param _app Address of the app in which the permission is being burned
    * @param _role Identifier for the group of actions being burned
    */
    function burnPermissionManager(address _app, bytes32 _role)
        external
        onlyPermissionManager(_app, _role)
    {
        _setPermissionManager(BURN_ENTITY, _app, _role);
    }

    /**
     * @notice Get parameters for permission array length
     * @param _entity Address of the whitelisted entity that will be able to perform the role
     * @param _app Address of the app
     * @param _role Identifier for a group of actions in app
     * @return Length of the array
     */
    function getPermissionParamsLength(address _entity, address _app, bytes32 _role) external view returns (uint) {
        return permissionParams[permissions[permissionHash(_entity, _app, _role)]].length;
    }

    /**
    * @notice Get parameter for permission
    * @param _entity Address of the whitelisted entity that will be able to perform the role
    * @param _app Address of the app
    * @param _role Identifier for a group of actions in app
    * @param _index Index of parameter in the array
    * @return Parameter (id, op, value)
    */
    function getPermissionParam(address _entity, address _app, bytes32 _role, uint _index)
        external
        view
        returns (uint8, uint8, uint240)
    {
        Param storage param = permissionParams[permissions[permissionHash(_entity, _app, _role)]][_index];
        return (param.id, param.op, param.value);
    }

    /**
    * @dev Get manager for permission
    * @param _app Address of the app
    * @param _role Identifier for a group of actions in app
    * @return address of the manager for the permission
    */
    function getPermissionManager(address _app, bytes32 _role) public view returns (address) {
        return permissionManager[roleHash(_app, _role)];
    }

    /**
    * @dev Function called by apps to check ACL on kernel or to check permission statu
    * @param _who Sender of the original call
    * @param _where Address of the app
    * @param _where Identifier for a group of actions in app
    * @param _how Permission parameters
    * @return boolean indicating whether the ACL allows the role or not
    */
    function hasPermission(address _who, address _where, bytes32 _what, bytes memory _how) public view returns (bool) {
        uint256[] memory how;
        uint256 intsLength = _how.length / 32;
        assembly {
            how := _how // forced casting
            mstore(how, intsLength)
        }
        // _how is invalid from this point fwd
        return hasPermission(_who, _where, _what, how);
    }

    function hasPermission(address _who, address _where, bytes32 _what, uint256[] memory _how) public view returns (bool) {
        bytes32 whoParams = permissions[permissionHash(_who, _where, _what)];
        if (whoParams != NO_PERMISSION && evalParams(whoParams, _who, _where, _what, _how)) {
            return true;
        }

        bytes32 anyParams = permissions[permissionHash(ANY_ENTITY, _where, _what)];
        if (anyParams != NO_PERMISSION && evalParams(anyParams, ANY_ENTITY, _where, _what, _how)) {
            return true;
        }

        return false;
    }

    function hasPermission(address _who, address _where, bytes32 _what) public view returns (bool) {
        uint256[] memory empty = new uint256[](0);
        return hasPermission(_who, _where, _what, empty);
    }

    function evalParams(
        bytes32 _paramsHash,
        address _who,
        address _where,
        bytes32 _what,
        uint256[] _how
    ) public view returns (bool)
    {
        if (_paramsHash == EMPTY_PARAM_HASH) {
            return true;
        }

        return _evalParam(_paramsHash, 0, _who, _where, _what, _how);
    }

    /**
    * @dev Internal createPermission for access inside the kernel (on instantiation)
    */
    function _createPermission(address _entity, address _app, bytes32 _role, address _manager) internal {
        _setPermission(_entity, _app, _role, EMPTY_PARAM_HASH);
        _setPermissionManager(_manager, _app, _role);
    }

    /**
    * @dev Internal function called to actually save the permission
    */
    function _setPermission(address _entity, address _app, bytes32 _role, bytes32 _paramsHash) internal {
        permissions[permissionHash(_entity, _app, _role)] = _paramsHash;
        bool entityHasPermission = _paramsHash != NO_PERMISSION;
        bool permissionHasParams = entityHasPermission && _paramsHash != EMPTY_PARAM_HASH;

        emit SetPermission(_entity, _app, _role, entityHasPermission);
        if (permissionHasParams) {
            emit SetPermissionParams(_entity, _app, _role, _paramsHash);
        }
    }

    function _saveParams(uint256[] _encodedParams) internal returns (bytes32) {
        bytes32 paramHash = keccak256(abi.encodePacked(_encodedParams));
        Param[] storage params = permissionParams[paramHash];

        if (params.length == 0) { // params not saved before
            for (uint256 i = 0; i < _encodedParams.length; i++) {
                uint256 encodedParam = _encodedParams[i];
                Param memory param = Param(decodeParamId(encodedParam), decodeParamOp(encodedParam), uint240(encodedParam));
                params.push(param);
            }
        }

        return paramHash;
    }

    function _evalParam(
        bytes32 _paramsHash,
        uint32 _paramId,
        address _who,
        address _where,
        bytes32 _what,
        uint256[] _how
    ) internal view returns (bool)
    {
        if (_paramId >= permissionParams[_paramsHash].length) {
            return false; // out of bounds
        }

        Param memory param = permissionParams[_paramsHash][_paramId];

        if (param.id == LOGIC_OP_PARAM_ID) {
            return _evalLogic(param, _paramsHash, _who, _where, _what, _how);
        }

        uint256 value;
        uint256 comparedTo = uint256(param.value);

        // get value
        if (param.id == ORACLE_PARAM_ID) {
            value = checkOracle(IACLOracle(param.value), _who, _where, _what, _how) ? 1 : 0;
            comparedTo = 1;
        } else if (param.id == BLOCK_NUMBER_PARAM_ID) {
            value = getBlockNumber();
        } else if (param.id == TIMESTAMP_PARAM_ID) {
            value = getTimestamp();
        } else if (param.id == PARAM_VALUE_PARAM_ID) {
            value = uint256(param.value);
        } else {
            if (param.id >= _how.length) {
                return false;
            }
            value = uint256(uint240(_how[param.id])); // force lost precision
        }

        if (Op(param.op) == Op.RET) {
            return uint256(value) > 0;
        }

        return compare(value, Op(param.op), comparedTo);
    }

    function _evalLogic(Param _param, bytes32 _paramsHash, address _who, address _where, bytes32 _what, uint256[] _how)
        internal
        view
        returns (bool)
    {
        if (Op(_param.op) == Op.IF_ELSE) {
            uint32 conditionParam;
            uint32 successParam;
            uint32 failureParam;

            (conditionParam, successParam, failureParam) = decodeParamsList(uint256(_param.value));
            bool result = _evalParam(_paramsHash, conditionParam, _who, _where, _what, _how);

            return _evalParam(_paramsHash, result ? successParam : failureParam, _who, _where, _what, _how);
        }

        uint32 param1;
        uint32 param2;

        (param1, param2,) = decodeParamsList(uint256(_param.value));
        bool r1 = _evalParam(_paramsHash, param1, _who, _where, _what, _how);

        if (Op(_param.op) == Op.NOT) {
            return !r1;
        }

        if (r1 && Op(_param.op) == Op.OR) {
            return true;
        }

        if (!r1 && Op(_param.op) == Op.AND) {
            return false;
        }

        bool r2 = _evalParam(_paramsHash, param2, _who, _where, _what, _how);

        if (Op(_param.op) == Op.XOR) {
            return r1 != r2;
        }

        return r2; // both or and and depend on result of r2 after checks
    }

    function compare(uint256 _a, Op _op, uint256 _b) internal pure returns (bool) {
        if (_op == Op.EQ)  return _a == _b;                              // solium-disable-line lbrace
        if (_op == Op.NEQ) return _a != _b;                              // solium-disable-line lbrace
        if (_op == Op.GT)  return _a > _b;                               // solium-disable-line lbrace
        if (_op == Op.LT)  return _a < _b;                               // solium-disable-line lbrace
        if (_op == Op.GTE) return _a >= _b;                              // solium-disable-line lbrace
        if (_op == Op.LTE) return _a <= _b;                              // solium-disable-line lbrace
        return false;
    }

    function checkOracle(IACLOracle _oracleAddr, address _who, address _where, bytes32 _what, uint256[] _how) internal view returns (bool) {
        bytes4 sig = _oracleAddr.canPerform.selector;

        // a raw call is required so we can return false if the call reverts, rather than reverting
        bytes memory checkCalldata = abi.encodeWithSelector(sig, _who, _where, _what, _how);
        uint256 oracleCheckGas = ORACLE_CHECK_GAS;

        bool ok;
        assembly {
            ok := staticcall(oracleCheckGas, _oracleAddr, add(checkCalldata, 0x20), mload(checkCalldata), 0, 0)
        }

        if (!ok) {
            return false;
        }

        uint256 size;
        assembly { size := returndatasize }
        if (size != 32) {
            return false;
        }

        bool result;
        assembly {
            let ptr := mload(0x40)       // get next free memory ptr
            returndatacopy(ptr, 0, size) // copy return from above `staticcall`
            result := mload(ptr)         // read data at ptr and set it to result
            mstore(ptr, 0)               // set pointer memory to 0 so it still is the next free ptr
        }

        return result;
    }

    /**
    * @dev Internal function that sets management
    */
    function _setPermissionManager(address _newManager, address _app, bytes32 _role) internal {
        permissionManager[roleHash(_app, _role)] = _newManager;
        emit ChangePermissionManager(_app, _role, _newManager);
    }

    function roleHash(address _where, bytes32 _what) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("ROLE", _where, _what));
    }

    function permissionHash(address _who, address _where, bytes32 _what) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("PERMISSION", _who, _where, _what));
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/test/helpers/Assert.sol

// Taken from https://github.com/trufflesuite/truffle/blob/ef03be9e35909e5e7c97a9ecb07ccae4872645ca/packages/truffle-core/lib/testing/Assert.sol

pragma solidity ^0.4.18;

/*
    File: Assertions.slb
    Author: Andreas Olofsson (androlo1980@gmail.com)
    Library: Assertions
    Assertions for unit testing contracts. Tests are run with the
    <solUnit at https://github.com/smartcontractproduction/sol-unit>
    unit-testing framework.
    (start code)
    contract ModAdder {
        function addMod(uint a, uint b, uint modulus) constant returns (uint sum) {
            if (modulus == 0)
                throw;
            return addmod(a, b, modulus);
        }
    }
    contract SomeTest {
        using Assertions for uint;
        function testAdd() {
            var adder = new ModAdder();
            adder.addMod(50, 66, 30).equal(26, "addition returned the wrong sum");
        }
    }
    (end)
    It is also possible to extend <Test>, to have all bindings (using) properly set up.
    (start code)
    contract SomeTest is Test {
        function testAdd() {
            var adder = new ModAdder();
            adder.addMod(50, 66, 30).equal(26, "addition returned the wrong sum");
        }
    }
    (end)
*/
library Assert {

    // Constant: ADDRESS_NULL
    // The null address: 0
    address constant ADDRESS_NULL = 0x0000000000000000000000000000000000000000;
    // Constant: BYTES32_NULL
    // The null bytes32: 0
    bytes32 constant BYTES32_NULL = 0x0;
    // Constant: STRING_NULL
    // The null string: ""
    string constant STRING_NULL = "";

    uint8 constant ZERO = uint8(byte('0'));
    uint8 constant A = uint8(byte('a'));

    byte constant MINUS = byte('-');

    /*
        Event: TestEvent
        Fired when an assertion is made.
        Params:
            result (bool) - Whether or not the assertion holds.
            message (string) - A message to display if the assertion does not hold.
    */
    event TestEvent(bool indexed result, string message);

    // ************************************** general **************************************

    /*
        Function: fail()
        Mark the test as failed.
        Params:
            message (string) - A message associated with the failure.
        Returns:
            result (bool) - false.
    */
    function fail(string message) public returns (bool result) {
        _report(false, message);
        return false;
    }

    // ************************************** strings **************************************

    /*
        Function: equal(string)
        Assert that two strings are equal.
        : _stringsEqual(A, B) == true
        Params:
            A (string) - The first string.
            B (string) - The second string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(string a, string b, string message) public returns (bool result) {
        result = _stringsEqual(a, b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: notEqual(string)
        Assert that two strings are not equal.
        : _stringsEqual(A, B) == false
        Params:
            A (string) - The first string.
            B (string) - The second string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(string a, string b, string message) public returns (bool result) {
        result = !_stringsEqual(a, b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isEmpty(string)
        Assert that a string is empty.
        : _stringsEqual(str, STRING_NULL) == true
        Params:
            str (string) - The string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isEmpty(string str, string message) public returns (bool result) {
        result = _stringsEqual(str, STRING_NULL);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(str, "Tested"), message));
    }

    /*
        Function: isNotEmpty(string)
        Assert that a string is not empty.
        : _stringsEqual(str, STRING_NULL) == false
        Params:
            str (string) - The string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isNotEmpty(string str, string message) public returns (bool result) {
        result = !_stringsEqual(str, STRING_NULL);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(str, "Tested"), message));
    }

    // ************************************** bytes32 **************************************

    /*
        Function: equal(bytes32)
        Assert that two 'bytes32' are equal.
        : A == B
        Params:
            A (bytes32) - The first 'bytes32'.
            B (bytes32) - The second 'bytes32'.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(bytes32 a, bytes32 b, string message) public returns (bool result) {
        result = (a == b);
        _report(result, message);
    }

    /*
        Function: notEqual(bytes32)
        Assert that two 'bytes32' are not equal.
        : A != B
        Params:
            A (bytes32) - The first 'bytes32'.
            B (bytes32) - The second 'bytes32'.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(bytes32 a, bytes32 b, string message) public returns (bool result) {
        result = (a != b);
        _report(result, message);
    }

    /*
        Function: isZero(bytes32)
        Assert that a 'bytes32' is zero.
        : bts == BYTES32_NULL
        Params:
            bts (bytes32) - The 'bytes32'.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isZero(bytes32 bts, string message) public returns (bool result) {
        result = (bts == BYTES32_NULL);
        _report(result, message);
    }

    /*
        Function: isNotZero(bytes32)
        Assert that a 'bytes32' is not zero.
        : bts != BYTES32_NULL
        Params:
            bts (bytes32) - The 'bytes32'.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isNotZero(bytes32 bts, string message) public returns (bool result) {
        result = (bts != BYTES32_NULL);
        _report(result, message);
    }

    // ************************************** address **************************************

    /*
        Function: equal(address)
        Assert that two addresses are equal.
        : A == B
        Params:
            A (address) - The first address.
            B (address) - The second address.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(address a, address b, string message) public returns (bool result) {
        result = (a == b);
        _report(result, message);
    }
    /*
        Function: notEqual(address)
        Assert that two addresses are not equal.
        : A != B
        Params:
            A (address) - The first address.
            B (address) - The second address.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(address a, address b, string message) public returns (bool result) {
        result = (a != b);
         _report(result, message);
    }

    /*
        Function: isZero(address)
        Assert that an address is zero.
        : addr == ADDRESS_NULL
        Params:
            addr (address) - The address.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isZero(address addr, string message) public returns (bool result) {
        result = (addr == ADDRESS_NULL);
        _report(result, message);
    }

    /*
        Function: isNotZero(address)
        Assert that an address is not zero.
        : addr != ADDRESS_NULL
        Params:
            addr (address) - The address.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isNotZero(address addr, string message) public returns (bool result) {
        result = (addr != ADDRESS_NULL);
        _report(result, message);
    }

    // ************************************** bool **************************************

    /*
        Function: isTrue
        Assert that a boolean is 'true'.
        : b == true
        Params:
            b (bool) - The boolean.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isTrue(bool b, string message) public returns (bool result) {
        result = b;
        _report(result, message);
    }

    /*
        Function: isFalse
        Assert that a boolean is 'false'.
        : b == false
        Params:
            b (bool) - The boolean.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isFalse(bool b, string message) public returns (bool result) {
        result = !b;
        _report(result, message);
    }

    /*
        Function: equal(bool)
        Assert that two booleans are equal.
        : A == B
        Params:
            A (bool) - The first boolean.
            B (bool) - The second boolean.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(bool a, bool b, string message) public returns (bool result) {
        result = (a == b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: notEqual(bool)
        Assert that two booleans are not equal.
        : A != B
        Params:
            A (bool) - The first boolean.
            B (bool) - The second boolean.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(bool a, bool b, string message) public returns (bool result) {
        result = (a != b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    // ************************************** uint **************************************

    /*
        Function: equal(uint)
        Assert that two (256 bit) unsigned integers are equal.
        : A == B
        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(uint a, uint b, string message) public returns (bool result) {
        result = (a == b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: notEqual(uint)
        Assert that two (256 bit) unsigned integers are not equal.
        : A != B
        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(uint a, uint b, string message) public returns (bool result) {
        result = (a != b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isAbove(uint)
        Assert that the uint 'A' is greater than the uint 'B'.
        : A > B
        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isAbove(uint a, uint b, string message) public returns (bool result) {
        result = (a > b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isAtLeast(uint)
        Assert that the uint 'A' is greater than or equal to the uint 'B'.
        : A >= B
        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isAtLeast(uint a, uint b, string message) public returns (bool result) {
        result = (a >= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isBelow(uint)
        Assert that the uint 'A' is lesser than the uint 'B'.
        : A < B
        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isBelow(uint a, uint b, string message) public returns (bool result) {
        result = (a < b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isAtMost(uint)
        Assert that the uint 'A' is lesser than or equal to the uint 'B'.
        : A <= B
        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isAtMost(uint a, uint b, string message) public returns (bool result) {
        result = (a <= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isZero(uint)
        Assert that a (256 bit) unsigned integer is 0.
        : number == 0
        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isZero(uint number, string message) public returns (bool result) {
        result = (number == 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    /*
        Function: isNotZero(uint)
        Assert that a (256 bit) unsigned integer is not 0.
        : number != 0
        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isNotZero(uint number, string message) public returns (bool result) {
        result = (number != 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    // ************************************** int **************************************

    /*
        Function: equal(int)
        Assert that two (256 bit) signed integers are equal.
        : A == B
        Params:
            A (int) - The first int.
            B (int) - The second int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(int a, int b, string message) public returns (bool result) {
        result = (a == b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: notEqual(int)
        Assert that two (256 bit) signed integers are not equal.
        : A != B
        Params:
            A (int) - The first int.
            B (int) - The second int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(int a, int b, string message) public returns (bool result) {
        result = (a != b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isAbove(int)
        Assert that the int 'A' is greater than the int 'B'.
        : A > B
        Params:
            A (int) - The first int.
            B (int) - The second int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isAbove(int a, int b, string message) public returns (bool result) {
        result = (a > b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isAtLeast(int)
        Assert that the int 'A' is greater than or equal to the int 'B'.
        : A >= B
        Params:
            A (int) - The first int.
            B (int) - The second int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isAtLeast(int a, int b, string message) public returns (bool result) {
        result = (a >= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isBelow(int)
        Assert that the int 'A' is lesser than the int 'B'.
        : A < B
        Params:
            A (int) - The first int.
            B (int) - The second int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isBelow(int a, int b, string message) public returns (bool result) {
        result = (a < b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isAtMost(int)
        Assert that the int 'A' is lesser than or equal to the int 'B'.
        : A <= B
        Params:
            A (int) - The first int.
            B (int) - The second int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isAtMost(int a, int b, string message) public returns (bool result) {
        result = (a <= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    /*
        Function: isZero(int)
        Assert that a (256 bit) signed integer is 0.
        : number == 0
        Params:
            number (int) - The int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isZero(int number, string message) public returns (bool result) {
        result = (number == 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    /*
        Function: isNotZero(int)
        Assert that a (256 bit) signed integer is not 0.
        : number != 0
        Params:
            number (int) - The int.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function isNotZero(int number, string message) public returns (bool result) {
        result = (number != 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    // ************************************** uint[] **************************************

    /*
        Function: equal(uint[])
        Assert that two 'uint[ ]' are equal.
        : arrA.length == arrB.length
        and, for all valid indices 'i'
        : arrA[i] == arrB[i]
        Params:
            A (uint[]) - The first array.
            B (uint[]) - The second array.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(uint[] arrA, uint[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    /*
        Function: notEqual(uint[])
        Assert that two 'uint[]' are not equal.
        : arrA.length != arrB.length
        or, for some valid index 'i'
        : arrA[i] != arrB[i]
        Params:
            A (uint[]) - The first string.
            B (uint[]) - The second string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(uint[] arrA, uint[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    /*
        Function: lengthEqual(uint[])
        Assert that the length of a 'uint[]' is equal to a given value.
        : arr.length == length
        Params:
            arr (uint[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthEqual(uint[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    /*
        Function: lengthNotEqual(uint[])
        Assert that the length of a 'uint[]' is not equal to a given value.
        : arr.length != length
        Params:
            arr (uint[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthNotEqual(uint[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    // ************************************** int[] **************************************

    /*
        Function: equal(int[])
        Assert that two 'int[]' are equal.
        : arrA.length == arrB.length
        and, for all valid indices 'i'
        : arrA[i] == arrB[i]
        Params:
            A (int[]) - The first array.
            B (int[]) - The second array.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(int[] arrA, int[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    /*
        Function: notEqual(int[])
        Assert that two 'int[]' are not equal.
        : arrA.length != arrB.length
        or, for some valid index 'i'
        : arrA[i] != arrB[i]
        Params:
            A (int[]) - The first string.
            B (int[]) - The second string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(int[] arrA, int[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    /*
        Function: lengthEqual(int[])
        Assert that the length of an 'int[]' is equal to a given value.
        : arr.length == length
        Params:
            arr (int[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthEqual(int[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    /*
        Function: lengthNotEqual(int[])
        Assert that the length of an 'int[]' is not equal to a given value.
        : arr.length != length
        Params:
            arr (int[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthNotEqual(int[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    // ************************************** address[] **************************************

    /*
        Function: equal(address[])
        Assert that two 'address[]' are equal.
        : arrA.length == arrB.length
        and, for all valid indices 'i'
        : arrA[i] == arrB[i]
        Params:
            A (address[]) - The first array.
            B (address[]) - The second array.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(address[] arrA, address[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    /*
        Function: notEqual(address[])
        Assert that two 'address[]' are not equal.
        : arrA.length != arrB.length
        or, for some valid index 'i'
        : arrA[i] != arrB[i]
        Params:
            A (address[]) - The first string.
            B (address[]) - The second string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(address[] arrA, address[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    /*
        Function: lengthEqual(address[])
        Assert that the length of an 'address[]' is equal to a given value.
        : arr.length == length
        Params:
            arr (address[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthEqual(address[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    /*
        Function: lengthNotEqual(address[])
        Assert that the length of an 'address[]' is not equal to a given value.
        : arr.length != length
        Params:
            arr (address[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthNotEqual(address[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    // ************************************** bytes32[] **************************************

    /*
        Function: equal(bytes32[])
        Assert that two 'bytes32[]' are equal.
        : arrA.length == arrB.length
        and, for all valid indices 'i'
        : arrA[i] == arrB[i]
        Params:
            A (bytes32[]) - The first array.
            B (bytes32[]) - The second array.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function equal(bytes32[] arrA, bytes32[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    /*
        Function: notEqual(bytes32[])
        Assert that two 'bytes32[]' are not equal.
        : arrA.length != arrB.length
        or, for some valid index 'i'
        : arrA[i] != arrB[i]
        Params:
            A (bytes32[]) - The first string.
            B (bytes32[]) - The second string.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function notEqual(bytes32[] arrA, bytes32[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    /*
        Function: lengthEqual(bytes32[])
        Assert that the length of an 'bytes32[]' is equal to a given value.
        : arr.length == length
        Params:
            arr (bytes32[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthEqual(bytes32[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    /*
        Function: lengthNotEqual(bytes32[])
        Assert that the length of an 'bytes32[]' is not equal to a given value.
        : arr.length != length
        Params:
            arr (bytes32[]) - The array.
            length (uint) - The length.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function lengthNotEqual(bytes32[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    // ************************************** balances **************************************

    /*
        Function: balanceEqual
        Assert that the balance of an account 'A' is equal to a given number 'b'.
        : A.balance = b
        Params:
            A (address) - The first address.
            b (uint) - The balance.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function balanceEqual(address a, uint b, string message) public returns (bool result) {
        result = (a.balance == b);
        _report(result, message);
    }

    /*
        Function: balanceNotEqual
        Assert that the balance of an account 'A' is not equal to a given number 'b'.
        : A.balance != b
        Params:
            A (address) - The first address.
            b (uint) - The balance.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function balanceNotEqual(address a, uint b, string message) public returns (bool result) {
        result = (a.balance != b);
        _report(result, message);
    }

    /*
        Function: balanceIsZero
        Assert that the balance of an account 'A' is zero.
        : A.balance == 0
        Params:
            A (address) - The first address.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function balanceIsZero(address a, string message) public returns (bool result) {
        result = (a.balance == 0);
        _report(result, message);
    }

    /*
        Function: balanceIsNotZero
        Assert that the balance of an account 'A' is not zero.
        : A.balance != 0
        Params:
            A (address) - The first address.
            message (string) - A message that is sent if the assertion fails.
        Returns:
            result (bool) - The result.
    */
    function balanceIsNotZero(address a, string message) public returns (bool result) {
        result = (a.balance != 0);
        _report(result, message);
    }

    /******************************** internal ********************************/

        /*
            Function: _report
            Internal function for triggering <TestEvent>.
            Params:
                result (bool) - The test result (true or false).
                message (string) - The message that is sent if the assertion fails.
        */
    function _report(bool result, string message) internal {
        if(result)
            emit TestEvent(true, "");
        else
            emit TestEvent(false, message);
    }

    /*
        Function: _stringsEqual
        Compares two strings. Taken from the StringUtils contract in the Ethereum Dapp-bin
        (https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol).
        Params:
            a (string) - The first string.
            b (string) - The second string.
        Returns:
             result (bool) - 'true' if the strings are equal, otherwise 'false'.
    */
    function _stringsEqual(string a, string b) internal pure returns (bool result) {
        bytes memory ba = bytes(a);
        bytes memory bb = bytes(b);

        if (ba.length != bb.length)
            return false;
        for (uint i = 0; i < ba.length; i ++) {
            if (ba[i] != bb[i])
                return false;
        }
        return true;
    }

    /*
        Function: _itoa
        Convert a signed integer to a string. Negative numbers gets a '-' in front, e.g. "-54".
        Params:
            n (int) - The integer.
            radix (uint8) - A number between 2 and 16 (inclusive). Characters used are 0-9,a-f
        Returns:
            result (string) - The resulting string.
    */
    function _itoa(int n, uint8 radix) internal pure returns (string) {
        if (n == 0 || radix < 2 || radix > 16)
            return '0';
        bytes memory bts = new bytes(256);
        uint i;
        bool neg = false;
        if (n < 0) {
            n = -n;
            neg = true;
        }
        while (n > 0) {
            bts[i++] = _utoa(uint8(n % radix)); // Turn it to ascii.
            n /= radix;
        }
        // Reverse
        uint size = i;
        uint j = 0;
        bytes memory rev;
        if (neg) {
            size++;
            j = 1;
            rev = new bytes(size);
            rev[0] = MINUS;
        }
        else
            rev = new bytes(size);

        for (; j < size; j++)
            rev[j] = bts[size - j - 1];
        return string(rev);
    }

    /*
        Function: _utoa(uint)
        Convert an  unsigned integer to a string.
        Params:
            n (uint) - The unsigned integer.
            radix (uint8) - A number between 2 and 16 (inclusive). Characters used are 0-9,a-f
        Returns:
            result (string) - The resulting string.
    */
    function _utoa(uint n, uint8 radix) internal pure returns (string) {
        if (n == 0 || radix < 2 || radix > 16)
            return '0';
        bytes memory bts = new bytes(256);
        uint i;
        while (n > 0) {
            bts[i++] = _utoa(uint8(n % radix)); // Turn it to ascii.
            n /= radix;
        }
        // Reverse
        bytes memory rev = new bytes(i);
        for (uint j = 0; j < i; j++)
            rev[j] = bts[i - j - 1];
        return string(rev);
    }

    /*
        Function: _utoa(uint8)
        Convert an unsigned 8-bit integer to its ASCII byte representation. Numbers 0-9 are converted to '0'-'9',
        numbers 10-16 to 'a'-'f'. Numbers larger then 16 return the null byte.
        Params:
            u (uint8) - The unsigned 8-bit integer.
        Returns:
            result (string) - The ASCII byte.
    */
    function _utoa(uint8 u) internal pure returns (byte) {
        if (u < 10)
            return byte(u + ZERO);
        else if (u < 16)
            return byte(u - 10 + A);
        else
            return 0;
    }

    /*
        Function: _ltoa
        Convert an boolean to a string.
        Params:
            val (bool) - The boolean.
        Returns:
            result (string) - "true" if true, "false" if false.
    */
    function _ltoa(bool val) internal pure returns (string) {
        bytes memory b;
        if (val) {
            b = new bytes(4);
            b[0] = 't';
            b[1] = 'r';
            b[2] = 'u';
            b[3] = 'e';
            return string(b);
        }
        else {
            b = new bytes(5);
            b[0] = 'f';
            b[1] = 'a';
            b[2] = 'l';
            b[3] = 's';
            b[4] = 'e';
            return string(b);
        }
    }

    /*
    function htoa(address addr) constant returns (string) {
        bytes memory bts = new bytes(40);
        bytes20 addrBts = bytes20(addr);
        for (uint i = 0; i < 20; i++) {
            bts[2*i] = addrBts[i] % 16;
            bts[2*i + 1] = (addrBts[i] / 16) % 16;
        }
        return string(bts);
    }
    */

    /*
        Function: _tag(string)
        Add a tag to a string. The 'value' and 'tag' strings are returned on the form "tag: value".
        Params:
            value (string) - The value.
            tag (string) - The tag.
        Returns:
            result (string) - "tag: value"
    */
    function _tag(string value, string tag) internal pure returns (string) {

        bytes memory valueB = bytes(value);
        bytes memory tagB = bytes(tag);

        uint vl = valueB.length;
        uint tl = tagB.length;

        bytes memory newB = new bytes(vl + tl + 2);

        uint i;
        uint j;

        for (i = 0; i < tl; i++)
            newB[j++] = tagB[i];
        newB[j++] = ':';
        newB[j++] = ' ';
        for (i = 0; i < vl; i++)
            newB[j++] = valueB[i];

        return string(newB);
    }

    /*
        Function: _tag(int)
        Add a tag to an int.
        Params:
            value (int) - The value.
            tag (string) - The tag.
        Returns:
            result (string) - "tag: _itoa(value)"
    */
    function _tag(int value, string tag) internal pure returns (string) {
        string memory nstr = _itoa(value, 10);
        return _tag(nstr, tag);
    }

    /*
        Function: _tag(uint)
        Add a tag to an uint.
        Params:
            value (uint) - The value.
            tag (string) - The tag.
        Returns:
            result (string) - "tag: _utoa(value)"
    */
    function _tag(uint value, string tag) internal pure returns (string) {
        string memory nstr = _utoa(value, 10);
        return _tag(nstr, tag);
    }

    /*
        Function: _tag(bool)
        Add a tag to a boolean.
        Params:
            value (bool) - The value.
            tag (string) - The tag.
        Returns:
            result (string) - "tag: _ltoa(value)"
    */
    function _tag(bool value, string tag) internal pure returns (string) {
        string memory nstr = _ltoa(value);
        return _tag(nstr, tag);
    }

    /*
        Function: _appendTagged(string)
        Append a tagged value to a string.
        Params:
            tagged (string) - The tagged value.
            str (string) - The string.
        Returns:
            result (string) - "str (tagged)"
    */
    function _appendTagged(string tagged, string str) internal pure returns (string) {

        bytes memory taggedB = bytes(tagged);
        bytes memory strB = bytes(str);

        uint sl = strB.length;
        uint tl = taggedB.length;

        bytes memory newB = new bytes(sl + tl + 3);

        uint i;
        uint j;

        for (i = 0; i < sl; i++)
            newB[j++] = strB[i];
        newB[j++] = ' ';
        newB[j++] = '(';
        for (i = 0; i < tl; i++)
            newB[j++] = taggedB[i];
        newB[j++] = ')';

        return string(newB);
    }

    /*
        Function: _appendTagged(string, string)
        Append two tagged values to a string.
        Params:
            tagged0 (string) - The first tagged value.
            tagged1 (string) - The second tagged value.
            str (string) - The string.
        Returns:
            result (string) - "str (tagged0, tagged1)"
    */
    function _appendTagged(string tagged0, string tagged1, string str) internal pure returns (string) {

        bytes memory tagged0B = bytes(tagged0);
        bytes memory tagged1B = bytes(tagged1);
        bytes memory strB = bytes(str);

        uint sl = strB.length;
        uint t0l = tagged0B.length;
        uint t1l = tagged1B.length;

        bytes memory newB = new bytes(sl + t0l + t1l + 5);

        uint i;
        uint j;

        for (i = 0; i < sl; i++)
            newB[j++] = strB[i];
        newB[j++] = ' ';
        newB[j++] = '(';
        for (i = 0; i < t0l; i++)
            newB[j++] = tagged0B[i];
        newB[j++] = ',';
        newB[j++] = ' ';
        for (i = 0; i < t1l; i++)
            newB[j++] = tagged1B[i];
        newB[j++] = ')';

        return string(newB);
    }

}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/test/helpers/ACLHelper.sol

pragma solidity 0.4.24;

contract ACLHelper {
    function encodeOperator(uint256 param1, uint256 param2) internal pure returns (uint240) {
        return encodeIfElse(param1, param2, 0);
    }

    function encodeIfElse(uint256 condition, uint256 successParam, uint256 failureParam) internal pure returns (uint240) {
        return uint240(condition + (successParam << 32) + (failureParam << 64));
    }
}


contract AcceptOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        return true;
    }
}


contract RejectOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        return false;
    }
}


contract RevertOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        revert();
    }
}

// Can't implement from IACLOracle as its canPerform() is marked as view-only
contract StateModifyingOracle /* is IACLOracle */ {
    bool modifyState;

    function canPerform(address, address, bytes32, uint256[]) external returns (bool) {
        modifyState = true;
        return true;
    }
}

contract EmptyDataReturnOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        assembly {
            return(0, 0)
        }
    }
}

contract ConditionalOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[] how) external view returns (bool) {
        return how[0] > 0;
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/test/TestACLInterpreter.sol

pragma solidity 0.4.24;



contract TestACLInterpreter is ACL, ACLHelper {
    function testEqualityUint() public {
        // Assert param 0 is equal to 10, given that params are [10, 11]
        assertEval(arr(uint256(10), 11), 0, Op.EQ, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.EQ, 10, false);
        assertEval(arr(uint256(10), 11), 1, Op.EQ, 11, true);
    }

    function testEqualityAddr() public {
        assertEval(arr(msg.sender), 0, Op.EQ, uint256(msg.sender), true);
        assertEval(arr(msg.sender), 0, Op.EQ, uint256(this), false);
    }

    function testEqualityBytes() public {
        assertEval(arr(keccak256("hi")), 0, Op.EQ, uint256(keccak256("hi")), true);
        assertEval(arr(keccak256("hi")), 0, Op.EQ, uint256(keccak256("bye")), false);
    }

    function testInequalityUint() public {
        assertEval(arr(uint256(10), 11), 0, Op.NEQ, 10, false);
        assertEval(arr(uint256(10), 11), 1, Op.NEQ, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.NEQ, 11, false);
    }

    function testInequalityBytes() public {
        assertEval(arr(keccak256("hi")), 0, Op.NEQ, uint256(keccak256("hi")), false);
        assertEval(arr(keccak256("hi")), 0, Op.NEQ, uint256(keccak256("bye")), true);
    }

    function testInequalityAddr() public {
        assertEval(arr(msg.sender), 0, Op.NEQ, uint256(msg.sender), false);
        assertEval(arr(msg.sender), 0, Op.NEQ, uint256(this), true);
    }

    function testGreatherThan() public {
        assertEval(arr(uint256(10), 11), 0, Op.GT, 9, true);
        assertEval(arr(uint256(10), 11), 0, Op.GT, 10, false);
        assertEval(arr(uint256(10), 11), 1, Op.GT, 10, true);
    }

    function testLessThan() public {
        assertEval(arr(uint256(10), 11), 0, Op.LT, 9, false);
        assertEval(arr(uint256(9), 11), 0, Op.LT, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.LT, 10, false);
    }

    function testGreatherThanOrEqual() public {
        assertEval(arr(uint256(10), 11), 0, Op.GTE, 9, true);
        assertEval(arr(uint256(10), 11), 0, Op.GTE, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.GTE, 12, false);
    }

    function testLessThanOrEqual() public {
        assertEval(arr(uint256(10), 11), 0, Op.LTE, 9, false);
        assertEval(arr(uint256(9), 11), 0, Op.LTE, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.LTE, 11, true);
    }

    function testTimestamp() public {
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.EQ, uint256(block.timestamp), true);
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.EQ, uint256(1), false);
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.GT, uint256(1), true);
    }

    function testBlockNumber() public {
        assertEval(arr(), BLOCK_NUMBER_PARAM_ID, Op.EQ, uint256(block.number), true);
        assertEval(arr(), BLOCK_NUMBER_PARAM_ID, Op.EQ, uint256(1), false);
        assertEval(arr(), BLOCK_NUMBER_PARAM_ID, Op.GT, uint256(block.number - 1), true);
    }

    function testOracle() public {
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new AcceptOracle()), true);
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new RejectOracle()), false);
        assertEval(arr(), ORACLE_PARAM_ID, Op.NEQ, uint256(new RejectOracle()), true);

        // doesn't revert even if oracle reverts
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new RevertOracle()), false);
        // the staticcall will error as the oracle tries to modify state, so a no is returned
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new StateModifyingOracle()), false);
        // if returned data size is not correct, returns false
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new EmptyDataReturnOracle()), false);

        // conditional oracle returns true if first param > 0
        ConditionalOracle conditionalOracle = new ConditionalOracle();

        assertEval(arr(uint256(1)), ORACLE_PARAM_ID, Op.EQ, uint256(conditionalOracle), true);
        assertEval(arr(uint256(0), uint256(1)), ORACLE_PARAM_ID, Op.EQ, uint256(conditionalOracle), false);
    }

    function testReturn() public {
        assertEval(arr(), PARAM_VALUE_PARAM_ID, Op.RET, uint256(1), true);
        assertEval(arr(), PARAM_VALUE_PARAM_ID, Op.RET, uint256(0), false);
        assertEval(arr(), PARAM_VALUE_PARAM_ID, Op.RET, uint256(100), true);
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.RET, uint256(0), true);
    }

    function testNot() public {
        Param memory retTrue = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        Param memory retFalse = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        Param memory notOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.NOT), encodeOperator(1, 0));
        Param[] memory params = new Param[](2);

        // !true == false
        params[0] = notOp;
        params[1] = retTrue;
        assertEval(params, false);

        // !false == true
        params[1] = retFalse;
        assertEval(params, true);
    }

    function testComplexCombination() public {
        // if (oracle and block number > block number - 1) then arg 0 < 10 or oracle else false
        Param[] memory params = new Param[](7);
        params[0] = Param(LOGIC_OP_PARAM_ID, uint8(Op.IF_ELSE), encodeIfElse(1, 4, 6));
        params[1] = Param(LOGIC_OP_PARAM_ID, uint8(Op.AND), encodeOperator(2, 3));
        params[2] = Param(ORACLE_PARAM_ID, uint8(Op.EQ), uint240(new AcceptOracle()));
        params[3] = Param(BLOCK_NUMBER_PARAM_ID, uint8(Op.GT), uint240(block.number - 1));
        params[4] = Param(LOGIC_OP_PARAM_ID, uint8(Op.OR), encodeOperator(5, 2));
        params[5] = Param(0, uint8(Op.LT), uint240(10));
        params[6] = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        assertEval(params, arr(uint256(10)), true);

        params[4] = Param(LOGIC_OP_PARAM_ID, uint8(Op.AND), encodeOperator(5, 2));
        assertEval(params, arr(uint256(10)), false);
    }

    function testParamOutOfBoundsFail() public {
        Param[] memory params = new Param[](2);

        params[1] = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        assertEval(params, arr(uint256(10)), false);

        params[0] = Param(LOGIC_OP_PARAM_ID, uint8(Op.IF_ELSE), encodeIfElse(2, 2, 2));
        assertEval(params, arr(uint256(10)), false);
    }

    function testArgOutOfBoundsFail() public {
        assertEval(arr(uint256(10), 11), 3, Op.EQ, 10, false);
    }

    function testIfElse() public {
        Param memory retTrue = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        Param memory retFalse = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        // If 1 then 2 else 3
        Param memory ifOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.IF_ELSE), encodeIfElse(1, 2, 3));
        Param[] memory params = new Param[](4);

        // true ? true : false == true
        params[0] = ifOp;
        params[1] = retTrue;
        params[2] = retTrue;
        params[3] = retFalse;
        assertEval(params, true);

        // false ? true : false == false
        params[1] = retFalse;
        assertEval(params, false);
    }

    function testCombinators() public {
        Param memory retTrue = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        Param memory retFalse = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        // OR param at index 1 or param 2
        Param memory orOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.OR), encodeOperator(1, 2));
        Param memory andOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.AND), encodeOperator(1, 2));
        Param memory xorOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.XOR), encodeOperator(1, 2));

        Param[] memory params = new Param[](3);

        // or true true == true
        params[0] = orOp;
        params[1] = retTrue;
        params[2] = retTrue;
        assertEval(params, true);

        // or false true == true
        params[1] = retFalse;
        assertEval(params, true);

        // or true false == true
        params[1] = retTrue;
        params[2] = retFalse;
        assertEval(params, true);

        // or false false == false
        params[1] = retFalse;
        assertEval(params, false);

        // and false false == false
        params[0] = andOp;
        assertEval(params, false);

        // and true false == false
        params[1] = retTrue;
        assertEval(params, false);

        // and false true == false
        params[1] = retFalse;
        params[2] = retTrue;
        assertEval(params, false);

        // and true true == true
        params[1] = retTrue;
        params[2] = retTrue;
        assertEval(params, true);

        // xor true true == false
        params[0] = xorOp;
        assertEval(params, false);

        // xor false true == true
        params[1] = retFalse;
        assertEval(params, true);

        // xor true false == true
        params[1] = retTrue;
        params[2] = retFalse;
        assertEval(params, true);

        // xor false false == false
        params[1] = retFalse;
        assertEval(params, false);
    }


    function assertEval(uint256[] memory args, uint8 argId, Op op, uint256 value, bool expected) internal {
        Param[] memory params = new Param[](1);
        params[0] = Param(argId, uint8(op), uint240(value));
        assertEval(params, args, expected);
    }

    function assertEval(Param[] memory params, bool expected) internal {
        assertEval(params, new uint256[](0), expected);
    }

    function assertEval(Param[] memory params, uint256[] memory args, bool expected) internal {
        bytes32 paramHash = encodeAndSaveParams(params);
        bool allow = _evalParam(paramHash, 0, address(0), address(0), bytes32(0), args);

        Assert.equal(allow, expected, "eval got unexpected result");
    }

    event LogParam(bytes32 param);
    function encodeAndSaveParams(Param[] memory params) internal returns (bytes32) {
        uint256[] memory encodedParams = new uint256[](params.length);

        for (uint256 i = 0; i < params.length; i++) {
            Param memory param = params[i];
            encodedParams[i] = (uint256(param.id) << 248) + (uint256(param.op) << 240) + param.value;
            emit LogParam(bytes32(encodedParams[i]));
        }

        return _saveParams(encodedParams);
    }
}
