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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-EasyPool Smart Contract Security Audit/EasyPool-master/contracts/library/QuotaLib.sol

pragma solidity ^0.4.24;

/**
 * @title QuotaLib 
 */
library QuotaLib {    
    using SafeMath for uint;

    /**     
     * @dev Quota storage structure. Holds information about 
     * total amount claimed and claimed shares per address.
     */
    struct Storage {
        mapping (address => uint) claimedShares;
        uint claimedAmount;
    }

    /**     
     * @dev Calculate and claim share.
     */
    function claimShare(Storage storage self, address addr, uint currentAmount, uint[2] fraction) internal returns (uint) {
        uint share = calcShare(self, addr, currentAmount, fraction);
        self.claimedShares[addr] = self.claimedShares[addr].add(share);
        self.claimedAmount = self.claimedAmount.add(share);
        return share;
    }

    /**     
     * @dev Calculate share.
     */
    function calcShare(Storage storage self, address addr, uint currentAmount, uint[2] fraction) internal view returns (uint) {
        uint totalShare = share(currentAmount.add(self.claimedAmount), fraction);
        uint claimedShare = self.claimedShares[addr];        
        assert(totalShare >= claimedShare);
        if(totalShare == claimedShare) {
            return 0;
        }        
        return totalShare - claimedShare;
    }    

    /**     
     * @dev Undo claim.
     */
    function undoClaimShare(Storage storage self, address addr, uint amount) internal {
        assert(self.claimedShares[addr] >= amount);
        self.claimedShares[addr] -= amount;
        self.claimedAmount -= amount;
    }

    /**     
     * @dev ...
     */
    function share(uint amount, uint[2] fraction) private pure returns (uint) {
        return amount.mul(fraction[0]).div(fraction[1]);
    }
}
