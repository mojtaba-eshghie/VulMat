// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/product/IProductStorage.sol

pragma solidity ^0.4.18;

//Abstraction of ProductStorage
contract IProductStorage {

    //
    //Inner types
    /**dev Purchase state 
        0-finished. purchase is completed and can't be reverted, 
        1-paid. can be complained using escrow.
        2-complain. there was a complain
        3-canceled. customer won the dispute and got eth back
        4-pending. vendor can withdraw his funds from escrow
    */
    enum PurchaseState {Finished, Paid, Complain, Canceled, Pending}

    //
    // Methods

    function banned(uint256 productId) public constant returns(bool) {}

    function getTotalProducts() public constant returns(uint256);    

    function getTextData(uint256 productId) public constant returns(string name, string data);    

    /**@dev Returns information about purchase with given index for the given product */
    function getProductData(uint256 productId) public constant returns(
            uint256 price, 
            uint256 maxUnits, 
            uint256 soldUnits
        );    

    function getProductActivityData(uint256 productId) public constant returns(
            bool active,
            uint256 startTime,
            uint256 endTime
        );

    /**@dev Returns product's creator */
    function getProductOwner(uint256 productId) public constant returns(address);    

    /**@dev Returns product's price in wei */
    function getProductPrice(uint256 productId) public constant returns(uint256);    

    function isEscrowUsed(uint256 productId) public constant returns(bool);

    function isFiatPriceUsed(uint256 productId) public constant returns(bool);

    function isProductActive(uint256 productId) public constant returns(bool);

    /**@dev Returns total amount of purchase transactions for the given product */
    function getTotalPurchases(uint256 productId) public constant returns (uint256);    

    /**@dev Returns information about purchase with given index for the given product */
    function getPurchase(uint256 productId, uint256 purchaseId) public constant returns(PurchaseState);    

    /**@dev Returns escrow-related data for specified purchase */
    function getEscrowData(uint256 productId, uint256 purchaseId)
        public
        constant
        returns (address, uint256, uint256, uint256);    

    /**@dev Returns wallet for specific vendor */
    function getVendorWallet(address vendor) public constant returns(address);    

    /**@dev Returns fee permille for specific vendor */
    function getVendorFee(address vendor) public constant returns(uint16);    

    function setVendorInfo(address vendor, address wallet, uint16 feePermille) public;        

    /**@dev Adds new product to the storage */
    function createProduct(
        address owner,         
        uint256 price, 
        uint256 maxUnits,
        bool isActive,
        uint256 startTime, 
        uint256 endTime,
        bool useEscrow,
        bool useFiatPrice,
        string name,
        string data
    ) public;

    /**@dev Edits product in the storage */   
    function editProduct(
        uint256 productId,        
        uint256 price, 
        uint256 maxUnits, 
        bool isActive,
        uint256 startTime, 
        uint256 endTime,
        bool useEscrow,
        bool useFiatPrice,
        string name,
        string data
    ) public;

    // function editProductData(
    //     uint256 productId,        
    //     uint256 price,
    //     bool useFiatPrice, 
    //     uint256 maxUnits, 
    //     bool isActive,
    //     uint256 startTime, 
    //     uint256 endTime,
    //     bool useEscrow        
    // ) public;

    // function editProductText(
    //     uint256 productId,        
    //     string name,
    //     string data
    // ) public;

    /**@dev Changes the value of sold units */
    function changeSoldUnits(uint256 productId, uint256 soldUnits) public;
    
    /**@dev  Adds new purchase to the list of given product */
    function addPurchase(
        uint256 productId,        
        address buyer,    
        uint256 price,         
        uint256 paidUnits,
        string clientId   
    ) public returns (uint256);    

    /**@dev Changes purchase state */
    function changePurchase(uint256 productId, uint256 purchaseId, PurchaseState state) public;

    /**@dev Sets escrow data for specified purchase */
    function setEscrowData(
        uint256 productId, 
        uint256 purchaseId, 
        address customer, 
        uint256 fee, 
        uint256 profit, 
        uint256 timestamp
    ) public;
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/product/IFeePolicy.sol

pragma solidity ^0.4.18;


/**Abstraction of fee policy */
contract IFeePolicy {

    /**@dev Returns total fee amount depending on payment */
    function calculateFeeAmount(address owner, uint256 productId, uint256 payment) public returns(uint256);

    /**@dev Sends fee amount to service provider  */
    function sendFee() public payable;
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/common/IOwned.sol

pragma solidity ^0.4.18;

/**@dev Simple interface to Owned base class */
contract IOwned {
    function owner() public constant returns (address) {}
    function transferOwnership(address _newOwner) public;
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/common/Owned.sol

pragma solidity ^0.4.18;

contract Owned is IOwned {
    address public owner;        

    function Owned() public {
        owner = msg.sender;
    }

    // allows execution by the owner only
    modifier ownerOnly {
        require(msg.sender == owner);
        _;
    }

    /**@dev allows transferring the contract ownership. */
    function transferOwnership(address _newOwner) public ownerOnly {
        require(_newOwner != owner);
        owner = _newOwner;
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/common/Manageable.sol

pragma solidity ^0.4.18;

///A token that have an owner and a list of managers that can perform some operations
///Owner is always a manager too
contract Manageable is Owned {

    event ManagerSet(address manager, bool state);

    mapping (address => bool) public managers;

    function Manageable() public Owned() {
        managers[owner] = true;
    }

    /**@dev Allows execution by managers only */
    modifier managerOnly {
        require(managers[msg.sender]);
        _;
    }

    function transferOwnership(address _newOwner) public ownerOnly {
        super.transferOwnership(_newOwner);

        managers[_newOwner] = true;
        managers[msg.sender] = false;
    }

    function setManager(address manager, bool state) public ownerOnly {
        managers[manager] = state;
        ManagerSet(manager, state);
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/common/SafeMathLib.sol

pragma solidity ^0.4.18;

/**dev Utility methods for overflow-proof arithmetic operations 
*/
library SafeMathLib {

    /**dev Returns the sum of a and b. Throws an exception if it exceeds uint256 limits*/
    function safeAdd(uint256 self, uint256 b) internal pure returns (uint256) {        
        uint256 c = self + b;
        require(c >= self);

        return c;
    }

    /**dev Returns the difference of a and b. Throws an exception if a is less than b*/
    function safeSub(uint256 self, uint256 b) internal pure returns (uint256) {
        require(self >= b);
        return self - b;
    }

    /**dev Returns the product of a and b. Throws an exception if it exceeds uint256 limits*/
    function safeMult(uint256 self, uint256 y) internal pure returns(uint256) {
        uint256 z = self * y;
        require((self == 0) || (z / self == y));
        return z;
    }

    function safeDiv(uint256 self, uint256 y) internal pure returns (uint256) {
        require(y != 0);
        return self / y;
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/token/IERC20Token.sol

pragma solidity ^0.4.18;

/**@dev ERC20 compliant token interface. 
https://theethereum.wiki/w/index.php/ERC20_Token_Standard 
https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md */
contract IERC20Token {

    // these functions aren't abstract since the compiler emits automatically generated getter functions as external    
    function name() public constant returns (string _name) { _name; }
    function symbol() public constant returns (string _symbol) { _symbol; }
    function decimals() public constant returns (uint8 _decimals) { _decimals; }
    
    function totalSupply() public constant returns (uint total) {total;}
    function balanceOf(address _owner) public constant returns (uint balance) {_owner; balance;}    
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {_owner; _spender; remaining;}

    function transfer(address _to, uint _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint _value) public returns (bool success);
    function approve(address _spender, uint _value) public returns (bool success);
    

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/product/FeePolicy.sol

pragma solidity ^0.4.18;





/**@dev Calculates fee details. Takes into account BCS tokens that grant fee discount */
contract FeePolicy is Manageable {

    using SafeMathLib for uint256;
    

    //
    // Storage data

    uint16 constant MAXPERMILLE = 1000;

    IProductStorage public productStorage;
    uint16 public defaultFee;               //default fee for genereal products (permille)
    uint16 public escrowFee;                //additional fee for escrow usage (permille)
    //uint256 public minEscrowFeePermille;    //minimum escrow fee permille in weis, can't be discounted further
    uint16 public fiatPriceFee;             //additional fee for fiat price usage (permille)
    address public feeWallet;
    
    IERC20Token public token;               // token to check minimum token balance
    uint256 public minTokenForDiscount;     // min token amount to get fee discount
    uint256 public termDuration;            // term duration in seconds
    uint256 public maxDiscountPerToken;     // max total fee discount/token per term in weis (Y from the docs)
    uint16 public discount;                 // discount permille [0-1000] (X from the docs)
    mapping(address=>mapping(uint256=>uint256)) public totalFeeDiscount; // total fee for combination of vendor+term

    uint256 denominator;                    //maxDiscountPerToken*tokens/denominator = maxTotalDiscount per term


    //
    // Modifiers

    modifier validPermille(uint16 value) {
        require(value <= MAXPERMILLE);
        _;
    }



    //
    // Methods

    function FeePolicy(
        IProductStorage _productStorage,
        uint16 _defaultFeePermille, 
        uint16 _escrowFeePermille,        
        uint16 _fiatPriceFeePermille,
        address _feeWallet,        
        IERC20Token _token,
        uint256 _minTokenForDiscount,
        uint256 _termDuration,
        uint256 _maxDiscountPerToken,
        uint16 _discountPermille
    ) 
        public 
    {        
        require(_termDuration > 0);
        
        productStorage = _productStorage;
        termDuration = _termDuration;

        setParams(
            _defaultFeePermille,
            _escrowFeePermille,
            _fiatPriceFeePermille,
            _feeWallet,
            _token,
            _minTokenForDiscount,        
            _maxDiscountPerToken,
            _discountPermille
        );
    }

    /**@dev Returns total fee amount depending on payment */
    function getFeeDetails(address owner, uint256 productId, uint256 payment) 
        public 
        constant 
        returns(uint256 feeAmount, uint256 feeDiscount) 
    {
        uint16 fee = productStorage.getVendorFee(owner);
        if(fee == 0) {
            fee = defaultFee;
        }

        if(productStorage.isEscrowUsed(productId)) {
            fee = fee + escrowFee;
        }

        if(productStorage.isFiatPriceUsed(productId)) {
            fee = fee + fiatPriceFee;
        }

        if(fee >= MAXPERMILLE) {
            fee = MAXPERMILLE;
        }

        feeAmount = payment.safeMult(uint256(fee)) / MAXPERMILLE;
        feeDiscount = 0;
        //check if we should apply discount for fee
        if(token.balanceOf(owner) >= minTokenForDiscount) {
            feeDiscount = feeAmount.safeMult(uint256(discount)) / MAXPERMILLE;

            uint256 remainingDiscount = getRemainingDiscount(owner);
            if(feeDiscount > remainingDiscount) {
                feeDiscount = remainingDiscount;
            }
            feeAmount = feeAmount.safeSub(feeDiscount);
        }        
    }

    /**@dev Returns max fee discount that can be accumulated during every term */
    function getMaxTotalDiscount(address owner) public constant returns (uint256) {
        return maxDiscountPerToken.safeMult(token.balanceOf(owner)) / denominator;
    }


    /**@dev Returns remaining discount for the current term */
    function getRemainingDiscount(address owner) public constant returns(uint256) {
        uint256 term = now / termDuration;  //current term #
        uint256 maxTotalDiscount = getMaxTotalDiscount(owner);

        if(totalFeeDiscount[owner][term] < maxTotalDiscount) {
            return maxTotalDiscount - totalFeeDiscount[owner][term];            
        } else {
            return 0;
        }
    }

    /**@dev Returns extended information about remaining discount: discount + timestamp when current term expires */
    function getRemainingDiscountInfo(address owner) public constant returns(uint256, uint256) {
        return (
            getRemainingDiscount(owner), 
            (now / termDuration + 1) * termDuration
        );
    }

    /**@dev Calculates and returns fee amount. Stores calculated discount for the current term  */
    function calculateFeeAmount(address owner, uint256 productId, uint256 payment) public managerOnly returns(uint256) {
        var (feeAmount, feeDiscount) = getFeeDetails(owner, productId, payment);
        
        if(feeDiscount > 0) {
            uint256 term = now / termDuration;
            totalFeeDiscount[owner][term] = totalFeeDiscount[owner][term].safeAdd(feeDiscount);
        }
        
        return feeAmount;
    }

    /**@dev Sends fee amount equal to msg.value to a single fee wallet  */
    function sendFee() public payable {
        feeWallet.transfer(msg.value);
    }

    /**@dev Sets new parameters values */
    function setParams(
        uint16 _defaultFeePermille, 
        uint16 _escrowFeePermille,
        uint16 _fiatPriceFeePermille,
        address _feeWallet,
        IERC20Token _token,
        uint256 _minTokenForDiscount,        
        uint256 _maxDiscountPerToken,
        uint16 _discountPermille
    ) 
        public 
        ownerOnly
        validPermille(_defaultFeePermille)
        validPermille(_escrowFeePermille)
        validPermille(_fiatPriceFeePermille)
        validPermille(_discountPermille)

    {
        require(_defaultFeePermille + _escrowFeePermille + _fiatPriceFeePermille <= 1000);

        defaultFee = _defaultFeePermille;
        escrowFee = _escrowFeePermille;
        fiatPriceFee = _fiatPriceFeePermille;
        feeWallet = _feeWallet;
        token = _token;
        minTokenForDiscount = _minTokenForDiscount;
        maxDiscountPerToken = _maxDiscountPerToken;
        discount = _discountPermille;

        denominator = uint256(10) ** token.decimals();
    }
}
