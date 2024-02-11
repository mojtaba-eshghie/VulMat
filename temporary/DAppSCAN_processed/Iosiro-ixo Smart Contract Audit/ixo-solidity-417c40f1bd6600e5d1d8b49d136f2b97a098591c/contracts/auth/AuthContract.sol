// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-417c40f1bd6600e5d1d8b49d136f2b97a098591c/contracts/utils/Ownable.sol

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
        require(msg.sender == owner, "Permission denied");
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
   * @param _newOwner The address to transfer ownership to.
   */
    function transferOwnership(address _newOwner) public onlyOwner {
        _transferOwnership(_newOwner);
    }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
    function _transferOwnership(address _newOwner) internal {
        require(_newOwner != address(0), "Can't transfer to 0x0");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-417c40f1bd6600e5d1d8b49d136f2b97a098591c/contracts/project/ProjectWallet.sol

pragma solidity ^0.4.24;

contract ProjectWallet {

    function transfer(address _receiver, uint256 _amt) public returns (bool);

}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-417c40f1bd6600e5d1d8b49d136f2b97a098591c/contracts/project/ProjectWalletAuthoriser.sol

pragma solidity ^0.4.24;


contract ProjectWalletAuthoriser is Ownable {

    address private authoriser;

    /**
    * @dev Throws if called by any account other than the authoriser.
    */
    modifier onlyAuthoriser() {
        require(msg.sender == authoriser, "Permission denied");
        _;
    }

    function setAuthoriser(address _authoriser) public onlyOwner returns (bool)
    {
        authoriser = _authoriser;
    }

  /**
   * @dev Transfer the amount of tokens from the spender to the receiver.
   * @param _sender The address which will spend the funds.
   * @param _receiver The address which will receiver the funds.
   * @param _amt The amount of tokens to send.
   */
    function transfer(
        address _sender, 
        address _receiver, 
        uint256 _amt
    )
    public onlyAuthoriser
    returns (bool)
    {
        // SWC-Unchecked Call Return Value: L38
        ProjectWallet(_sender).transfer(_receiver, _amt);
    }

}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-417c40f1bd6600e5d1d8b49d136f2b97a098591c/contracts/auth/AuthContract.sol

pragma solidity ^0.4.24;


contract AuthContract is Ownable {

    address[]  public  members;
    uint       public  quorum;

    mapping (uint => mapping (address => bool)) public  confirmedBy;
    mapping (address => bool) public  isMember;
    mapping (bytes32 => Action) public actions;

    struct Action {
        address  target;
        address  sender;
        address  receiver;
        uint256  amt;

        uint     confirmations;
        bool     triggered;
    }

    event Confirmed  (bytes32 id, address member);
    event Triggered  (bytes32 id);

    constructor(address[] _members, uint _quorum) public {
        members = _members;
        quorum = _quorum;

        for (uint i = 0; i < members.length; i++) {
            isMember[members[i]] = true;
        }
    }

    /**
    * @dev Throws if called by a non-member.
    */
    modifier onlyMembers() {
        require(isMember[msg.sender], "Not a member");
        _;
    }

    modifier onlyActive(bytes32 _tx) {
        require(!actions[_tx].triggered, "Transaction already triggered");
        _;
    }

    function memberCount() public view returns (uint) {
        return members.length;
    }

    function setQuorum(uint _quorum) public onlyOwner {
        quorum = _quorum;
    }

    function validate(
        bytes32  _tx,
        address  _target,
        address  _sender,
        address  _receiver,
        uint256  _amt
    ) public onlyMembers returns (bool) {
        require(_tx != 0, "Invalid transaction id");
        require(_target != address(0), "Invalid target");
        require(_sender != address(0), "Invalid sender");
        require(_receiver != address(0), "Invalid receiver");
        require(_amt >= 0, "Invalid amount");
        actions[_tx].target = _target;
        actions[_tx].sender = _sender;
        actions[_tx].receiver = _receiver;
        actions[_tx].amt = _amt;
        actions[_tx].triggered = false;
        actions[_tx].confirmations = actions[_tx].confirmations + 1;

        emit Confirmed(_tx, msg.sender);

        if(actions[_tx].confirmations >= quorum){
            _trigger(_tx);
            emit Triggered(_tx);
        }

        return true;
    }

    function _trigger(bytes32 _tx) internal onlyMembers onlyActive(_tx) {
        actions[_tx].triggered = true;
        ProjectWalletAuthoriser(actions[_tx].target).transfer(actions[_tx].sender, actions[_tx].receiver, actions[_tx].amt);
    }

}
