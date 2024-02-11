// File: ../sc_datasets/DAppSCAN/openzeppelin-Holdefi/Holdefi-f4df394d7cf6df347b1f1e9af8e2676c5933c2c9/Ownable.sol

pragma solidity ^0.5.16;

 // Taking ideas from Open Zeppelin's Pausable contract
contract Ownable {
    address public owner;
    address public ownerChanger;
    address public pendingOwner;

    event OwnershipTransferRequested(address newPendingOwner);

    event OwnershipTransferred(address oldOwner, address newOwner);

    // The Ownable constructor sets the `ownerChanger` and the original `owner` of the contract.
    constructor (address newOwnerChanger) public {
        owner = msg.sender;
        ownerChanger = newOwnerChanger;
    }

    // Modifier to make a function callable only by owner
    modifier onlyOwner() {
        require(msg.sender == owner, 'Sender should be Owner');
        _;
    }

    // Allows the current owner to transfer control of the contract to a newOwner. (It should be accepted by OwnerChanger)
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0),'New owner can not be zero address');
        pendingOwner = newOwner;

        emit OwnershipTransferRequested(newOwner);
    }
//SWC-Transaction Order Dependence:L26-31,34-42
    // Owner changer can accept if owner call transferOwnership function
    function acceptTransferOwnership () external {
        require (msg.sender == ownerChanger, 'Sender should be ownerChanger');
        require (pendingOwner != address(0), 'Pending Owner is empty');
        address oldOwner = owner;
        owner = pendingOwner;
        pendingOwner = address(0);

        emit OwnershipTransferred(oldOwner, pendingOwner);
    }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-Holdefi/Holdefi-f4df394d7cf6df347b1f1e9af8e2676c5933c2c9/HoldefiPauser.sol

pragma solidity ^0.5.16;

// Taking ideas from Open Zeppelin's Pausable contract
contract HoldefiPauser is Ownable {    
    address public pauser;

     // '0' -> supply
     // '1' -> withdrawSupply
     // '2' -> collatralize
     // '3' -> withdrawCollateral
     // '4' -> borrow
     // '5' -> repayBorrrow
     // '6' -> liquidateBorrowerCollateral
     // '7' -> buyLiquidatedCollateral
    
    uint constant functionsNum = 8;
    uint[8] public paused;

    uint public pauseDuration = 2592000;

     
    constructor (address newOwnerChanger) Ownable(newOwnerChanger) public {
    }

    // Modifier to make a function callable only by owner or pauser   
    modifier onlyPausers() {
        require(msg.sender == owner || msg.sender == pauser , 'Sender should be Owner or Pauser');
        _;
    }
    
    // Modifier to make a function callable only when a functions is not paused.
    modifier whenNotPaused(uint index) {
        require(!isPause(index), "Pausable: paused");
        _;
    }

    // Modifier to make a function callable only when a functions is paused.
    modifier whenPaused(uint index) {
        require(isPause(index), "Pausable: not paused");
        _;
    }

    function isPause(uint index) public view returns(bool res) {
        if (block.timestamp - paused[index] >= pauseDuration) {
            res = false;
        }
        else {
            res = true;
        }
    }
    
    // Called by pausers to pause, triggers stopped state.
    function pause(uint index) public onlyPausers {
        paused[index] = block.timestamp;
    }

    // Called by owner to unpause, returns to normal state.
    function unpause(uint index) public onlyOwner {
        paused[index] = 0;
    }
//SWC-Function Default Visibility:L65-71
    // Called by pausers to pause, triggers stopped state for selected functions
    function batchPause(bool[8] memory newPaused) public onlyPausers {
        for (uint i=0; i<functionsNum; i++) {
            if (newPaused[i] == true){
                pause(i);
            }
        }
    }
//SWC-Function Default Visibility:L74-80
    // Called by pausers to pause, returns to normal state for selected functions
    function batchUnpause(bool[8] memory newUnpaused) public onlyOwner {
        for (uint i=0; i<functionsNum; i++) {
            if (newUnpaused[i] == true){
                unpause(i);
            }
        }
    }
    // Called by owner to set a new pauser
    function setPauser(address newPauser) external onlyOwner {
        pauser = newPauser;
    }

    function setPauseDuration(uint newPauseDuration) external onlyOwner {
        pauseDuration = newPauseDuration;
    }
}
