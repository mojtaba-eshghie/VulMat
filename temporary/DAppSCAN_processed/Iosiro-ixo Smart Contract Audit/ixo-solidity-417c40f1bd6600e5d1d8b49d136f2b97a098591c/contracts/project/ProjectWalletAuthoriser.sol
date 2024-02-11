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
