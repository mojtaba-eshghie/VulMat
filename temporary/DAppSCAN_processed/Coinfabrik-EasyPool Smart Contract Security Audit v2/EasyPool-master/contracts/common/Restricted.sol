// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit v2/EasyPool-master/contracts/zeppelin/Ownable.sol

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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit v2/EasyPool-master/contracts/common/Restricted.sol

pragma solidity ^0.4.24;

/**
 * @title Restricted 
 */
contract Restricted is Ownable {  

    address[] public operators;
    mapping(address => bool) public permissions;    

    /**
     * @dev Only operator access.
     */
    modifier onlyOperator() {
        require(permissions[msg.sender]);
        _;
    }

    /**
    * @dev Add new operator address.
    */
    function addOperator(address operator) external onlyOwner {        
        require(operator != address(0));
        require(!permissions[operator]);

        operators.push(operator);
        permissions[operator] = true;
        emit OperatorAdded(operator);
    }

    /**
    * @dev Remove specified operator address.
    */
    function removeOperator(address operator) external onlyOwner {        
        require(operator != address(0));
        require(permissions[operator]);

        uint deleteIndex;
        uint lastIndex = operators.length - 1;
        for (uint i = 0; i <= lastIndex; i++) {
            if(operators[i] == operator) {
                deleteIndex = i;
                break;
            }
        }
        
        if (deleteIndex < lastIndex) {
            operators[deleteIndex] = operators[lastIndex];             
        }

        delete operators[lastIndex];
        operators.length--;              

        permissions[operator] = false;        
        emit OperatorRemoved(operator);
    }

    /**
     * @dev Returns list of all operators.
     */
    function getOperators() public view returns(address[]) {
        return operators;
    }

    event OperatorAdded(address operator);
    event OperatorRemoved(address operator);      
}
