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

// File: ../sc_datasets/DAppSCAN/QuillAudits-Akropolis-Vesting/AkropolisToken-28a415392489a1a88073c3d0fd22b141f4d3170e/contracts/helpers/Whitelist.sol

pragma solidity >=0.4.24;

/**
 * @title Whitelist
 * @dev Base contract which allows children to implement an emergency whitelist mechanism. Identical to OpenZeppelin version
 * except that it uses local Ownable contract
 */
 
contract Whitelist is Ownable {
    event AddToWhitelist(address indexed to);
    event RemoveFromWhitelist(address indexed to);
    event EnableWhitelist();
    event DisableWhitelist();
    event AddPermBalanceToWhitelist(address indexed to, uint256 balance);
    event RemovePermBalanceToWhitelist(address indexed to);

    mapping(address => bool) internal whitelist;
    mapping (address => uint256) internal permBalancesForWhitelist;

    /**
    * @dev Modifier to make a function callable only when msg.sender is in whitelist.
    */
    modifier onlyWhitelist() {
        if (isWhitelisted() == true) {
            require(whitelist[msg.sender] == true, "Address is not in whitelist");
        }
        _;
    }

    /**
    * @dev Modifier to make a function callable only when msg.sender is in permitted balance
    */
    modifier checkPermBalanceForWhitelist(uint256 value) {
        if (isWhitelisted() == true) {
            require(permBalancesForWhitelist[msg.sender]==0 || permBalancesForWhitelist[msg.sender]>=value, "Not permitted balance for transfer");
        }
        
        _;
    }

    /**
    * @dev called by the owner to set permitted balance for transfer
    */

    function addPermBalanceToWhitelist(address _owner, uint256 _balance) public onlyOwner {
        permBalancesForWhitelist[_owner] = _balance;
        emit AddPermBalanceToWhitelist(_owner, _balance);
    }

    /**
    * @dev called by the owner to remove permitted balance for transfer
    */
    function removePermBalanceToWhitelist(address _owner) public onlyOwner {
        permBalancesForWhitelist[_owner] = 0;
        emit RemovePermBalanceToWhitelist(_owner);
    }
   
    /**
    * @dev called by the owner to enable whitelist
    */

    function enableWhitelist() public onlyOwner {
        setWhitelisted(true);
        emit EnableWhitelist();
    }


    /**
    * @dev called by the owner to disable whitelist
    */
    function disableWhitelist() public onlyOwner {
        setWhitelisted(false);
        emit DisableWhitelist();
    }

    /**
    * @dev called by the owner to enable some address for whitelist
    */
    function addToWhitelist(address _address) public onlyOwner  {
        whitelist[_address] = true;
        emit AddToWhitelist(_address);
    }

    /**
    * @dev called by the owner to disable address for whitelist
    */
    function removeFromWhitelist(address _address) public onlyOwner {
        whitelist[_address] = false;
        emit RemoveFromWhitelist(_address);
    }


    // bool public whitelisted = false;

    function setWhitelisted(bool value) internal {
        bytes32 slot = keccak256(abi.encode("Whitelist", "whitelisted"));
        uint256 v = value ? 1 : 0;
        assembly {
            sstore(slot, v)
        }
    }

    function isWhitelisted() public view returns (bool) {
        bytes32 slot = keccak256(abi.encode("Whitelist", "whitelisted"));
        uint256 v;
        assembly {
            v := sload(slot)
        }
        return v != 0;
    }
}
