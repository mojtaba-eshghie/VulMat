// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/abstract/IPoolRegistry.sol

pragma solidity ^0.4.24;


/**
 * @title PoolRegistry Interface 
 */
contract IPoolRegistry {
    function register
    (
        address creatorAddress,
        address poolAddress,
        uint poolVersion,
        uint code
    )
        external;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/abstract/IPoolFactory.sol

pragma solidity ^0.4.24;


/**
 * @title PoolFactory Interface 
 */
contract IPoolFactory {
    function deploy
    (
        uint maxBalance,
        uint minContribution,
        uint maxContribution,
        uint ctorFeePerEther,        
        address creatorAddress,
        address presaleAddress,
        address feeManagerAddr,
        address[] whitelist,
        address[] adminis
    )
        external
        returns (address poolAddress, uint poolVersion);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/zeppelin/Ownable.sol

pragma solidity ^0.4.24;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;

    event OwnershipRenounced(address indexed previousOwner);
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor() public {
        owner = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     * @notice Renouncing to ownership will leave the contract without an owner.
     * It will not be possible to call the functions with the `onlyOwner`
     * modifier anymore.
     */
    function renounceOwnership() public onlyOwner {        
        emit OwnershipRenounced(owner);
        owner = address(0);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/zeppelin/Pausable.sol

pragma solidity ^0.4.24;

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Ownable {
    event Pause();
    event Unpause();

    bool public paused = false;


    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     */
    modifier whenPaused() {
        require(paused);
        _;
    }

    /**
     * @dev called by the owner to pause, triggers stopped state
     */
    function pause() onlyOwner whenNotPaused public {
        paused = true;
        emit Pause();
    }

    /**
     * @dev called by the owner to unpause, returns to normal state
     */
    function unpause() onlyOwner whenPaused public {
        paused = false;
        emit Unpause();
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/zeppelin/NoEther.sol

pragma solidity ^0.4.24;

/**
 * @title Contracts that should not own Ether
 * @author Remco Bloemen <remco@2π.com>
 * @dev This tries to block incoming ether to prevent accidental loss of Ether. Should Ether end up
 * in the contract, it will allow the owner to reclaim this Ether.
 * @notice Ether can still be sent to this contract by:
 * calling functions labeled `payable`
 * `selfdestruct(contract_address)`
 * mining directly to the contract address
 */
contract HasNoEther is Ownable {

    /**
     * @dev Constructor that rejects incoming Ether
     * The `payable` flag is added so we can access `msg.value` without compiler warning. If we
     * leave out payable, then Solidity will allow inheriting contracts to implement a payable
     * constructor. By doing it this way we prevent a payable constructor from working. Alternatively
     * we could use assembly to access msg.value.
     */
    constructor() public payable {
        require(msg.value == 0);
    }

    /**
     * @dev Disallows direct send by setting a default function without the `payable` flag.
     */
    function() external {
    }

    /**
     * @dev Transfer all Ether held by the contract to the owner.
     */
    function reclaimEther() external onlyOwner {
        owner.transfer(address(this).balance);
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/common/CMService.sol

pragma solidity ^0.4.24;




/**
* @title Contracts Manager Service
*/
contract CMService is Pausable, HasNoEther {     

    address public feeService;      
    IPoolFactory public poolFactory;
    IPoolRegistry public poolRegistry;    

    /**
     * @dev Deploy new pool contract.
     */
    function deployPoolContract(
        uint details,
        uint maxBalance,
        uint minContribution,
        uint maxContribution,
        uint ctorFeePerEther,
        address presaleAddr,
        address[] whitelist,
        address[] admins
    ) 
        external 
        whenNotPaused
    {
        require(feeService != address(0));
        uint dts = details;

        uint poolVersion;
        address poolAddress;        
        (poolAddress, poolVersion) = poolFactory.deploy(
            maxBalance,
            minContribution,
            maxContribution,
            ctorFeePerEther,            
            msg.sender,
            presaleAddr,
            feeService,
            whitelist,
            admins
        );     

        poolRegistry.register(
            msg.sender,
            poolAddress,
            poolVersion,
            dts
        );
    }

    /**
     * @dev Set new fee service.
     */
    function setFeeService(address newFeeService) external onlyOwner {
        emit FeeServiceAttached(newFeeService);
        feeService = newFeeService;        
    }

    /**
     * @dev Set new pool factory.
     */
    function setPoolFactory(address newPoolFactory) external onlyOwner {
        emit PoolFactoryAttached(newPoolFactory);
        poolFactory = IPoolFactory(newPoolFactory);        
    }

    /**
     * @dev Set new pool registry.
     */
    function setPoolRegistry(address newPoolRegistry) external onlyOwner {
        emit PoolRegistryAttached(newPoolRegistry);
        poolRegistry = IPoolRegistry(newPoolRegistry);        
    }

    event FeeServiceAttached(address newFeeService);
    event PoolFactoryAttached(address newPoolFactory);
    event PoolRegistryAttached(address newPoolRegistry);       
}
