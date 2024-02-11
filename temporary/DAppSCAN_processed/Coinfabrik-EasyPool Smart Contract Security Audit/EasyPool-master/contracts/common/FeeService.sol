// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/abstract/IFeeService.sol

pragma solidity ^0.4.24;


/**
 * @title FeeService Interface 
 */
contract IFeeService {
    function getFeePerEther() public view returns(uint);
    function sendFee(address feePayer) external payable;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/abstract/IAffiliate.sol

pragma solidity ^0.4.24;


/**
 * @title Affiliate Interface 
 */
contract IAffiliate {
    function getSharePerEther(address subscriber) external view returns(uint sharePerEther, bool success);
    function sendRevenueShare(address subscriber) external payable;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/zeppelin/SafeMath.sol

pragma solidity ^0.4.24;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {

    /**
     * @dev Multiplies two numbers, reverts on overflow.
     */
    function mul(uint256 _a, uint256 _b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (_a == 0) {
            return 0;
        }

        uint256 c = _a * _b;
        require(c / _a == _b);

        return c;
    }

    /**
     * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b > 0); // Solidity only automatically asserts when dividing by 0
        uint256 c = _a / _b;
        // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b <= _a);
        uint256 c = _a - _b;

        return c;
    }

    /**
     * @dev Adds two numbers, reverts on overflow.
     */
    function add(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 c = _a + _b;
        require(c >= _a);

        return c;
    }

    /**
     * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/common/FeeService.sol

pragma solidity ^0.4.24;




/**
 * @title FeeService 
 */
contract FeeService is IFeeService, Ownable {     
    // We could use SafeMath to catch errors in the logic, 
    // but if there are no such errors we can skip it.
    // using SafeMath for uint;  
    
    IAffiliate public affiliate;
    uint public feePerEther;        

    /**
     * @dev Send fee from specified pool creator.
     */
    function sendFee(address poolCreator) external payable {
        require(msg.value > 0);
        require(poolCreator != address(0));
        
        bool success;
        uint affShare;
        uint sharePerEther;

        if(affiliate != address(0)) {
            (sharePerEther, success) = affiliate.getSharePerEther(poolCreator);
            if(success && sharePerEther > 0) {
                require(sharePerEther <= 1 ether);
                affShare = (msg.value * sharePerEther) / 1 ether;
                if(affShare > 0) {
                    affiliate.sendRevenueShare.value(affShare)(poolCreator);
                }            
            }
        }

        emit FeeDistributed(
            poolCreator,
            msg.sender,            
            msg.value,
            affShare
        );
    }

    /**
     * @dev Withdraw contract balance.
     */
    function withdraw() external onlyOwner {
        emit Withdrawal(msg.sender, address(this).balance);
        owner.transfer(address(this).balance);
    }

    /**
     * @dev Set service comission, in terms of 'Fee per Ether'.
     */
    function setFeePerEther(uint newFeePerEther) external onlyOwner {
        emit ServiceFeeChanged(feePerEther, newFeePerEther);
        feePerEther = newFeePerEther;
    }

    /**
     * @dev Attach affiliation service.
     */
    function setAffiliate(address newAffiliate) external onlyOwner {
        emit AffiliateAttached(address(affiliate), newAffiliate);
        affiliate = IAffiliate(newAffiliate);
    }

    /**
     * @dev Get service comission, in terms of 'Fee per Ether'.
     */
    function getFeePerEther() public view returns(uint) {
        return feePerEther;
    }    

    event AffiliateAttached(
        address prevAffiliate, 
        address newAffiliate
    );
    event ServiceFeeChanged(
        uint prevFeePerEther, 
        uint newFeePerEther
    );
    event FeeDistributed(
        address indexed creator,
        address poolAddress,        
        uint totalAmount,
        uint affShare        
    );
    event Withdrawal(
        address destAddress,
        uint amount
    );    
}
