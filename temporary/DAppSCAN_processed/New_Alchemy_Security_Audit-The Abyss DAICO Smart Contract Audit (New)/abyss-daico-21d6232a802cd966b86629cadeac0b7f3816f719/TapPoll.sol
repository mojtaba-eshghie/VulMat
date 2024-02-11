// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/math/SafeMath.sol

pragma solidity ^0.4.21;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
contract SafeMath {
    /**
    * @dev constructor
    */
    function SafeMath() public {
    }

    function safeMul(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function safeDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    function safeSub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(a >= b);
        return a - b;
    }

    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/token/IERC20Token.sol

pragma solidity ^0.4.21;


/**
 * @title IERC20Token - ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract IERC20Token {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    function balanceOf(address _owner) public constant returns (uint256 balance);
    function transfer(address _to, uint256 _value)  public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value)  public returns (bool success);
    function approve(address _spender, uint256 _value)  public returns (bool success);
    function allowance(address _owner, address _spender)  public constant returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/poll/BasePoll.sol

pragma solidity ^0.4.21;


/**
 * @title BasePoll
 * @dev Abstract base class for polling contracts
 */
contract BasePoll is SafeMath {
    struct Vote {
        uint256 time;
        uint256 weight;
        bool agree;
    }

    uint256 public constant MAX_TOKENS_WEIGHT_DENOM = 1000;

    IERC20Token public token;
    address public fundAddress;

    uint256 public startTime;
    uint256 public endTime;
    bool checkTransfersAfterEnd;

    uint256 public yesCounter = 0;
    uint256 public noCounter = 0;
    uint256 public totalVoted = 0;

    bool public finalized;
    mapping(address => Vote) public votesByAddress;

    modifier checkTime() {
        require(now >= startTime && now <= endTime);
        _;
    }

    modifier notFinalized() {
        require(!finalized);
        _;
    }

    /**
     * @dev BasePoll constructor
     * @param _tokenAddress ERC20 compatible token contract address
     * @param _fundAddress Fund contract address
     * @param _startTime Poll start time
     * @param _endTime Poll end time
     */
    function BasePoll(address _tokenAddress, address _fundAddress, uint256 _startTime, uint256 _endTime, bool _checkTransfersAfterEnd) public {
        require(_tokenAddress != address(0));
        require(_startTime >= now && _endTime > _startTime);

        token = IERC20Token(_tokenAddress);
        fundAddress = _fundAddress;
        startTime = _startTime;
        endTime = _endTime;
        finalized = false;
        checkTransfersAfterEnd = _checkTransfersAfterEnd;
    }

    /**
     * @dev Process user`s vote
     * @param agree True if user endorses the proposal else False
     */
    function vote(bool agree) public checkTime {
        require(votesByAddress[msg.sender].time == 0);

        uint256 voiceWeight = token.balanceOf(msg.sender);
        uint256 maxVoiceWeight = safeDiv(token.totalSupply(), MAX_TOKENS_WEIGHT_DENOM);
        voiceWeight =  voiceWeight <= maxVoiceWeight ? voiceWeight : maxVoiceWeight;

        if(agree) {
            yesCounter = safeAdd(yesCounter, voiceWeight);
        } else {
            noCounter = safeAdd(noCounter, voiceWeight);

        }

        votesByAddress[msg.sender].time = now;
        votesByAddress[msg.sender].weight = voiceWeight;
        votesByAddress[msg.sender].agree = agree;

        totalVoted = safeAdd(totalVoted, 1);
    }

    /**
     * @dev Revoke user`s vote
     */
    function revokeVote() public checkTime {
        require(votesByAddress[msg.sender].time > 0);

        uint256 voiceWeight = votesByAddress[msg.sender].weight;
        bool agree = votesByAddress[msg.sender].agree;

        votesByAddress[msg.sender].time = 0;
        votesByAddress[msg.sender].weight = 0;
        votesByAddress[msg.sender].agree = false;

        totalVoted = safeSub(totalVoted, 1);
        if(agree) {
            yesCounter = safeSub(yesCounter, voiceWeight);
        } else {
            noCounter = safeSub(noCounter, voiceWeight);
        }
    }

    /**
     * @dev Function is called after token transfer from user`s wallet to check and correct user`s vote
     *
     */
    function onTokenTransfer(address tokenHolder, uint256 amount) public {
        require(msg.sender == fundAddress);
        if(votesByAddress[tokenHolder].time == 0) {
            return;
        }
        if(!checkTransfersAfterEnd) {
             if(finalized || (now < startTime || now > endTime)) {
                 return;
             }
        }

        if(token.balanceOf(tokenHolder) >= votesByAddress[tokenHolder].weight) {
            return;
        }
        uint256 voiceWeight = amount;
        if(amount > votesByAddress[tokenHolder].weight) {
            voiceWeight = votesByAddress[tokenHolder].weight;
        }

        if(votesByAddress[tokenHolder].agree) {
            yesCounter = safeSub(yesCounter, voiceWeight);
        } else {
            noCounter = safeSub(noCounter, voiceWeight);
        }
        votesByAddress[tokenHolder].weight = safeSub(votesByAddress[tokenHolder].weight, voiceWeight);
    }

    /**
     * Finalize poll and call onPollFinish callback with result
     */
    function tryToFinalize() public notFinalized returns(bool) {
        if(now < endTime) {
            return false;
        }
        finalized = true;
        onPollFinish(isSubjectApproved());
        return true;
    }

    function isNowApproved() public view returns(bool) {
        return isSubjectApproved();
    }

    function isSubjectApproved() internal view returns(bool) {
        return yesCounter > noCounter;
    }

    /**
     * @dev callback called after poll finalization
     */
    function onPollFinish(bool agree) internal;
}

// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/fund/IPollManagedFund.sol

pragma solidity ^0.4.21;

/**
 * @title IPollManagedFund
 * @dev Fund callbacks used by polling contracts
 */
interface IPollManagedFund {
    /**
     * @dev TapPoll callback
     * @param agree True if new tap value is accepted by majority of contributors
     * @param _tap New tap value
     */
    function onTapPollFinish(bool agree, uint256 _tap) external;

    /**
     * @dev RefundPoll callback
     * @param agree True if contributors decided to allow refunding
     */
    function onRefundPollFinish(bool agree) external;
}

// File: ../sc_datasets/DAppSCAN/New_Alchemy_Security_Audit-The Abyss DAICO Smart Contract Audit (New)/abyss-daico-21d6232a802cd966b86629cadeac0b7f3816f719/TapPoll.sol

pragma solidity ^0.4.21;


/**
 * @title TapPoll
 * @dev Poll to increase tap amount
 */
contract TapPoll is BasePoll {
    uint256 public tap;
    uint256 public minTokensPerc = 0;

    /**
     * TapPoll constructor
     * @param _tap New tap value
     * @param _tokenAddress ERC20 compatible token contract address
     * @param _fundAddress Fund contract address
     * @param _startTime Poll start time
     * @param _endTime Poll end time
     * @param _minTokensPerc - Min percent of tokens from totalSupply where poll is considered to be fulfilled
     */
    function TapPoll(
        uint256 _tap,
        address _tokenAddress,
        address _fundAddress,
        uint256 _startTime,
        uint256 _endTime,
        uint256 _minTokensPerc
    ) public
        BasePoll(_tokenAddress, _fundAddress, _startTime, _endTime, false)
    {
        tap = _tap;
        minTokensPerc = _minTokensPerc;
    }

    function onPollFinish(bool agree) internal {
        IPollManagedFund fund = IPollManagedFund(fundAddress);
        fund.onTapPollFinish(agree, tap);
    }

    function getVotedTokensPerc() public view returns(uint256) {
        return safeDiv(safeMul(safeAdd(yesCounter, noCounter), 100), token.totalSupply());
    }

    function isSubjectApproved() internal view returns(bool) {
        return yesCounter > noCounter && getVotedTokensPerc() >= minTokensPerc;
    }
}
