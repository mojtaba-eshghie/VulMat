// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// File: @openzeppelin/contracts-ethereum-package/contracts/Initializable.sol

pragma solidity >=0.4.24 <0.7.0;


/**
 * @title Initializable
 *
 * @dev Helper contract to support initializer functions. To use it, replace
 * the constructor with a function that has the `initializer` modifier.
 * WARNING: Unlike constructors, initializer functions must be manually
 * invoked. This applies both to deploying an Initializable contract, as well
 * as extending an Initializable contract via inheritance.
 * WARNING: When used with inheritance, manual care must be taken to not invoke
 * a parent initializer twice, or ensure that all initializers are idempotent,
 * because this is not dealt with automatically as with constructors.
 */
contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol

pragma solidity ^0.6.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
contract ReentrancyGuardUpgradeSafe is Initializable {
    bool private _notEntered;


    function __ReentrancyGuard_init() internal initializer {
        __ReentrancyGuard_init_unchained();
    }

    function __ReentrancyGuard_init_unchained() internal initializer {


        // Storing an initial non-zero value makes deployment a bit more
        // expensive, but in exchange the refund on every call to nonReentrant
        // will be lower in amount. Since refunds are capped to a percetange of
        // the total transaction's gas, it is best to keep them low in cases
        // like this one, to increase the likelihood of the full refund coming
        // into effect.
        _notEntered = true;

    }


    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_notEntered, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _notEntered = false;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _notEntered = true;
    }

    uint256[49] private __gap;
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-hermez/contracts-d52ed73a0c7deaf06fcb0f981e14326f95cd1b78/contracts/withdrawalDelayer/WithdrawalDelayer.sol

// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.6.12;



contract WithdrawalDelayer is Initializable, ReentrancyGuardUpgradeSafe {
    struct DepositState {
        uint192 amount;
        uint64 depositTimestamp;
    }
    bytes4 private constant _TRANSFER_SIGNATURE = bytes4(
        keccak256(bytes("transfer(address,uint256)"))
    );
    bytes4 private constant _TRANSFERFROM_SIGNATURE = bytes4(
        keccak256(bytes("transferFrom(address,address,uint256)"))
    );
    bytes4 private constant _DEPOSIT_SIGNATURE = bytes4(
        keccak256(bytes("deposit(address,address,uint192)"))
    );

    uint64 public constant MAX_WITHDRAWAL_DELAY = 2 weeks; // Maximum time that the return of funds can be delayed
    uint64 public constant MAX_EMERGENCY_MODE_TIME = 26 weeks; // Maximum time in a state of emergency before a
    // resolution and after which the WHG can redeem the funds
    uint64 private _withdrawalDelay; // Current delay
    uint64 private _emergencyModeStartingTime; // When emergency mode has started
    address private _hermezGovernanceDAOAddress; // Governance DAO who control the system parameters
    address payable private _whiteHackGroupAddress; // WHG address who can redeem the funds after MAX_EMERGENCY_MODE_TIME
    address private _hermezKeeperAddress; // Can enable the emergency mode
    bool private _emergencyMode; // bool to set the emergency mode
    address public hermezRollupAddress; // hermez Rollup Address who can send funds to this smart contract
    mapping(bytes32 => DepositState) public deposits; // Mapping to keep track of deposits

    event Deposit(
        address indexed owner,
        address indexed token,
        uint192 amount,
        uint64 depositTimestamp
    );
    event Withdraw(
        address indexed token,
        address indexed owner,
        uint192 amount
    );
    event EmergencyModeEnabled();
    event NewWithdrawalDelay(uint64 withdrawalDelay);
    event EscapeHatchWithdrawal(
        address indexed who,
        address indexed to,
        address indexed token,
        uint256 amount
    );
    event NewHermezKeeperAddress(address newHermezKeeperAddress);
    event NewWhiteHackGroupAddress(address newWhiteHackGroupAddress);
    event NewHermezGovernanceDAOAddress(address newHermezGovernanceDAOAddress);

    /**
     * @notice withdrawalDelayerInitializer (Constructor)
     * @param _initialWithdrawalDelay Initial withdrawal delay time in seconds to be able to withdraw the funds
     * @param _initialHermezRollup Smart contract responsible of making deposits and it's able to change the delay
     * @param _initialHermezKeeperAddress can enable emergency mode and modify the delay to make a withdrawal
     * @param _initialHermezGovernanceDAOAddress can claim the funds in an emergency mode
     * @param _initialWhiteHackGroupAddress can claim the funds in an emergency and MAX_EMERGENCY_MODE_TIME exceeded
     */
    // SWC-Transaction Order Dependence: L68 - L82
    function withdrawalDelayerInitializer(
        uint64 _initialWithdrawalDelay,
        address _initialHermezRollup,
        address _initialHermezKeeperAddress,
        address _initialHermezGovernanceDAOAddress,
        address payable _initialWhiteHackGroupAddress
    ) public initializer {
        __ReentrancyGuard_init_unchained();
        _withdrawalDelay = _initialWithdrawalDelay;
        hermezRollupAddress = _initialHermezRollup;
        _hermezKeeperAddress = _initialHermezKeeperAddress;
        _hermezGovernanceDAOAddress = _initialHermezGovernanceDAOAddress;
        _whiteHackGroupAddress = _initialWhiteHackGroupAddress;
        _emergencyMode = false;
    }

    /**
     * @notice Getter of the current `_hermezGovernanceDAOAddress`
     * @return The `_hermezGovernanceDAOAddress` value
     */
    function getHermezGovernanceDAOAddress() external view returns (address) {
        return _hermezGovernanceDAOAddress;
    }

    /**
     * @notice Allows to change the `_hermezGovernanceDAOAddress` if it's called by `_hermezGovernanceDAOAddress`
     * @param newAddress new `_hermezGovernanceDAOAddress`
     */
    function setHermezGovernanceDAOAddress(address newAddress) external {
        require(
            msg.sender == _hermezGovernanceDAOAddress,
            "WithdrawalDelayer::setHermezGovernanceDAOAddress: ONLY_GOVERNANCE"
        );
        _hermezGovernanceDAOAddress = newAddress;
        emit NewHermezGovernanceDAOAddress(_hermezGovernanceDAOAddress);
    }

    /**
     * @notice Getter of the current `_hermezKeeperAddress`
     * @return The `_hermezKeeperAddress` value
     */
    function getHermezKeeperAddress() external view returns (address) {
        return _hermezKeeperAddress;
    }

    /**
     * @notice Allows to change the `_hermezKeeperAddress` if it's called by `_hermezKeeperAddress`
     * @param newAddress `_hermezKeeperAddress`
     */
    function setHermezKeeperAddress(address newAddress) external {
        require(
            msg.sender == _hermezKeeperAddress,
            "WithdrawalDelayer::setHermezGovernanceDAOAddress: ONLY_KEEPER"
        );
        _hermezKeeperAddress = newAddress;
        emit NewHermezKeeperAddress(_hermezKeeperAddress);
    }

    /**
     * @notice Getter of the current `_whiteHackGroupAddress`
     * @return The `_whiteHackGroupAddress` value
     */
    function getWhiteHackGroupAddress() external view returns (address) {
        return _whiteHackGroupAddress;
    }

    /**
     * @notice Allows to change the `_whiteHackGroupAddress` if it's called by `_whiteHackGroupAddress`
     * @param newAddress new `_whiteHackGroupAddress`
     */
    function setWhiteHackGroupAddress(address payable newAddress) external {
        require(
            msg.sender == _whiteHackGroupAddress,
            "WithdrawalDelayer::setHermezGovernanceDAOAddress: ONLY_WHG"
        );
        _whiteHackGroupAddress = newAddress;
        emit NewWhiteHackGroupAddress(_whiteHackGroupAddress);
    }

    /**
     * @notice Getter of the current `_emergencyMode` status to know if the emergency mode is enable or disable
     * @return The `_emergencyMode` value
     */
    function isEmergencyMode() external view returns (bool) {
        return _emergencyMode;
    }

    /**
     * @notice Getter to obtain the current withdrawal delay
     * @return the current withdrawal delay time in seconds: `_withdrawalDelay`
     */
    function getWithdrawalDelay() external view returns (uint128) {
        return _withdrawalDelay;
    }

    /**
     * @notice Getter to obtain when emergency mode started
     * @return the emergency mode starting time in seconds: `_emergencyModeStartingTime`
     */
    function getEmergencyModeStartingTime() external view returns (uint128) {
        return _emergencyModeStartingTime;
    }

    /**
     * @notice This function enables the emergency mode. Only the keeper of the system can enable this mode. This cannot
     * be deactivated in any case so it will be irreversible.
     * @dev The activation time is saved in `_emergencyModeStartingTime` and this function can only be called
     * once if it has not been previously activated.
     * Events: `EmergencyModeEnabled` event.
     */
    function enableEmergencyMode() external {
        require(
            msg.sender == _hermezKeeperAddress,
            "WithdrawalDelayer::enableEmergencyMode: ONLY_KEEPER"
        );
        require(
            !_emergencyMode,
            "WithdrawalDelayer::enableEmergencyMode: ALREADY_ENABLED"
        );
        _emergencyMode = true;
        /* solhint-disable not-rely-on-time */
        _emergencyModeStartingTime = uint64(now);
        emit EmergencyModeEnabled();
    }

    /**
     * @notice This function allows the HermezKeeperAddress to change the withdrawal delay time, this is the time that
     * anyone needs to wait until a withdrawal of the funds is allowed. Since this time is calculated at the time of
     * withdrawal, this change affects existing deposits. Can never exceed `MAX_WITHDRAWAL_DELAY`
     * @dev It changes `_withdrawalDelay` if `_newWithdrawalDelay` it is less than or equal to MAX_WITHDRAWAL_DELAY
     * @param _newWithdrawalDelay new delay time in seconds
     * Events: `NewWithdrawalDelay` event.
     */
    function changeWithdrawalDelay(uint64 _newWithdrawalDelay) external {
        require(
            (msg.sender == _hermezKeeperAddress) ||
                (msg.sender == hermezRollupAddress),
            "Only hermez keeper or rollup"
        );
        require(
            _newWithdrawalDelay <= MAX_WITHDRAWAL_DELAY,
            "Exceeds MAX_WITHDRAWAL_DELAY"
        );
        _withdrawalDelay = _newWithdrawalDelay;
        emit NewWithdrawalDelay(_withdrawalDelay);
    }

    /**
     * Returns the balance and the timestamp for a specific owner and token
     * @param _owner who can claim the deposit once the delay time has expired (if not in emergency mode)
     * @param _token address of the token to withdrawal (0x0 in case of Ether)
     * @return `amount` Total amount withdrawable (if not in emergency mode)
     * @return `depositTimestamp` Moment at which funds were deposited
     */
    function depositInfo(address payable _owner, address _token)
        external
        view
        returns (uint192, uint64)
    {
        DepositState memory ds = deposits[keccak256(
            abi.encodePacked(_owner, _token)
        )];
        return (ds.amount, ds.depositTimestamp);
    }

    /**
     * Function to make a deposit in the WithdrawalDelayer smartcontract, only the Hermez rollup smartcontract can do it
     * @dev In case of an Ether deposit, the address `0x0` will be used and the corresponding amount must be sent in the
     * `msg.value`. In case of an ERC20 this smartcontract must have the approval to expend the token to
     * deposit to be able to make a transferFrom to itself.
     * @param _owner is who can claim the deposit once the withdrawal delay time has been exceeded
     * @param _token address of the token deposited (`0x0` in case of Ether)
     * @param _amount deposit amount
     * Events: `Deposit`
     */
    function deposit(
        address _owner,
        address _token,
        uint192 _amount
    ) external payable nonReentrant {
        require(
            msg.sender == hermezRollupAddress,
            "WithdrawalDelayer::deposit: ONLY_ROLLUP"
        );
        if (msg.value != 0) {
            require(
                _token == address(0x0),
                "WithdrawalDelayer::deposit: WRONG_TOKEN_ADDRESS"
            );
            require(
                _amount == msg.value,
                "WithdrawalDelayer::deposit: WRONG_AMOUNT"
            );
        } else {
            require(
                IERC20(_token).allowance(hermezRollupAddress, address(this)) >=
                    _amount,
                "WithdrawalDelayer::deposit: NOT_ENOUGH_ALLOWANCE"
            );
            /* solhint-disable avoid-low-level-calls */
            (bool success, bytes memory data) = address(_token).call(
                abi.encodeWithSelector(
                    _TRANSFERFROM_SIGNATURE,
                    hermezRollupAddress,
                    address(this),
                    _amount
                )
            );
            // `transferFrom` method may return (bool) or nothing.
            require(
                success && (data.length == 0 || abi.decode(data, (bool))),
                "WithdrawalDelayer::deposit: TOKEN_TRANSFER_FAILED"
            );
        }
        _processDeposit(_owner, _token, _amount);
    }

    /**
     * @notice Internal call to make a deposit
     * @param _owner is who can claim the deposit once the withdrawal delay time has been exceeded
     * @param _token address of the token deposited (`0x0` in case of Ether)
     * @param _amount deposit amount
     * Events: `Deposit`
     */
    function _processDeposit(
        address _owner,
        address _token,
        uint192 _amount
    ) internal {
        // We identify a deposit with the keccak of its owner and the token
        bytes32 depositId = keccak256(abi.encodePacked(_owner, _token));
        uint192 newAmount = deposits[depositId].amount + _amount;
        require(
            newAmount >= deposits[depositId].amount,
            "WithdrawalDelayer::_processDeposit: DEPOSIT_OVERFLOW"
        );

        deposits[depositId].amount = newAmount;
        deposits[depositId].depositTimestamp = uint64(now);

        emit Deposit(
            _owner,
            _token,
            _amount,
            deposits[depositId].depositTimestamp
        );
    }

    /**
     * This function allows the owner to withdawal the funds. Emergency mode cannot be enabled and it must have exceeded
     * the withdrawal delay time
     * @dev `NonReentrant` modifier is used as a protection despite the state is being previously updated
     * @param _owner can claim the deposit once the delay time has expired
     * @param _token address of the token to withdrawal (0x0 in case of Ether)
     * Events: `Withdraw`
     */
    function withdrawal(address payable _owner, address _token)
        external
        nonReentrant
    {
        require(!_emergencyMode, "WithdrawalDelayer::deposit: EMERGENCY_MODE");
        // We identify a deposit with the keccak of its owner and the token
        bytes32 depositId = keccak256(abi.encodePacked(_owner, _token));
        uint192 amount = deposits[depositId].amount;
        require(amount > 0, "WithdrawalDelayer::withdrawal: NO_FUNDS");
        require(
            uint64(now) >=
                deposits[depositId].depositTimestamp + _withdrawalDelay,
            "WithdrawalDelayer::withdrawal: WITHDRAWAL_NOT_ALLOWED"
        );

        // Update the state
        deposits[depositId].amount = 0;
        deposits[depositId].depositTimestamp = 0;

        // Make the transfer
        if (_token == address(0x0)) {
            _ethWithdrawal(_owner, uint256(amount));
        } else {
            _tokenWithdrawal(_token, _owner, uint256(amount));
        }

        emit Withdraw(_token, _owner, amount);
    }

    /**
     * Allows the Hermez Governance DAO to withdawal the funds in the event that emergency mode was enable.
     * Note: An Aragon Court will have the right to veto over the call to this method
     * @dev `NonReentrant` modifier is used as a protection despite the state is being previously updated and this is
     * a security mechanism
     * @param _to where the funds will be sent
     * @param _token address of the token withdraw (0x0 in case of Ether)
     * @param _amount the amount to send
     * Events: `EscapeHatchWithdrawal`
     */
    function escapeHatchWithdrawal(
        address _to,
        address _token,
        uint256 _amount
    ) external nonReentrant {
        require(
            _emergencyMode,
            "WithdrawalDelayer::escapeHatchWithdrawal: ONLY_EMODE"
        );
        require(
            msg.sender == _whiteHackGroupAddress ||
                msg.sender == _hermezGovernanceDAOAddress,
            "WithdrawalDelayer::escapeHatchWithdrawal: ONLY_GOVERNANCE_WHG"
        );
        if (msg.sender == _whiteHackGroupAddress) {
            require(
                uint64(now) >=
                    _emergencyModeStartingTime + MAX_EMERGENCY_MODE_TIME,
                "WithdrawalDelayer::escapeHatchWithdrawal: NO_MAX_EMERGENCY_MODE_TIME"
            );
        }
        if (_token == address(0x0)) {
            _ethWithdrawal(_to, _amount);
        } else {
            _tokenWithdrawal(_token, _to, _amount);
        }
        emit EscapeHatchWithdrawal(msg.sender, _to, _token, _amount);
    }

    /**
     * Internal function to perform a ETH Withdrawal
     * @param to where the funds will be sent
     * @param amount address of the token withdraw (0x0 in case of Ether)
     */
    function _ethWithdrawal(address to, uint256 amount) internal {
        /* solhint-disable avoid-low-level-calls */
        (bool success, ) = to.call{value: amount}("");
        require(success, "WithdrawalDelayer::_ethWithdrawal: TRANSFER_FAILED");
    }

    /**
     * Internal function to perform a Token Withdrawal
     * @param tokenAddress address of the token to transfer
     * @param to where the funds will be sent
     * @param amount address of the token withdraw (0x0 in case of Ether)
     */
    function _tokenWithdrawal(
        address tokenAddress,
        address to,
        uint256 amount
    ) internal {
        /* solhint-disable avoid-low-level-calls */
        (bool success, bytes memory data) = tokenAddress.call(
            abi.encodeWithSelector(_TRANSFER_SIGNATURE, to, amount)
        );

        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "WithdrawalDelayer::_tokenWithdrawal: TOKEN_TRANSFER_FAILED"
        );
    }
}
