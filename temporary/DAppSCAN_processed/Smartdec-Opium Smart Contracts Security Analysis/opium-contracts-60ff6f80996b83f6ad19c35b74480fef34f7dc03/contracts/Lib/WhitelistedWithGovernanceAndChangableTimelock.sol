// File: ../sc_datasets/DAppSCAN/Smartdec-Opium Smart Contracts Security Analysis/opium-contracts-60ff6f80996b83f6ad19c35b74480fef34f7dc03/contracts/Lib/Whitelisted.sol

pragma solidity ^0.5.4;

/// @title Opium.Lib.Whitelisted contract implements whitelist with modifier to restrict access to only whitelisted addresses
contract Whitelisted {
    // Whitelist array
    address[] internal whitelist;

    /// @notice This modifier restricts access to functions, which could be called only by whitelisted addresses
    modifier onlyWhitelisted() {
        // Allowance flag
        bool allowed = false;

        // Going through whitelisted addresses array
        for (uint256 i = 0; i < whitelist.length; i++) {
            // If `msg.sender` is met within whitelisted addresses, raise the flag and exit the loop
            if (whitelist[i] == msg.sender) {
                allowed = true;
                break;
            }
        }

        // Check if flag was raised
        require(allowed, "Only whitelisted allowed");
        _;
    }

    /// @notice Getter for whitelisted addresses array
    /// @return Array of whitelisted addresses
    function getWhitelist() public view returns (address[] memory) {
        return whitelist;
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-Opium Smart Contracts Security Analysis/opium-contracts-60ff6f80996b83f6ad19c35b74480fef34f7dc03/contracts/Lib/WhitelistedWithGovernance.sol

pragma solidity ^0.5.4;

/// @title Opium.Lib.WhitelistedWithGovernance contract implements Opium.Lib.Whitelisted and adds governance for whitelist controlling
contract WhitelistedWithGovernance is Whitelisted {
    // Emitted when new governor is set
    event GovernorSet(address governor);

    // Emitted when new whitelist is proposed
    event Proposed(address[] whitelist);
    // Emitted when proposed whitelist is committed (set)
    event Committed(address[] whitelist);

    // Proposal life timelock interval
    uint256 public TIME_LOCK_INTERVAL;

    // Governor address
    address public governor;

    // Contract initialization flag
    bool public initialized = false;

    // Timestamp of last proposal
    uint256 public proposalTime = 0;
    // Proposed whitelist
    address[] public proposedWhitelist;

    /// @notice This modifier restricts access to functions, which could be called only by governor
    modifier onlyGovernor() {
        require(msg.sender == governor, "Only governor allowed");
        _;
    }

    /// @notice Contract constructor
    /// @param _timeLockInterval uint256 Initial value for timelock interval
    /// @param _governor address Initial value for governor
    constructor(uint256 _timeLockInterval, address _governor) public {
        TIME_LOCK_INTERVAL = _timeLockInterval;
        governor = _governor;
        emit GovernorSet(governor);
    }

    /// @notice Calling this function governor could propose new whitelist addresses array. Also it allows to initialize first whitelist if it was not initialized yet.
    function proposeWhitelist(address[] memory _whitelist) public onlyGovernor {
        // Restrict empty proposals
        require(_whitelist.length != 0, "Can't be empty");

        // If whitelist has never been initialized, we set whitelist right away without proposal
        if (!initialized) {
            initialized = true;
            whitelist = _whitelist;
            emit Committed(whitelist);

        // Otherwise save current time as timestamp of proposal, save proposed whitelist and emit event
        } else {
            proposalTime = now;
            proposedWhitelist = _whitelist;
            emit Proposed(proposedWhitelist);
        }
    }

    /// @notice Calling this function governor commits proposed whitelist if timelock interval of proposal was passed
    function commitWhitelist() public onlyGovernor {
        // Check if proposal was made
        require(proposalTime != 0, "Didn't proposed yet");

        // Check if timelock interval was passed
        require((proposalTime + TIME_LOCK_INTERVAL) < now, "Can't commit yet");
        
        // Set new whitelist and emit event
        whitelist = proposedWhitelist;
        emit Committed(whitelist);

        // Reset proposal time lock
        proposalTime = 0;
    }

    /// @notice This function allows governor to transfer governance to a new governor and emits event
    /// @param _governor address Address of new governor
    function setGovernor(address _governor) public onlyGovernor {
        governor = _governor;
        emit GovernorSet(governor);
    }
}

// File: ../sc_datasets/DAppSCAN/Smartdec-Opium Smart Contracts Security Analysis/opium-contracts-60ff6f80996b83f6ad19c35b74480fef34f7dc03/contracts/Lib/WhitelistedWithGovernanceAndChangableTimelock.sol

pragma solidity ^0.5.4;

/// @notice Opium.Lib.WhitelistedWithGovernanceAndChangableTimelock contract implements Opium.Lib.WhitelistedWithGovernance and adds possibility for governor to change timelock interval within timelock interval
contract WhitelistedWithGovernanceAndChangableTimelock is WhitelistedWithGovernance {
    // Emitted when new timelock is proposed
    event Proposed(uint256 timelock);
    // Emitted when new timelock is committed (set)
    event Committed(uint256 timelock);

    // Timestamp of last timelock proposal
    uint256 timelockProposalTime = 0;
    // Proposed timelock
    uint256 proposedTimelock = 0;

    /// @notice Calling this function governor could propose new timelock
    /// @param _timelock uint256 New timelock value
    function proposeTimelock(uint256 _timelock) public onlyGovernor {
        timelockProposalTime = now;
        proposedTimelock = _timelock;
        emit Proposed(_timelock);
    }

    /// @notice Calling this function governor could commit previously proposed new timelock if timelock interval of proposal was passed
    function commitTimelock() public onlyGovernor {
        // Check if proposal was made
        require(timelockProposalTime != 0, "Didn't proposed yet");
        // Check if timelock interval was passed
        require((timelockProposalTime + TIME_LOCK_INTERVAL) < now, "Can't commit yet");
        
        // Set new timelock and emit event
        TIME_LOCK_INTERVAL = proposedTimelock;
        emit Committed(proposedTimelock);

        // Reset timelock time lock
        timelockProposalTime = 0;
    }
}
