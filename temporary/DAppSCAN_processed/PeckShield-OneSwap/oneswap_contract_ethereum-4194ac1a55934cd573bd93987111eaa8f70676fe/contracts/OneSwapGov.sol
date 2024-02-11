// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/interfaces/IERC20.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/interfaces/IOneSwapToken.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface IOneSwapBlackList {
    event OwnerChanged(address);
    event AddedBlackLists(address[]);
    event RemovedBlackLists(address[]);

    function owner()external view returns (address);
    function isBlackListed(address)external view returns (bool);

    function changeOwner(address newOwner) external;
    function addBlackLists(address[] calldata  accounts)external;
    function removeBlackLists(address[] calldata  accounts)external;
}

interface IOneSwapToken is IERC20, IOneSwapBlackList{
    function burn(uint256 amount) external;
    function burnFrom(address account, uint256 amount) external;
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
    function multiTransfer(uint256[] calldata mixedAddrVal) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/interfaces/IOneSwapGov.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface IOneSwapGov {
    event NewFundsProposal(uint64 proposalID, string title, string desc, string url, uint32 deadline, uint32 amount, address beneficiary);
    event NewParamProposal(uint64 proposalID, string title, string desc, string url, uint32 deadline, uint32 feeBPS, address factory);
    event NewTextProposal(uint64 proposalID, string title, string desc, string url, uint32 deadline);
    event NewVote(uint64 proposalID, address voter, uint8 opinion);
    event TallyResult(uint64 proposalID, bool pass);

    function ones() external pure returns (address);
    function numProposals() external view returns (uint64);
    function proposals(uint64 proposalID) external view returns (address addr, uint32 deadline, uint32 value, uint8 _type);
    function lastVoter(uint64 proposalID) external view returns (address);
    function votes(uint64 proposalID, address voter) external view returns (uint8 opinion, address prevVoter);

    function submitFundsProposal(string calldata title, string calldata desc, string calldata url, uint32 amount, address beneficiary) external;
    function submitParamProposal(string calldata title, string calldata desc, string calldata url, uint32 feeBPS, address factory) external;
    function submitTextProposal(string calldata title, string calldata desc, string calldata url) external;
    function vote(uint64 proposalID, uint8 opinion) external;
    function revote(uint64 proposalID, uint8 opinion) external;
    function tally(uint64 proposalID, uint64 maxEntry) external;
}

// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/interfaces/IOneSwapFactory.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

interface IOneSwapFactory {
    event PairCreated(address indexed pair, address stock, address money, bool isOnlySwap);

    function createPair(address stock, address money, bool isOnlySwap) external returns (address pair);
    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
    function setFeeBPS(uint32 bps) external;

    function allPairsLength() external view returns (uint);
    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function feeBPS() external view returns (uint32);
    function getTokensFromPair(address pair) external view returns (address stock, address money);
    function tokensToPair(address stock, address money, bool isOnlySwap) external view returns (address pair);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-OneSwap/oneswap_contract_ethereum-4194ac1a55934cd573bd93987111eaa8f70676fe/contracts/OneSwapGov.sol

// SPDX-License-Identifier: GPL
pragma solidity ^0.6.6;



contract OneSwapGov is IOneSwapGov {

    struct Proposal {    // FUNDS            | PARAM        | TEXT
        address addr;    // beneficiary addr | factory addr | N/A
        uint32 deadline; // unix timestamp   | same         | same
        uint32 value;    // amount of funds  | feeBPS       | N/A
        uint8 _type;     // proposal type    | same         | same
    }
    struct Vote {
        uint8 opinion;
        address prevVoter;
    }

    uint64 private constant _MAX_UINT64 = uint64(-1);
    uint8 private constant _PROPOSAL_TYPE_FUNDS = 0;
    uint8 private constant _PROPOSAL_TYPE_PARAM = 1;
    uint8 private constant _PROPOSAL_TYPE_TEXT  = 2;
    uint32 private constant _MIN_FEE_BPS = 0;
    uint32 private constant _MAX_FEE_BPS = 50;

    uint8 private constant _YES = 1;
    uint8 private constant _NO  = 2;

    uint private constant _VOTE_PERIOD = 3 days;
    uint private constant _SUBMIT_ONES_PERCENT = 1;

    address public immutable override ones;

    uint64 public override numProposals;
    mapping (uint64 => Proposal) public override proposals;
    mapping (uint64 => address) public override lastVoter;
    mapping (uint64 => mapping (address => Vote)) public override votes;
    mapping (uint64 => uint) private _yesCoins;
    mapping (uint64 => uint) private _noCoins;

    constructor(address _ones) public {
        ones = _ones;
        // numProposals = 0;
    }

    // submit new proposals
    function submitFundsProposal(string calldata title, string calldata desc, string calldata url,
            uint32 amount, address beneficiary) external override {
        if (amount > 0) {
            uint govCoins = IERC20(ones).balanceOf(address(this));
            uint dec = IERC20(ones).decimals();
            require(govCoins >= uint(amount) * (10 ** dec), "OneSwapGov: AMOUNT_TOO_LARGE");
        }
        (uint64 proposalID, uint32 deadline) = _newProposal(_PROPOSAL_TYPE_FUNDS, beneficiary, amount);
        emit NewFundsProposal(proposalID, title, desc, url, deadline, amount, beneficiary);
    }
    function submitParamProposal(string calldata title, string calldata desc, string calldata url,
            uint32 feeBPS, address factory) external override {
        require(feeBPS >= _MIN_FEE_BPS && feeBPS <= _MAX_FEE_BPS, "OneSwapGov: INVALID_FEE_BPS");
        (uint64 proposalID, uint32 deadline) = _newProposal(_PROPOSAL_TYPE_PARAM, factory, feeBPS);
        emit NewParamProposal(proposalID, title, desc, url, deadline, feeBPS, factory);
    }
    function submitTextProposal(string calldata title, string calldata desc, string calldata url) external override {
        (uint64 proposalID, uint32 deadline) = _newProposal(_PROPOSAL_TYPE_TEXT, address(0), 0);
        emit NewTextProposal(proposalID, title, desc, url, deadline);
    }

    function _newProposal(uint8 _type, address addr, uint32 value) private returns (uint64 proposalID, uint32 deadline) {
        require(_type >= _PROPOSAL_TYPE_FUNDS && _type <= _PROPOSAL_TYPE_TEXT,
            "OneSwapGov: INVALID_PROPOSAL_TYPE");

        uint totalCoins = IERC20(ones).totalSupply();
        uint thresCoins = (totalCoins/100) * _SUBMIT_ONES_PERCENT;
        uint senderCoins = IERC20(ones).balanceOf(msg.sender);

        // the sender must have enough coins
        require(senderCoins >= thresCoins, "OneSwapGov: NOT_ENOUGH_ONES");

        proposalID = numProposals;
        numProposals = numProposals+1;
        // solhint-disable-next-line not-rely-on-time
        deadline = uint32(block.timestamp + _VOTE_PERIOD);

        Proposal memory proposal;
        proposal._type = _type;
        proposal.deadline = deadline;
        proposal.addr = addr;
        proposal.value = value;
        proposals[proposalID] = proposal;

        lastVoter[proposalID] = msg.sender;
        Vote memory v;
        v.opinion = _YES;
        v.prevVoter = address(0);
        votes[proposalID][msg.sender] = v;
    }

    // Have never voted before, vote for the first time
    function vote(uint64 id, uint8 opinion) external override {
        uint balance = IERC20(ones).balanceOf(msg.sender);
        require(balance > 0, "OneSwapGov: NO_ONES");

        Proposal memory proposal = proposals[id];
        require(proposal.deadline != 0, "OneSwapGov: NO_PROPOSAL");
        // solhint-disable-next-line not-rely-on-time
        require(uint(proposal.deadline) >= block.timestamp, "OneSwapGov: DEADLINE_REACHED");

        require(_YES<=opinion && opinion<=_NO, "OneSwapGov: INVALID_OPINION");
        Vote memory v = votes[id][msg.sender];
        require(v.opinion == 0, "OneSwapGov: ALREADY_VOTED");

        v.prevVoter = lastVoter[id];
        v.opinion = opinion;
        votes[id][msg.sender] = v;

        lastVoter[id] = msg.sender;

        emit NewVote(id, msg.sender, opinion);
    }

    // Have ever voted before, need to change my opinion
    function revote(uint64 id, uint8 opinion) external override {
        require(_YES<=opinion && opinion<=_NO, "OneSwapGov: INVALID_OPINION");

        Proposal memory proposal = proposals[id];
        require(proposal.deadline != 0, "OneSwapGov: NO_PROPOSAL");
        // solhint-disable-next-line not-rely-on-time
        require(uint(proposal.deadline) >= block.timestamp, "OneSwapGov: DEADLINE_REACHED");

        Vote memory v = votes[id][msg.sender];
        // should have voted before
        require(v.opinion != 0, "OneSwapGov: NOT_VOTED");
        v.opinion = opinion;
        votes[id][msg.sender] = v;

        emit NewVote(id, msg.sender, opinion);
    }

    // Count the votes, if the result is "Pass", transfer coins to the beneficiary
    function tally(uint64 proposalID, uint64 maxEntry) external override {
        Proposal memory proposal = proposals[proposalID];
        require(proposal.deadline != 0, "OneSwapGov: NO_PROPOSAL");
        // solhint-disable-next-line not-rely-on-time
        require(uint(proposal.deadline) <= block.timestamp, "OneSwapGov: DEADLINE_NOT_REACHED");
        require(maxEntry == _MAX_UINT64 || (maxEntry > 0 && msg.sender == IOneSwapToken(ones).owner()),
            "OneSwapGov: INVALID_MAX_ENTRY");

        address currVoter = lastVoter[proposalID];
        require(currVoter != address(0), "OneSwapGov: NO_LAST_VOTER");
        uint yesCoinsSum = _yesCoins[proposalID];
        uint yesCoinsOld = yesCoinsSum;
        uint noCoinsSum = _noCoins[proposalID];
        uint noCoinsOld = noCoinsSum;

        for (uint64 i=0; i < maxEntry && currVoter != address(0); i++) {
            Vote memory v = votes[proposalID][currVoter];
            if(v.opinion == _YES) {
                yesCoinsSum += IERC20(ones).balanceOf(currVoter);
            }
            if(v.opinion == _NO) {
                noCoinsSum += IERC20(ones).balanceOf(currVoter);
            }
            delete votes[proposalID][currVoter];
            currVoter = v.prevVoter;
        }

        if (currVoter != address(0)) {
            lastVoter[proposalID] = currVoter;
            if (yesCoinsSum != yesCoinsOld) {
                _yesCoins[proposalID] = yesCoinsSum;
            }
            if (noCoinsSum != noCoinsOld) {
                _noCoins[proposalID] = noCoinsSum;
            }
        } else {
            bool ok = yesCoinsSum > noCoinsSum;
            delete proposals[proposalID];
            delete lastVoter[proposalID];
            delete _yesCoins[proposalID];
            delete _noCoins[proposalID];
            if (ok) {
                if (proposal._type == _PROPOSAL_TYPE_FUNDS) {
                    if (proposal.value > 0) {
                        uint dec = IERC20(ones).decimals();
                        IERC20(ones).transfer(proposal.addr, proposal.value * (10 ** dec));
                    }
                } else if (proposal._type == _PROPOSAL_TYPE_PARAM) {
                    IOneSwapFactory(proposal.addr).setFeeBPS(proposal.value);
                }
            }
            emit TallyResult(proposalID, ok);
        }
    }

}
