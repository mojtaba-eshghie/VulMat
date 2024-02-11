// File: ../sc_datasets/DAppSCAN/QuillAudits-Akropolis-Vesting/AkropolisToken-28a415392489a1a88073c3d0fd22b141f4d3170e/contracts/helpers/Ownable.sol

pragma solidity >=0.4.24;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions". This adds two-phase
 * ownership control to OpenZeppelin's Ownable class. In this model, the original owner 
 * designates a new owner but does not actually transfer ownership. The new owner then accepts 
 * ownership and completes the transfer.
 */
contract Ownable {
    address public owner;
    address public pendingOwner;


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
        pendingOwner = address(0);
    }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner, "Account is not owner");
        _;
    }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyPendingOwner() {
        require(msg.sender == pendingOwner, "Account is not pending owner");
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param _newOwner The address to transfer ownership to.
    */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Empty address");
        pendingOwner = _newOwner;
    }

    /**
    * @dev Allows the pendingOwner address to finalize the transfer.
    */
    function claimOwnership() onlyPendingOwner public {
        emit OwnershipTransferred(owner, pendingOwner);
        owner = pendingOwner;
        pendingOwner = address(0);
    }
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Akropolis-Vesting/AkropolisToken-28a415392489a1a88073c3d0fd22b141f4d3170e/contracts/helpers/Lockable.sol

pragma solidity >=0.4.24;

/**
* @title Lockable
* @dev Base contract which allows children to lock certain methods from being called by clients.
* Locked methods are deemed unsafe by default, but must be implemented in children functionality to adhere by
* some inherited standard, for example. 
*/

contract Lockable is Ownable {
	// Events
	event Unlocked();
	event Locked();

	// Modifiers
	/**
	* @dev Modifier that disables functions by default unless they are explicitly enabled
	*/
	modifier whenUnlocked() {
		require(!isLocked(), "Contact is locked");
		_;
	}

	// Methods
	/**
	* @dev called by the owner to enable method
	*/
	function unlock() public onlyOwner  {
		setLock(false);
		emit Unlocked();
	}

	/**
	* @dev called by the owner to disable method, back to normal state
	*/
	function lock() public  onlyOwner {
		setLock(true);
		emit Locked();
	}

	function setLock(bool value) internal {
        bytes32 slot = keccak256(abi.encode("Lockable", "lock"));
        uint256 v = value ? 1 : 0;
        assembly {
            sstore(slot, v)
        }
    }

    function isLocked() public view returns (bool) {
        bytes32 slot = keccak256(abi.encode("Lockable", "lock"));
        uint256 v;
        assembly {
            v := sload(slot)
        }
        return v != 0;
    }

}
