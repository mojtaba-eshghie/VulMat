// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/abstract/IAffiliate.sol

pragma solidity ^0.4.24;


/**
 * @title Affiliate Interface 
 */
contract IAffiliate {
    function getSharePerEther(address subscriber) external view returns(uint sharePerEther, bool success);
    function sendRevenueShare(address subscriber) external payable;
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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/common/Restricted.sol

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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/common/Affiliate.sol

pragma solidity ^0.4.24;

//import "../zeppelin/SafeMath.sol";

/**
 * @title Affiliation Service
 */
contract Affiliate is IAffiliate, Restricted {
    // We could use SafeMath to catch errors in the logic, 
    // but if there are no such errors we can skip it.
    // using SafeMath for uint;  

    /**
     * @dev Affiliate structure.
     */
    struct AffiliateData {        
        uint currentBalance;
        uint totalRevenue;
        uint modelIndex;    
        uint curShare;        
        uint curLevel;        
        bool exists;
    }

    /**
     * @dev Subscriber structure.
     */
    struct SubscriberData {        
        uint generatedRevenue;
        uint transfersCount;        
    }  

    /**
     * @dev Revenue sharing rule.
     */    
    struct ShareRule {
        uint totalRevenue;
        uint sharePerEther;        
    }
    
    address[] public affiliates;
    address[] public subscribers;    

    mapping (address => address) public subToAffiliate;
    mapping (address => address[]) public affiliateToSubs;   
    mapping (address => AffiliateData) public affiliateToData;
    mapping (address => SubscriberData) public subscriberToData;                     
    mapping (uint => ShareRule[]) public models;    
    uint public curModelIndex = 0;   
    
    /**
     * @dev Constructor.
     */
    constructor() public {
        models[curModelIndex]
            .push(ShareRule(uint256MaxValue(), 0));
    }

    /**
     * @dev Update revenue sharing rules.
     */
    function setRevenueSharingRules(uint[] levels, uint[] shares) external onlyOwner {    
        require(levels.length > 0 && levels.length == shares.length);

        curModelIndex++;
        ShareRule[] storage rules = models[curModelIndex];                

        for (uint i = 0; i < levels.length; i++) {
            require(shares[i] <= 1 ether);
            rules.push(ShareRule(levels[i], shares[i]));
        }        
            
        emit RevenueSharingRulesChanged(
            levels, 
            shares,             
            curModelIndex
        );
    }

    /**
     * @dev Confirm or update affiliation.     
     */
    function confirmAffiliation() external {
        AffiliateData storage aData = affiliateToData[msg.sender];

        if(aData.exists) {
            require(aData.modelIndex != curModelIndex);
            aData.modelIndex = curModelIndex;  
            updateLevelAndShare(aData);
        } else {                     
            affiliates.push(msg.sender);
            aData.modelIndex = curModelIndex;   
            aData.curShare = models[curModelIndex][0].sharePerEther;
            aData.curLevel = models[curModelIndex][0].totalRevenue;              
            aData.exists = true;        
        }        
        
        emit AffiliationConfirmed(
            msg.sender, 
            aData.modelIndex
        );
    }

    /**
    * @dev Confirm new subscription.
    */
    function confirmSubscription(address affiliate) external {        
        require(affiliate != address(0));
        require(affiliateToData[affiliate].exists);
        require(subToAffiliate[msg.sender] == address(0));
                                
        subscribers.push(msg.sender);
        subToAffiliate[msg.sender] = affiliate;
        affiliateToSubs[affiliate].push(msg.sender);         

        emit SubscriptionConfirmed(
            affiliate, 
            msg.sender
        );
    }

    /**
    * @dev Withdraw available balance.
    */
    function withdraw() external {        
        uint amount = affiliateToData[msg.sender].currentBalance;         
        affiliateToData[msg.sender].currentBalance = 0;
        msg.sender.transfer(amount);
        emit Withdrawal(
            msg.sender, 
            amount
        );
    } 

    /**
    * @dev Send revenue share for specified subscriber.
    */
    function sendRevenueShare(address subscriber) external payable onlyOperator {
        require(msg.value > 0);
        require(subscriber != address(0));
        require(subToAffiliate[subscriber] != address(0));
                
        AffiliateData storage aData = affiliateToData[subToAffiliate[subscriber]];                
        aData.currentBalance += msg.value;  
        aData.totalRevenue += msg.value;

        if(aData.totalRevenue >= aData.curLevel) {
            updateLevelAndShare(aData);
        }
        
        SubscriberData storage sData = subscriberToData[subscriber];        
        sData.generatedRevenue += msg.value;
        sData.transfersCount++;

        emit RevenueShareReceived(
            subToAffiliate[subscriber], 
            subscriber,
            aData.currentBalance,
            msg.value            
        );
    }

    /**
     * @dev Update level and share for specified affiliate.
     */
    function updateLevelAndShare(AffiliateData storage aData) private {
        ShareRule[] storage rules = models[aData.modelIndex];  
        uint totalRevenue = aData.totalRevenue;

        uint length = rules.length;
        for (uint i = 0; i < length; i++) {
            if(totalRevenue < rules[i].totalRevenue) {
                aData.curShare = rules[i].sharePerEther;
                aData.curLevel = rules[i].totalRevenue;                
                return;
            }
        }

        aData.curLevel = uint256MaxValue();
    }


    /**
     * @dev Get revenue share for specified subscriber.     
     */
    function getSharePerEther(address subscriber) external view returns(uint sharePerEther, bool success) {
        if(subToAffiliate[subscriber] != address(0)) {
            AffiliateData storage aData = affiliateToData[subToAffiliate[subscriber]];                    
            sharePerEther = aData.curShare;
            success = true;
        }                        
    }
        
    /**
     * @dev Returns revenue sharing rules for specified model.
     */
    function getRevenueSharingRules(uint modelIndex) external view returns(uint[] levels, uint[] shares) {
        ShareRule[] storage rules = models[modelIndex];
        levels = new uint[](rules.length);
        shares = new uint[](rules.length);
        
        for (uint i = 0; i < rules.length; i++) {
            shares[i] = rules[i].sharePerEther;
            levels[i] = rules[i].totalRevenue;
        }            
    }        

    /**
     * @dev Returns list of all subscribers for specified affiliate. 
     */
    function getAffiliateSubscribers(address affiliate) external view returns(address[]) {
        return affiliateToSubs[affiliate];
    }

    /**
     * @dev Returns list of all subscribers. 
     */
    function getAllSubscribers() external view returns(address[]) {
        return subscribers;
    }

    /**
     * @dev Returns list of all affiliates. 
     */
    function getAllAffiliates() external view returns(address[]) {
        return affiliates;
    }

    /**
     * @dev Returns max value for uint256.
     */
    function uint256MaxValue() private pure returns(uint) {
        return 2**256 - 1;
    }
    
    event RevenueSharingRulesChanged(
        uint[] levels,
        uint[] shares,         
        uint index
    ); 
    event SubscriptionConfirmed(
        address indexed affiliate, 
        address subscriber
    );     
    event AffiliationConfirmed(
        address indexed affiliate, 
        uint indexed modelIndex
    );                  
    event RevenueShareReceived(
        address indexed affiliate, 
        address indexed subscriber, 
        uint affiliateBalance,
        uint amount
    ); 
    event Withdrawal(
        address indexed affiliate, 
        uint amount
    );           
}
