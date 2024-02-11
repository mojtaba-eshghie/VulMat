// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeySingletoneRegistryFetchAddress.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 2/7/19
 */
contract ITwoKeySingletoneRegistryFetchAddress {
    function getContractProxyAddress(string _contractName) public view returns (address);
    function getNonUpgradableContractAddress(string contractName) public view returns (address);
    function getLatestContractVersion(string contractName) public view returns (string);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/IHandleCampaignDeployment.sol

pragma solidity ^0.4.0;

/**
 * @title Interface contract to handle calls on different contracts
 * @author Nikola Madjarevic
 */
contract IHandleCampaignDeployment {

    /**
     * @notice Function which will be used as simulation for constructor under TwoKeyAcquisitionCampaign contract
     * @dev This is just an interface of the function, the actual logic
     * is implemented under TwoKeyAcquisitionCampaignERC20.sol contract
     * This function can be called only once per proxy address
     */
    function setInitialParamsCampaign(
        address _twoKeySingletonesRegistry,
        address _twoKeyAcquisitionLogicHandler,
        address _conversionHandler,
        address _moderator,
        address _assetContractERC20,
        address _contractor,
        uint [] values
    ) public;

    /**
     * @notice Function which will be used as simulation for constructor under TwoKeyAcquisitionLogicHandler contract
     * @dev This is just an interface of the function, the actual logic
     * is implemented under TwoKeyAcquisitionLogicHandler.sol contract
     * This function can be called only once per proxy address
     */
    function setInitialParamsLogicHandler(
        uint [] values,
        string _currency,
        address _assetContractERC20,
        address _moderator,
        address _contractor,
        address _acquisitionCampaignAddress,
        address _twoKeySingletoneRegistry,
        address _twoKeyConversionHandler
    ) public;

    /**
     * @notice Function which will be used as simulation for constructor under TwoKeyConversionHandler contract
     * @dev This is just an interface of the function, the actual logic
     * is implemented under TwoKeyConversionHandler.sol contract
     * This function can be called only once per proxy address
     */
    function setInitialParamsConversionHandler(
        uint [] values,
        address _twoKeyAcquisitionCampaignERC20,
        address _twoKeyPurchasesHandler,
        address _contractor,
        address _assetContractERC20,
        address _twoKeyEventSource,
        address _twoKeyBaseReputationRegistry
    ) public;


    /**
     * @notice Function which will be used as simulation for constructor under TwoKeyPurchasesHandler contract
     * @dev This is just an interface of the function, the actual logic
     * is implemented under TwoKeyPurchasesHandler.sol contract
     * This function can be called only once per proxy address
     */
    function setInitialParamsPurchasesHandler(
        uint[] values,
        address _contractor,
        address _assetContractERC20,
        address _twoKeyEventSource,
        address _proxyConversionHandler
    ) public;


    /**
     * @notice Function which will be used as simulation for constructor under TwoKeyDonationCampaign contract
     * @dev This is just an interface of the function, the actual logic
     * is implemented under TwoKeyDonationCampaign.sol contract
     * This function can be called only once per proxy address
     */
    function setInitialParamsDonationCampaign(
        address _contractor,
        address _moderator,
        address _twoKeySingletonRegistry,
        address _twoKeyDonationConversionHandler,
        address _twoKeyDonationLogicHandler,
        uint [] numberValues,
        bool [] booleanValues
    ) public;

    /**
     * @notice Function which will be used as simulation for constructor under TwoKeyDonationConversionHandler contract
     * @dev This is just an interface of the function, the actual logic
     * is implemented under TwoKeyDonationConversionHandler.sol contract
     * This function can be called only once per proxy address
     */
    function setInitialParamsDonationConversionHandler(
        string tokenName,
        string tokenSymbol,
        string _currency,
        address _contractor,
        address _twoKeyDonationCampaign,
        address _twoKeySingletonRegistry
    ) public;


    function setInitialParamsDonationLogicHandler(
        uint[] numberValues,
        string currency,
        address contractor,
        address moderator,
        address twoKeySingletonRegistry,
        address twoKeyDonationCampaign,
        address twoKeyDonationLogicHandler
    ) public;
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyCampaignValidator.sol

pragma solidity ^0.4.24;
/**y
 * @author Nikola Madjarevic
 * Created at 2/12/19
 */
contract ITwoKeyCampaignValidator {
    function isCampaignValidated(address campaign) public view returns (bool);
    function isConversionHandlerCodeValid(address conversionHandler) public view returns (bool);
    function validateAcquisitionCampaign(address campaign, string nonSingletonHash) public;
    function validateDonationCampaign(address campaign, address donationConversionHandler, string nonSingletonHash) public;
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeySingletonesRegistry.sol

pragma solidity ^0.4.24;

/**
 * @title IRegistry
 * @dev This contract represents the interface of a registry contract
 */
interface ITwoKeySingletonesRegistry {

    /**
    * @dev This event will be emitted every time a new proxy is created
    * @param proxy representing the address of the proxy created
    */
    event ProxyCreated(address proxy);


    /**
    * @dev This event will be emitted every time a new implementation is registered
    * @param version representing the version name of the registered implementation
    * @param implementation representing the address of the registered implementation
    */
    event VersionAdded(string version, address implementation);

    /**
    * @dev Registers a new version with its implementation address
    * @param version representing the version name of the new implementation to be registered
    * @param implementation representing the address of the new implementation to be registered
    */
    function addVersion(string _contractName, string version, address implementation) public;

    /**
    * @dev Tells the address of the implementation for a given version
    * @param _contractName is the name of the contract we're querying
    * @param version to query the implementation of
    * @return address of the implementation registered for the given version
    */
    function getVersion(string _contractName, string version) public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradable-pattern-campaigns/UpgradabilityCampaignStorage.sol

pragma solidity ^0.4.24;

/**
 * @title UpgradeabilityStorage
 * @dev This contract holds all the necessary state variables to support the upgrade functionality
 */
contract UpgradeabilityCampaignStorage {
    // Versions registry
    ITwoKeySingletonesRegistry internal registry;

    address internal twoKeyFactory;

    // Address of the current implementation
    address internal _implementation;

    /**
    * @dev Tells the address of the current implementation
    * @return address of the current implementation
    */
    function implementation() public view returns (address) {
        return _implementation;
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradability/Proxy.sol

pragma solidity ^0.4.24;

/**
 * @title Proxy
 * @dev Gives the possibility to delegate any call to a foreign implementation.
 */
contract Proxy {

    /**
    * @dev Tells the address of the implementation where every call will be delegated.
    * @return address of the implementation to which it will be delegated
    */
    function implementation() public view returns (address);

    /**
    * @dev Fallback function allowing to perform a delegatecall to the given implementation.
    * This function will return whatever the implementation call returns
    */
    function () payable public {
        address _impl = implementation();
        require(_impl != address(0));

        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize)
            let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
            let size := returndatasize
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradable-pattern-campaigns/ProxyCampaign.sol

pragma solidity ^0.4.0;


contract ProxyCampaign is Proxy, UpgradeabilityCampaignStorage {

    constructor (string _contractName, string _version, address twoKeySingletonRegistry) public {
        twoKeyFactory = msg.sender;
        registry = ITwoKeySingletonesRegistry(twoKeySingletonRegistry);
        _implementation = registry.getVersion(_contractName, _version);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradable-pattern-campaigns/UpgradeableCampaign.sol

pragma solidity ^0.4.24;

contract UpgradeableCampaign is UpgradeabilityCampaignStorage {
//    /**
//     * @dev Validates the caller is the versions registry.
//     * @param sender representing the address deploying the initial behavior of the contract
//     */
//    function initialize(address sender) public payable {
//    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyEventSource.sol

pragma solidity ^0.4.24;


contract ITwoKeyEventSource {
    function ethereumOf(address me) public view returns (address);
    function plasmaOf(address me) public view returns (address);
    function isAddressMaintainer(address _maintainer) public view returns (bool);
    function getTwoKeyDefaultIntegratorFeeFromAdmin() public view returns (uint);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/IERC20.sol

pragma solidity ^0.4.24;

/// Interface of ERC20 contract we need in order to invoke balanceOf method from another contracts
contract IERC20 {
    function balanceOf(
        address whom
    )
    external
    view
    returns (uint);


    function transfer(
        address _to,
        uint256 _value
    )
    external
    returns (bool);


    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    )
    external
    returns (bool);



    function approve(
        address _spender,
        uint256 _value
    )
    public
    returns (bool);



    function decimals()
    external
    view
    returns (uint);


    function symbol()
    external
    view
    returns (string);


    function name()
    external
    view
    returns (string);


    function freezeTransfers()
    external;


    function unfreezeTransfers()
    external;
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/acquisition-campaign-contracts/TwoKeyPurchasesHandler.sol

pragma solidity ^0.4.0;



contract TwoKeyPurchasesHandler is UpgradeableCampaign {

    enum VestingAmount {BONUS, BASE_AND_BONUS}
    VestingAmount vestingAmount;

    bool initialized;
    bool isDistributionDateChanged;

    address proxyConversionHandler;
    address public assetContractERC20;
    address converter;
    address contractor;
    address twoKeyEventSource;

    mapping(uint => uint) public portionToUnlockingDate;

    uint numberOfPurchases;
    uint bonusTokensVestingStartShiftInDaysFromDistributionDate;
    uint tokenDistributionDate; // Start of token distribution
    uint numberOfVestingPortions; // For example 6
    uint numberOfDaysBetweenPortions; // For example 30 days
    uint maxDistributionDateShiftInDays;

    mapping(uint => Purchase) conversionIdToPurchase;

    event TokensWithdrawn(
        uint timestamp,
        address methodCaller,
        address tokensReceiver,
        uint portionId,
        uint portionAmount
    );

    struct Purchase {
        address converter;
        uint baseTokens;
        uint bonusTokens;
        uint [] portionAmounts;
        bool [] isPortionWithdrawn;
    }

    function setInitialParamsPurchasesHandler(
        uint[] values,
        address _contractor,
        address _assetContractERC20,
        address _twoKeyEventSource,
        address _proxyConversionHandler
    )
    public
    {
        require(initialized == false);

        tokenDistributionDate = values[2];
        maxDistributionDateShiftInDays = values[3];
        numberOfVestingPortions = values[4];
        numberOfDaysBetweenPortions = values[5];
        bonusTokensVestingStartShiftInDaysFromDistributionDate = values[6];
        vestingAmount = VestingAmount(values[7]);
        contractor = _contractor;
        assetContractERC20 = _assetContractERC20;
        twoKeyEventSource = _twoKeyEventSource;
        proxyConversionHandler = _proxyConversionHandler;

        uint bonusVestingStartDate;
        // In case vested amounts are both bonus and base, bonusTokensVestingStartShiftInDaysFromDistributionDate is ignored
        if(vestingAmount == VestingAmount.BASE_AND_BONUS) {
            bonusVestingStartDate = tokenDistributionDate + numberOfDaysBetweenPortions * (1 days);
        } else {
            bonusVestingStartDate = tokenDistributionDate + bonusTokensVestingStartShiftInDaysFromDistributionDate * (1 days);
        }


        portionToUnlockingDate[0] = tokenDistributionDate;

        for(uint i=1; i<numberOfVestingPortions + 1; i++) {
            portionToUnlockingDate[i] = bonusVestingStartDate + (i-1) * (numberOfDaysBetweenPortions * (1 days));
        }

        initialized = true;
    }


    function startVesting(
        uint _baseTokens,
        uint _bonusTokens,
        uint _conversionId,
        address _converter
    )
    public
    {
        require(msg.sender == proxyConversionHandler);
        if(vestingAmount == VestingAmount.BASE_AND_BONUS) {
            baseAndBonusVesting(_baseTokens, _bonusTokens, _conversionId, _converter);
        } else {
            bonusVestingOnly(_baseTokens, _bonusTokens, _conversionId, _converter);
        }
        numberOfPurchases++;
    }

    function bonusVestingOnly(
        uint _baseTokens,
        uint _bonusTokens,
        uint _conversionId,
        address _converter
    )
    internal
    {
        uint [] memory portionAmounts = new uint[](numberOfVestingPortions+1);
        bool [] memory isPortionWithdrawn = new bool[](numberOfVestingPortions+1);
        portionAmounts[0] = _baseTokens;

        uint bonusVestingStartDate = tokenDistributionDate + bonusTokensVestingStartShiftInDaysFromDistributionDate * (1 days);
        uint bonusPortionAmount = _bonusTokens / numberOfVestingPortions;

        for(uint i=1; i<numberOfVestingPortions + 1; i++) {
            portionAmounts[i] = bonusPortionAmount;
        }

        Purchase memory purchase = Purchase(
            _converter,
            _baseTokens,
            _bonusTokens,
            portionAmounts,
            isPortionWithdrawn
        );

        conversionIdToPurchase[_conversionId] = purchase;
    }

    function baseAndBonusVesting(
        uint _baseTokens,
        uint _bonusTokens,
        uint _conversionId,
        address _converter
    )
    internal
    {
        uint [] memory portionAmounts = new uint[](numberOfVestingPortions);
        bool [] memory isPortionWithdrawn = new bool[](numberOfVestingPortions);

        uint totalAmount = _baseTokens + _bonusTokens;
        uint portion = totalAmount / numberOfVestingPortions;

        for(uint i=0; i<numberOfVestingPortions; i++) {
            portionAmounts[i] = portion;
        }

        Purchase memory purchase = Purchase(
            _converter,
            _baseTokens,
            _bonusTokens,
            portionAmounts,
            isPortionWithdrawn
        );

        conversionIdToPurchase[_conversionId] = purchase;
    }


    function changeDistributionDate(
        uint _newDate
    )
    public
    {
        require(msg.sender == contractor);
        require(isDistributionDateChanged == false);
        require(_newDate - (maxDistributionDateShiftInDays * (1 days)) <= tokenDistributionDate);
        require(now < tokenDistributionDate);

        uint shift = tokenDistributionDate - _newDate;
        // If the date is changed shifting all tokens unlocking dates for the difference
        for(uint i=0; i<numberOfVestingPortions+1;i++) {
            portionToUnlockingDate[i] = portionToUnlockingDate[i] + shift;
        }

        isDistributionDateChanged = true;
        tokenDistributionDate = _newDate;
    }


    function withdrawTokens(
        uint conversionId,
        uint portion
    )
    public
    {
        Purchase p = conversionIdToPurchase[conversionId];
        //Only converter of maintainer can call this function
        require(msg.sender == p.converter || ITwoKeyEventSource(twoKeyEventSource).isAddressMaintainer(msg.sender) == true);
        require(p.isPortionWithdrawn[portion] == false && block.timestamp > portionToUnlockingDate[portion]);
        //Transfer tokens
        require(IERC20(assetContractERC20).transfer(p.converter, p.portionAmounts[portion]));
        p.isPortionWithdrawn[portion] = true;

        emit TokensWithdrawn (
            block.timestamp,
            msg.sender,
            converter,
            portion,
            p.portionAmounts[portion]
        );
    }

    function getPurchaseInformation(
        uint _conversionId
    )
    public
    view
    returns (address, uint, uint, uint[], bool[], uint[])
    {
        Purchase memory p = conversionIdToPurchase[_conversionId];
        uint [] memory unlockingDates = getPortionsUnlockingDates();
        return (
            p.converter,
            p.baseTokens,
            p.bonusTokens,
            p.portionAmounts,
            p.isPortionWithdrawn,
            unlockingDates
        );
    }

    function getStaticInfo()
    public
    view
    returns (uint,uint,uint,uint,uint,uint)
    {
        return (
            bonusTokensVestingStartShiftInDaysFromDistributionDate,
            tokenDistributionDate,
            numberOfVestingPortions,
            numberOfDaysBetweenPortions,
            maxDistributionDateShiftInDays,
            uint(vestingAmount)
        );
    }

    function getPortionsUnlockingDates()
    public
    view
    returns (uint[])
    {
        uint [] memory dates = new uint[](numberOfVestingPortions+1);
        for(uint i=0; i< numberOfVestingPortions+1; i++) {
            dates[i] = portionToUnlockingDate[i];
        }
        return dates;
    }



}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyExchangeRateContract.sol

pragma solidity ^0.4.24;

/**
 * @author Nikola Madjarevic
 * @notice Interface for exchange contract to get the eth-currency rate
 */
contract ITwoKeyExchangeRateContract {
    function getBaseToTargetRate(string _currency) public view returns (uint);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyConversionHandler.sol

pragma solidity ^0.4.24;

contract ITwoKeyConversionHandler {

    bool public isFiatConversionAutomaticallyApproved;

    function supportForCreateConversion(
        address _contractor,
        address _converterAddress,
        uint256 _conversionAmount,
        uint256 _maxReferralRewardETHWei,
        uint256 baseTokensForConverterUnits,
        uint256 bonusTokensForConverterUnits,
        bool isConversionFiat,
        bool _isAnonymous,
        bool _isKYCRequired
    )
    public
    returns (uint);

    function executeConversion(
        uint _conversionId
    )
    public;


    function getConverterConversionIds(
        address _converter
    )
    external
    view
    returns (uint[]);


    function getConverterPurchasesStats(
        address _converter
    )
    public
    view
    returns (uint,uint,uint);


    function getStateForConverter(
        address _converter
    )
    public
    view
    returns (bytes32);


}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyAcquisitionCampaignERC20.sol

pragma solidity ^0.4.24;

// @author Nikola Madjarevic
// @notice Contract which will act as an interface for only methods we need from AcquisitionCampaign in other contracts
contract ITwoKeyAcquisitionCampaignERC20 {
    address public conversionHandler;
    function buyTokensAndDistributeReferrerRewards(uint256 _maxReferralRewardETHWei, address _converter, uint _conversionId, bool _isConversionFiat) public returns (uint);
    function moveFungibleAsset(address _to, uint256 _amount) public;
    function updateContractorProceeds(uint value) public;
    function sendBackEthWhenConversionCancelled(address _cancelledConverter, uint _conversionAmount) public;
    function buyTokensForModeratorRewards(uint moderatorFee) public;
    function updateReservedAmountOfTokensIfConversionRejectedOrExecuted(uint value) public;
    function refundConverterAndRemoveUnits(address _converter, uint amountOfEther, uint amountOfUnits) external;
    function getStatistics(address ethereum, address plasma) public view returns (uint,uint,uint,uint);
    function getAvailableAndNonReservedTokensAmount() external view returns (uint);
    function getTotalReferrerEarnings(address _referrer, address eth_address) public view returns (uint);
    function getReferrerPlasmaBalance(address _influencer) public view returns (uint);
    function updateReferrerPlasmaBalance(address _influencer, uint _balance) public;
    function getReferrerCut(address me) public view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyReg.sol

pragma solidity ^0.4.24;


contract ITwoKeyReg {
    function addTwoKeyEventSource(address _twoKeyEventSource) public;
    function changeTwoKeyEventSource(address _twoKeyEventSource) public;
    function addWhereContractor(address _userAddress, address _contractAddress) public;
    function addWhereModerator(address _userAddress, address _contractAddress) public;
    function addWhereReferrer(address _userAddress, address _contractAddress) public;
    function addWhereConverter(address _userAddress, address _contractAddress) public;
    function getContractsWhereUserIsContractor(address _userAddress) public view returns (address[]);
    function getContractsWhereUserIsModerator(address _userAddress) public view returns (address[]);
    function getContractsWhereUserIsRefferer(address _userAddress) public view returns (address[]);
    function getContractsWhereUserIsConverter(address _userAddress) public view returns (address[]);
    function getTwoKeyEventSourceAddress() public view returns (address);
    function addName(string _name, address _sender, string _fullName, string _email, bytes signature) public;
    function addNameByUser(string _name) public;
    function getName2Owner(string _name) public view returns (address);
    function getOwner2Name(address _sender) public view returns (string);
    function getPlasmaToEthereum(address plasma) public view returns (address);
    function getEthereumToPlasma(address ethereum) public view returns (address);
    function checkIfTwoKeyMaintainerExists(address _maintainer) public view returns (bool);
    function getUserData(address _user) external view returns (bytes);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyAcquisitionARC.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 2/1/19
 */
contract ITwoKeyAcquisitionARC {
    function getReceivedFrom(address _receiver) public view returns (address);
    function balanceOf(address _owner) public view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyMaintainersRegistry.sol

pragma solidity ^0.4.24;

contract ITwoKeyMaintainersRegistry {
    function onlyMaintainer(address _sender) public view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/SafeMath.sol

pragma solidity ^0.4.24;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (_a == 0) {
      return 0;
    }

    c = _a * _b;
    require(c / _a == _b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
    // assert(_b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = _a / _b;
    // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold
    return _a / _b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
    require(_b <= _a);
    return _a - _b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    c = _a + _b;
    require(c >= _a);
    return c;
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/Call.sol

pragma solidity ^0.4.24;

library Call {
    function params0(address c, bytes _method) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x04, // Inputs are 0 bytes long
            ptr,  //Store output over input
            0x20) //Outputs are 1 bytes long

            if eq(result, 0) {
                revert(0, 0)
            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
        }
    }

    function params1(address c, bytes _method, uint _val) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)
        // append argument after function sig
            mstore(add(ptr,0x04), _val)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x24, // Inputs are 0 bytes long
            ptr,  //Store output over input
            0x20) //Outputs are 1 bytes long

            if eq(result, 0) {
                revert(0, 0)
            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x24)) // Set storage pointer to new space
        }
    }

    function params2(address c, bytes _method, uint _val1, uint _val2) public view returns (uint answer) {
        // https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c
        //    dc = c;
        bytes4 sig = bytes4(keccak256(_method));
        assembly {
        // move pointer to free memory spot
            let ptr := mload(0x40)
        // put function sig at memory spot
            mstore(ptr,sig)
        // append argument after function sig
            mstore(add(ptr,0x04), _val1)
            mstore(add(ptr,0x24), _val2)

            let result := call(  // use WARNING because this should be staticcall BUT geth crash!
            15000, // gas limit
            c, // sload(dc_slot),  // to addr. append var to _slot to access storage variable
            0, // not transfer any ether (comment if using staticcall)
            ptr, // Inputs are stored at location ptr
            0x44, // Inputs are 4 bytes for signature and 2 uint256
            ptr,  //Store output over input
            0x20) //Outputs are 1 uint long

        // TODO cause revert
        //            if eq(result, 0) {
        //                revert(0, 0)
        //            }

            answer := mload(ptr) // Assign output to answer var
            mstore(0x40,add(ptr,0x20)) // Set storage pointer to new space
        }
    }

    function loadAddress(bytes sig, uint idx) public pure returns (address) {
        address influencer;
        idx += 20;
        assembly
        {
            influencer := mload(add(sig, idx))
        }
        return influencer;
    }

    function loadUint8(bytes sig, uint idx) public pure returns (uint8) {
        uint8 weight;
        idx += 1;
        assembly
        {
            weight := mload(add(sig, idx))
        }
        return weight;
    }


    function recoverHash(bytes32 hash, bytes sig, uint idx) public pure returns (address) {
        // same as recoverHash in utils/sign.js
        // The signature format is a compact form of:
        //   {bytes32 r}{bytes32 s}{uint8 v}
        // Compact means, uint8 is not padded to 32 bytes.
        require (sig.length >= 65+idx, 'bad signature length');
        idx += 32;
        bytes32 r;
        assembly
        {
            r := mload(add(sig, idx))
        }

        idx += 32;
        bytes32 s;
        assembly
        {
            s := mload(add(sig, idx))
        }

        idx += 1;
        uint8 v;
        assembly
        {
            v := mload(add(sig, idx))
        }
        if (v >= 32) { // handle case when signature was made with ethereum web3.eth.sign or getSign which is for signing ethereum transactions
            v -= 32;
            bytes memory prefix = "\x19Ethereum Signed Message:\n32"; // 32 is the number of bytes in the following hash
            hash = keccak256(abi.encodePacked(prefix, hash));
        }
        if (v <= 1) v += 27;
        require(v==27 || v==28,'bad sig v');
        return ecrecover(hash, v, r, s);

    }

    function recoverSigMemory(bytes sig) private pure returns (address[], address[], uint8[], uint[], uint) {
        uint8 version = loadUint8(sig, 0);
        uint msg_len = (version == 1) ? 1+65+20 : 1+20+20;
        uint n_influencers = (sig.length-21) / (65+msg_len);
        uint8[] memory weights = new uint8[](n_influencers);
        address[] memory keys = new address[](n_influencers);
        if ((sig.length-21) % (65+msg_len) > 0) {
            n_influencers++;
        }
        address[] memory influencers = new address[](n_influencers);
        uint[] memory offsets = new uint[](n_influencers);

        return (influencers, keys, weights, offsets, msg_len);
    }

    function recoverSigParts(bytes sig, address last_address) private pure returns (address[], address[], uint8[], uint[]) {
        // sig structure:
        // 1 byte version 0 or 1
        // 20 bytes are the address of the contractor or the influencer who created sig.
        //  this is the "anchor" of the link
        //  It must have a public key aleady stored for it in public_link_key
        // Begining of a loop on steps in the link:
        // * 65 bytes are step-signature using the secret from previous step
        // * message of the step that is going to be hashed and used to compute the above step-signature.
        //   message length depend on version 41 (version 0) or 86 (version 1):
        //   * 1 byte cut (percentage) each influencer takes from the bounty. the cut is stored in influencer2cut or weight for voting
        //   * 20 bytes address of influencer (version 0) or 65 bytes of signature of cut using the influencer address to sign
        //   * 20 bytes public key of the last secret
        // In the last step the message can be optional. If it is missing the message used is the address of the sender
        uint idx = 0;
        uint msg_len;
        uint8[] memory weights;
        address[] memory keys;
        address[] memory influencers;
        uint[] memory offsets;
        (influencers, keys, weights, offsets, msg_len) = recoverSigMemory(sig);
        idx += 1;  // skip version

        idx += 20; // skip old_address which should be read by the caller in order to get old_key
        uint count_influencers = 0;

        while (idx + 65 <= sig.length) {
            offsets[count_influencers] = idx;
            idx += 65;  // idx was increased by 65 for the signature at the begining which we will process later

            if (idx + msg_len <= sig.length) {  // its  a < and not a <= because we dont want this to be the final iteration for the converter
                weights[count_influencers] = loadUint8(sig, idx);
                require(weights[count_influencers] > 0,'weight not defined (1..255)');  // 255 are used to indicate default (equal part) behaviour
                idx++;


                if (msg_len == 41)  // 1+20+20 version 0
                {
                    influencers[count_influencers] = loadAddress(sig, idx);
                    idx += 20;
                    keys[count_influencers] = loadAddress(sig, idx);
                    idx += 20;
                } else if (msg_len == 86)  // 1+65+20 version 1
                {
                    keys[count_influencers] = loadAddress(sig, idx+65);
                    influencers[count_influencers] = recoverHash(
                        keccak256(
                            abi.encodePacked(
                                keccak256(abi.encodePacked("bytes binding to weight","bytes binding to public")),
                                keccak256(abi.encodePacked(weights[count_influencers],keys[count_influencers]))
                            )
                        ),sig,idx);
                    idx += 65;
                    idx += 20;
                }

            } else {
                // handle short signatures generated with free_take
                influencers[count_influencers] = last_address;
            }
            count_influencers++;
        }
        require(idx == sig.length,'illegal message size');

        return (influencers, keys, weights, offsets);
    }

    function recoverSig(bytes sig, address old_key, address last_address) public pure returns (address[], address[], uint8[]) {
        // validate sig AND
        // recover the information from the signature: influencers, public_link_keys, weights/cuts
        // influencers may have one more address than the keys and weights arrays
        //
        require(old_key != address(0),'no public link key');

        address[] memory influencers;
        address[] memory keys;
        uint8[] memory weights;
        uint[] memory offsets;
        (influencers, keys, weights, offsets) = recoverSigParts(sig, last_address);

        // check if we received a valid signature
        for(uint i = 0; i < influencers.length; i++) {
            if (i < weights.length) {
                require (recoverHash(keccak256(abi.encodePacked(weights[i], keys[i], influencers[i])),sig,offsets[i]) == old_key, 'illegal signature');
                old_key = keys[i];
            } else {
                // signed message for the last step is the address of the converter
                require (recoverHash(keccak256(abi.encodePacked(influencers[i])),sig,offsets[i]) == old_key, 'illegal last signature');
            }
        }

        return (influencers, keys, weights);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/IncentiveModels.sol

pragma solidity ^0.4.24;

/**
 * @title Library to handle implementation of different reward models
 * @author Nikola Madjarevic
 */
library IncentiveModels {

    /**
     * @notice Implementation of average incentive model, reward is splited equally per referrer
     * @param totalRewardEthWEI is total reward for the influencers
     * @param numberOfInfluencers is how many influencers we're splitting reward between
     */
    function averageModelRewards(
        uint totalRewardEthWEI,
        uint numberOfInfluencers
    ) internal pure returns (uint) {
        if(numberOfInfluencers > 0) {
            uint equalPart = totalRewardEthWEI / numberOfInfluencers;
            return equalPart;
        }
        return 0;
    }

    /**
     * @notice Implementation similar to average incentive model, except direct referrer) - gets 3x as the others
     * @param totalRewardEthWEI is total reward for the influencers
     * @param numberOfInfluencers is how many influencers we're splitting reward between
     * @return two values, first is reward per regular referrer, and second is reward for last referrer in the chain
     */
    function averageLast3xRewards(
        uint totalRewardEthWEI,
        uint numberOfInfluencers
    ) internal pure returns (uint,uint) {
        if(numberOfInfluencers> 0) {
            uint rewardPerReferrer = totalRewardEthWEI / (numberOfInfluencers + 2);
            uint rewardForLast = rewardPerReferrer*3;
            return (rewardPerReferrer, rewardForLast);
        }
        return (0,0);
    }

    /**
     * @notice Function to return array of corresponding values with rewards in power law schema
     * @param totalRewardEthWEI is totalReward
     * @param numberOfInfluencers is the total number of influencers
     * @return rewards in wei
     */
    function powerLawRewards(
        uint totalRewardEthWEI,
        uint numberOfInfluencers,
        uint factor
    ) internal pure returns (uint[]) {
        uint[] memory rewards = new uint[](numberOfInfluencers);
        if(numberOfInfluencers > 0) {
            uint x = calculateX(totalRewardEthWEI,numberOfInfluencers,factor);
            for(uint i=0; i<numberOfInfluencers;i++) {
                rewards[numberOfInfluencers-i-1] = x / (2**i);
            }
        }
        return rewards;
    }


    /**
     * @notice Function to calculate base for all rewards in power law model
     * @param sumWei is the total reward to be splited in Wei
     * @param numberOfElements is the number of referrers in the chain
     * @return wei value of base for the rewards in power law
     */
    function calculateX(
        uint sumWei,
        uint numberOfElements,
        uint factor
    ) private pure returns (uint) {
        uint a = 1;
        uint sumOfFactors = 1;
        for(uint i=1; i<numberOfElements; i++) {
            a = a*factor;
            sumOfFactors += a;
        }
        return (sumWei*a) / sumOfFactors;
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/campaign-mutual-contracts/TwoKeyCampaignIncentiveModels.sol

pragma solidity ^0.4.24;
/**
 * @author Nikola Madjarevic
 * Created at 2/25/19
 */
contract TwoKeyCampaignIncentiveModels {
    enum IncentiveModel {MANUAL, VANILLA_AVERAGE, VANILLA_AVERAGE_LAST_3X, VANILLA_POWER_LAW, NO_REFERRAL_REWARD}
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/acquisition-campaign-contracts/TwoKeyAcquisitionLogicHandler.sol

pragma solidity ^0.4.24;
//Interfaces









//Libraries




/**
 * @author Nikola Madjarevic
 * Created at 1/15/19
 */
contract TwoKeyAcquisitionLogicHandler is UpgradeableCampaign, TwoKeyCampaignIncentiveModels {

    using SafeMath for uint256;

    bool isCampaignInitialized;

    bool public IS_CAMPAIGN_ACTIVE;

    address public twoKeySingletoneRegistry;
    address public twoKeyAcquisitionCampaign;
    address public twoKeyConversionHandler;
    address public ownerPlasma;

    address twoKeyRegistry;
    address twoKeyMaintainersRegistry;

    address assetContractERC20;
    address contractor;
    address moderator;


    bool isFixedInvestmentAmount; // This means that minimal contribution is equal maximal contribution
    bool isAcceptingFiatOnly; // Means that only fiat conversions will be able to execute -> no referral rewards at all

    uint campaignStartTime; // Time when campaign start
    uint campaignEndTime; // Time when campaign ends
    uint minContributionETHorFiatCurrency; //Minimal contribution
    uint maxContributionETHorFiatCurrency; //Maximal contribution
    uint pricePerUnitInETHWeiOrUSD; // There's single price for the unit ERC20 (Should be in WEI)
    uint unit_decimals; // ERC20 selling data
    uint maxConverterBonusPercent; // Maximal bonus percent per converter
    uint campaignHardCapWei; // Hard cap of campaign

    string public currency; // Currency campaign is currently in

    // Enumerator representing incentive model selected for the contract
    IncentiveModel incentiveModel;

    //Referral accounting stuff
    mapping(address => uint256) internal referrerPlasma2TotalEarnings2key; // Total earnings for referrers
    mapping(address => uint256) internal referrerPlasmaAddressToCounterOfConversions; // [referrer][conversionId]
    mapping(address => mapping(uint256 => uint256)) internal referrerPlasma2EarningsPerConversion;


    modifier onlyContractor {
        require(msg.sender == contractor);
        _;
    }

    function setInitialParamsLogicHandler(
        uint [] values,
        string _currency,
        address _assetContractERC20,
        address _moderator,
        address _contractor,
        address _acquisitionCampaignAddress,
        address _twoKeySingletoneRegistry,
        address _twoKeyConversionHandler
    )
    public
    {
        require(values[1] >= values[0], "max contribution criteria not satisfied");
        require(values[4] > values[3], "campaign start time can't be greater than end time");
        require(isCampaignInitialized == false);

        if(values[0] == values[1]) {
            isFixedInvestmentAmount = true;
        }

        minContributionETHorFiatCurrency = values[0];
        maxContributionETHorFiatCurrency = values[1];
        pricePerUnitInETHWeiOrUSD = values[2];
        campaignStartTime = values[3];
        campaignEndTime = values[4];
        maxConverterBonusPercent = values[5];

        //Add as 6th argument incentive model uint
        incentiveModel = IncentiveModel(values[6]);
        if(values[7] == 1) {
            isAcceptingFiatOnly = true;
        }

        campaignHardCapWei = values[8];

        currency = _currency;
        assetContractERC20 = _assetContractERC20;
        moderator = _moderator;
        contractor = _contractor;
        unit_decimals = IERC20(_assetContractERC20).decimals();

        twoKeyAcquisitionCampaign = _acquisitionCampaignAddress;
        twoKeySingletoneRegistry = _twoKeySingletoneRegistry;

        twoKeyRegistry = ITwoKeySingletoneRegistryFetchAddress(twoKeySingletoneRegistry).getContractProxyAddress("TwoKeyRegistry");
        twoKeyMaintainersRegistry = ITwoKeySingletoneRegistryFetchAddress(twoKeySingletoneRegistry).getContractProxyAddress("TwoKeyMaintainersRegistry");

        ownerPlasma = plasmaOf(contractor);
        twoKeyConversionHandler = _twoKeyConversionHandler;

        isCampaignInitialized = true;
    }

    /**
     *
     */
    function activateCampaign() public onlyContractor {
        require(IS_CAMPAIGN_ACTIVE == false);
        uint balanceOfTokenBeingSoldOnAcquisition = getInventoryBalance();
        //balance is in weis, price is in weis and hardcap is regular number
        require((balanceOfTokenBeingSoldOnAcquisition * pricePerUnitInETHWeiOrUSD).div(10**18) >= campaignHardCapWei);
        IS_CAMPAIGN_ACTIVE = true;
    }


    function checkHowMuchUserCanSpend(uint alreadySpentETHWei, uint alreadySpentFiatWEI) public view returns (uint) {
        if(keccak256(currency) == keccak256('ETH')) {
            uint leftToSpendInEther = maxContributionETHorFiatCurrency - alreadySpentETHWei;
            return leftToSpendInEther;
        } else {
            //In order to work with this I have to convert everything to same currency
            address ethUSDExchangeContract = ITwoKeySingletoneRegistryFetchAddress(twoKeySingletoneRegistry).getContractProxyAddress("TwoKeyExchangeRateContract");
            uint rate = ITwoKeyExchangeRateContract(ethUSDExchangeContract).getBaseToTargetRate(currency);

            uint totalAmountSpentConvertedToFIAT = (alreadySpentETHWei*rate).div(10**18) + alreadySpentFiatWEI;
            uint limit = maxContributionETHorFiatCurrency; // Initially we assume it's fiat currency campaign
            uint leftToSpendInFiats = limit-totalAmountSpentConvertedToFIAT;
            return leftToSpendInFiats;
        }
    }

    function canConversionBeCreated(address converter, uint amountWillingToSpend, bool isFiat) public view returns (bool) {
        bool canConvert = checkIsCampaignActive();
        if(IS_CAMPAIGN_ACTIVE == false) {
            return false;
        }
        if(canConvert == false) {
            return false;
        }
        //If we reach this point means we have reached point that campaign is still active
        if(isFiat) {
            (canConvert,)= canMakeFiatConversion(converter, amountWillingToSpend);
        } else {
            (canConvert,) = canMakeETHConversion(converter, amountWillingToSpend);
        }

        return canConvert;
    }

    //TODO: HANDLE INSIDE THIS METHODS MIN CONTRIBUTION AMOUNT

    function canMakeFiatConversion(address converter, uint amountWillingToSpendFiatWei) internal view returns (bool,uint) {
        uint alreadySpentETHWei;
        uint alreadySpentFIATWEI;
        if(keccak256(currency) == keccak256('ETH')) {
            return (false, 0);
        } else {
            (alreadySpentETHWei,alreadySpentFIATWEI,) = ITwoKeyConversionHandler(twoKeyConversionHandler).getConverterPurchasesStats(converter);

            uint leftToSpendFiat = checkHowMuchUserCanSpend(alreadySpentETHWei,alreadySpentFIATWEI);
            if(leftToSpendFiat >= amountWillingToSpendFiatWei) {
                return (true,leftToSpendFiat);
            } else {
                return (false,leftToSpendFiat);
            }
        }
    }

    function canMakeETHConversion(address converter, uint amountWillingToSpendEthWei) public view returns (bool,uint) {
        uint alreadySpentETHWei;
        uint alreadySpentFIATWEI;
        (alreadySpentETHWei,alreadySpentFIATWEI,) = ITwoKeyConversionHandler(twoKeyConversionHandler).getConverterPurchasesStats(converter);
        uint leftToSpend = checkHowMuchUserCanSpend(alreadySpentETHWei, alreadySpentFIATWEI);

        if(keccak256(currency) == keccak256('ETH')) {
            //Adding a deviation of 1000 weis
            if(leftToSpend + 1000 > amountWillingToSpendEthWei) {
                return(true, leftToSpend);
            } else {
                return(false, leftToSpend);
            }
        } else {
            address ethUSDExchangeContract = ITwoKeySingletoneRegistryFetchAddress(twoKeySingletoneRegistry).getContractProxyAddress("TwoKeyExchangeRateContract");
            uint rate = ITwoKeyExchangeRateContract(ethUSDExchangeContract).getBaseToTargetRate(currency);
            uint amountToBeSpentInFiat = (amountWillingToSpendEthWei*rate).div(10**18);
            //Adding gap of 100 weis
            if(leftToSpend + 1000 >= amountToBeSpentInFiat) {
                return (true,leftToSpend);
            } else {
                return (false,leftToSpend);
            }
        }
    }

    /**
     * @notice Requirement for the checking if the campaign is active or not
     */
    function checkIsCampaignActive()
    public
    view
    returns (bool)
    {
        if(block.timestamp >= campaignStartTime && block.timestamp <= campaignEndTime) {
            return true;
        }
        return false;
    }


    /**
     * @notice Function to get investment rules
     * @return tuple containing if investment amount is fixed, and lower/upper bound of the same if not (if yes lower = upper)
     */
    function getInvestmentRules()
    public
    view
    returns (bool,uint,uint)
    {
        return (isFixedInvestmentAmount, minContributionETHorFiatCurrency, maxContributionETHorFiatCurrency);
    }



    /**
     * @notice Function which will calculate the base amount, bonus amount
     * @param conversionAmountETHWeiOrFiat is amount of eth in conversion
     * @return tuple containing (base,bonus)
     */
    function getEstimatedTokenAmount(
        uint conversionAmountETHWeiOrFiat,
        bool isFiatConversion
    )
    public
    view
    returns (uint, uint)
    {
        uint value = pricePerUnitInETHWeiOrUSD;
        uint baseTokensForConverterUnits;
        uint bonusTokensForConverterUnits;
        if(isFiatConversion == true) {
            baseTokensForConverterUnits = conversionAmountETHWeiOrFiat.mul(10**18).div(value);
            bonusTokensForConverterUnits = baseTokensForConverterUnits.mul(maxConverterBonusPercent).div(100);
            return (baseTokensForConverterUnits, bonusTokensForConverterUnits);
        } else {
            if(keccak256(currency) != keccak256('ETH')) {
                address ethUSDExchangeContract = ITwoKeySingletoneRegistryFetchAddress(twoKeySingletoneRegistry).getContractProxyAddress("TwoKeyExchangeRateContract");
                uint rate = ITwoKeyExchangeRateContract(ethUSDExchangeContract).getBaseToTargetRate(currency);

                conversionAmountETHWeiOrFiat = (conversionAmountETHWeiOrFiat.mul(rate)).div(10 ** 18); //converting eth to $wei
            }
        }

        baseTokensForConverterUnits = conversionAmountETHWeiOrFiat.mul(10 ** unit_decimals).div(value);
        bonusTokensForConverterUnits = baseTokensForConverterUnits.mul(maxConverterBonusPercent).div(100);
        return (baseTokensForConverterUnits, bonusTokensForConverterUnits);
    }

    /**
     * @notice Function to update MinContributionETH
     * @dev only Contractor can call this method, otherwise it will revert - emits Event when updated
     * @param value is the new value we are going to set for minContributionETH
     */
    function updateMinContributionETHOrUSD(
        uint value
    )
    public
    onlyContractor
    {
        minContributionETHorFiatCurrency = value;
    }

    /**
     * @notice Function to update maxContributionETH
     * @dev only Contractor can call this method, otherwise it will revert - emits Event when updated
     * @param value is the new maxContribution value
     */
    function updateMaxContributionETHorUSD(
        uint value
    )
    external
    onlyContractor
    {
        maxContributionETHorFiatCurrency = value;
    }

    /**
     * @notice Get all constants from the contract
     * @return all constants from the contract
     */
    function getConstantInfo()
    public
    view
    returns (uint,uint,uint,uint,uint,uint,uint)
    {
        return (
            campaignStartTime,
            campaignEndTime,
            minContributionETHorFiatCurrency,
            maxContributionETHorFiatCurrency,
            unit_decimals,
            pricePerUnitInETHWeiOrUSD,
            maxConverterBonusPercent
        );
    }


    /**
    * @notice Function to check balance of the ERC20 inventory (view - no gas needed to call this function)
    * @dev we're using Utils contract and fetching the balance of this contract address
    * @return balance value as uint
    */
    function getInventoryBalance()
    internal
    view
    returns (uint)
    {
        uint balance = IERC20(assetContractERC20).balanceOf(twoKeyAcquisitionCampaign);
        return balance;
    }


    /**
     * @notice Function to check if the msg.sender has already joined
     * @return true/false depending of joined status
     */
    function getAddressJoinedStatus(
        address _address
    )
    public
    view
    returns (bool)
    {
        address plasma = plasmaOf(_address);
        if (_address == address(0)) {
            return false;
        }
        if (plasma == ownerPlasma || _address == address(moderator) ||
        ITwoKeyAcquisitionARC(twoKeyAcquisitionCampaign).getReceivedFrom(plasma) != address(0)
        || ITwoKeyAcquisitionARC(twoKeyAcquisitionCampaign).balanceOf(plasma) > 0) {
            return true;
        }
        return false;
    }



    /**
     * @notice Function to fetch stats for the address
     */
    function getAddressStatistic(
        address _address,
        bool plasma,
        bool flag,
        address referrer
    )
    internal
    view
    returns (bytes)
    {
        bytes32 state; // NOT-EXISTING AS CONVERTER DEFAULT STATE

        address eth_address = ethereumOf(_address);
        address plasma_address = plasmaOf(_address);

        if(_address == contractor) {
            abi.encodePacked(0, 0, 0, false, false);
        } else {
            bool isConverter;
            bool isReferrer;
            uint unitsConverterBought;
            uint amountConverterSpent;
            uint amountConverterSpentFIAT;

            (amountConverterSpent,amountConverterSpentFIAT, unitsConverterBought) = ITwoKeyConversionHandler(twoKeyConversionHandler).getConverterPurchasesStats(eth_address);
            if(unitsConverterBought> 0) {
                isConverter = true;
                state = ITwoKeyConversionHandler(twoKeyConversionHandler).getStateForConverter(eth_address);
            }
            if(referrerPlasma2TotalEarnings2key[plasma_address] > 0) {
                isReferrer = true;
            }

//            if(flag == false) {
//                //referrer is address in signature
//                //plasma_address is plasma address of the address requested in method
//                referrerTotalBalance  = getTotalReferrerEarnings(referrer, eth_address);
//            }

            return abi.encodePacked(
                amountConverterSpent,
                referrerPlasma2TotalEarnings2key[plasma_address],
                unitsConverterBought,
                isConverter,
                isReferrer,
                state
            );
        }
    }

    function recover(
        bytes signature
    )
    internal
    view
    returns (address)
    {
        bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding referrer to plasma")),
            keccak256(abi.encodePacked("GET_REFERRER_REWARDS"))));
        address x = Call.recoverHash(hash, signature, 0);
        return x;
    }

    /**
     * @notice Function to get super statistics
     * @param _user is the user address we want stats for
     * @param plasma is if that address is plasma or not
     * @param signature in case we're calling this from referrer who doesn't have yet opened wallet
     */
    function getSuperStatistics(
        address _user,
        bool plasma,
        bytes signature
    )
    public
    view
    returns (bytes)
    {
        address eth_address = _user;

        if (plasma) {
            (eth_address) = ITwoKeyReg(twoKeyRegistry).getPlasmaToEthereum(_user);
        }

        bytes memory userData = ITwoKeyReg(twoKeyRegistry).getUserData(eth_address);

        bool isJoined = getAddressJoinedStatus(_user);
        bool flag;

        address _address;

        if(msg.sender == contractor || msg.sender == eth_address) {
            flag = true;
        } else {
            _address = recover(signature);
            if(_address == ownerPlasma) {
                flag = true;
            }
        }
        bytes memory stats = getAddressStatistic(_user, plasma, flag, _address);
        return abi.encodePacked(userData, isJoined, eth_address, stats);
    }

    /**
     * @notice Function to return referrers participated in the referral chain
     * @param customer is the one who converted (bought tokens)
     * @param acquisitionCampaignContract is the acquisition campaign address
     * @return array of referrer addresses
     */
    function getReferrers(
        address customer,
        address acquisitionCampaignContract
    )
    public
    view
    returns (address[])
    {
        address influencer = plasmaOf(customer);
        uint n_influencers = 0;

        while (true) {
            influencer = plasmaOf(ITwoKeyAcquisitionARC(acquisitionCampaignContract).getReceivedFrom(influencer));
            if (influencer == plasmaOf(contractor)) {
                break;
            }
            n_influencers++;
        }

        address[] memory influencers = new address[](n_influencers);
        influencer = plasmaOf(customer);

        while (n_influencers > 0) {
            influencer = plasmaOf(ITwoKeyAcquisitionARC(acquisitionCampaignContract).getReceivedFrom(influencer));
            n_influencers--;
            influencers[n_influencers] = influencer;
        }

        return influencers;
    }

    function updateReferrerMappings(address referrerPlasma, uint reward, uint conversionId) internal {
        ITwoKeyAcquisitionCampaignERC20(twoKeyAcquisitionCampaign).updateReferrerPlasmaBalance(referrerPlasma,reward);
        referrerPlasma2TotalEarnings2key[referrerPlasma] = referrerPlasma2TotalEarnings2key[referrerPlasma].add(reward);
        referrerPlasma2EarningsPerConversion[referrerPlasma][conversionId] = reward;
        referrerPlasmaAddressToCounterOfConversions[referrerPlasma] += 1;
    }

    /**
     * @notice Update refferal chain with rewards (update state variables)
     * @param _maxReferralRewardETHWei is the max referral reward set
     * @param _converter is the address of the converter
     * @dev This function can only be called by TwoKeyConversionHandler contract
     */
    function updateRefchainRewards(
        uint256 _maxReferralRewardETHWei,
        address _converter,
        uint _conversionId,
        uint totalBounty2keys
    )
    public
    {
        require(msg.sender == twoKeyAcquisitionCampaign);

        //Get all the influencers
        address[] memory influencers = getReferrers(_converter,twoKeyAcquisitionCampaign);

        //Get array length
        uint numberOfInfluencers = influencers.length;

        uint i;
        uint reward;
        if(incentiveModel == IncentiveModel.VANILLA_AVERAGE) {
            reward = IncentiveModels.averageModelRewards(totalBounty2keys, numberOfInfluencers);
            for(i=0; i<numberOfInfluencers; i++) {
                updateReferrerMappings(influencers[i], reward, _conversionId);

            }
        } else if (incentiveModel == IncentiveModel.VANILLA_AVERAGE_LAST_3X) {
            uint rewardForLast;
            // Calculate reward for regular ones and for the last
            (reward, rewardForLast) = IncentiveModels.averageLast3xRewards(totalBounty2keys, numberOfInfluencers);

            //Update equal rewards to all influencers but last
            for(i=0; i<numberOfInfluencers - 1; i++) {
                updateReferrerMappings(influencers[i], reward, _conversionId);

            }
            //Update reward for last
            updateReferrerMappings(influencers[numberOfInfluencers-1], rewardForLast, _conversionId);
        } else if(incentiveModel == IncentiveModel.VANILLA_POWER_LAW) {
            // Get rewards per referrer
            uint [] memory rewards = IncentiveModels.powerLawRewards(totalBounty2keys, numberOfInfluencers, 2);
            //Iterate through all referrers and distribute rewards
            for(i=0; i<numberOfInfluencers; i++) {
                updateReferrerMappings(influencers[i], rewards[i], _conversionId);
            }
        } else if(incentiveModel == IncentiveModel.MANUAL) {
            for (i = 0; i < numberOfInfluencers; i++) {
                uint256 b;

                if (i == influencers.length - 1) {  // if its the last influencer then all the bounty goes to it.
                    b = totalBounty2keys;
                }
                else {
                    uint256 cut = ITwoKeyAcquisitionCampaignERC20(twoKeyAcquisitionCampaign).getReferrerCut(influencers[i]);
                    if (cut > 0 && cut <= 101) {
                        b = totalBounty2keys.mul(cut.sub(1)).div(100);
                    } else {// cut == 0 or 255 indicates equal particine of the bounty
                        b = totalBounty2keys.div(influencers.length - i);
                    }
                }

                updateReferrerMappings(influencers[i], b, _conversionId);
                //Decrease bounty for distributed
                totalBounty2keys = totalBounty2keys.sub(b);
            }
        }
    }


//    /**
//     * @notice Helper function to get how much _referrer address earned for all conversions for eth_address
//     * @param _referrer is the address we're checking the earnings
//     * @param eth_address is the converter address we're getting all conversion ids for
//     * @return sum of all earnings
//     */
//    function getTotalReferrerEarnings(
//        address _referrer,
//        address eth_address
//    )
//    internal
//    view
//    returns (uint)
//    {
//        uint[] memory conversionIds = ITwoKeyConversionHandler(twoKeyConversionHandler).getConverterConversionIds(eth_address);
//        uint sum = 0;
//        uint len = conversionIds.length;
//        for(uint i=0; i<len; i++) {
//            sum += referrerPlasma2EarningsPerConversion[_referrer][conversionIds[i]];
//        }
//        return sum;
//    }


    /**
     * @notice Function to get balance and total earnings for all referrer addresses passed in arg
     * @param _referrerPlasmaList is the array of plasma addresses of referrer
     * @return two arrays. 1st contains current plasma balance and 2nd contains total plasma balances
     */
    function getReferrersBalancesAndTotalEarnings(
        address[] _referrerPlasmaList
    )
    public
    view
    returns (uint256[], uint256[])
    {
        require(ITwoKeyMaintainersRegistry(twoKeyMaintainersRegistry).onlyMaintainer(msg.sender));

        uint numberOfAddresses = _referrerPlasmaList.length;
        uint256[] memory referrersPendingPlasmaBalance = new uint256[](numberOfAddresses);
        uint256[] memory referrersTotalEarningsPlasmaBalance = new uint256[](numberOfAddresses);

        for (uint i=0; i<numberOfAddresses; i++){
            referrersPendingPlasmaBalance[i] = ITwoKeyAcquisitionCampaignERC20(twoKeyAcquisitionCampaign).getReferrerPlasmaBalance(_referrerPlasmaList[i]);
            referrersTotalEarningsPlasmaBalance[i] = referrerPlasma2TotalEarnings2key[_referrerPlasmaList[i]];
        }

        return (referrersPendingPlasmaBalance, referrersTotalEarningsPlasmaBalance);
    }


    /**
     * @notice Function to fetch for the referrer his balance, his total earnings, and how many conversions he participated in
     * @dev only referrer by himself, moderator, or contractor can call this
     * @param _referrer is the address of referrer we're checking for
     * @param signature is the signature if calling functions from FE without ETH address
     * @param conversionIds are the ids of conversions this referrer participated in
     * @return tuple containing this 3 information
     */
    function getReferrerBalanceAndTotalEarningsAndNumberOfConversions(
        address _referrer,
        bytes signature,
        uint[] conversionIds
    )
    public
    view
    returns (uint,uint,uint,uint[])
    {
        if(_referrer != address(0)) {
            require(msg.sender == _referrer || msg.sender == contractor || ITwoKeyMaintainersRegistry(twoKeyMaintainersRegistry).onlyMaintainer(msg.sender));
            _referrer = plasmaOf(_referrer);
        } else {
            bytes32 hash = keccak256(abi.encodePacked(keccak256(abi.encodePacked("bytes binding referrer to plasma")),
                keccak256(abi.encodePacked("GET_REFERRER_REWARDS"))));
            _referrer = Call.recoverHash(hash, signature, 0);
        }

        uint len = conversionIds.length;
        uint[] memory earnings = new uint[](len);

        for(uint i=0; i<len; i++) {
            earnings[i] = referrerPlasma2EarningsPerConversion[_referrer][conversionIds[i]];
        }

        uint referrerBalance = ITwoKeyAcquisitionCampaignERC20(twoKeyAcquisitionCampaign).getReferrerPlasmaBalance(_referrer);
        return (referrerBalance, referrerPlasma2TotalEarnings2key[_referrer], referrerPlasmaAddressToCounterOfConversions[_referrer], earnings);
    }


    function getReferrerPlasmaTotalEarnings(
        address _referrer
    )
    public
    view
    returns (uint)
    {
        require(msg.sender == twoKeyAcquisitionCampaign);
        return referrerPlasma2TotalEarnings2key[_referrer];
    }

    /**
     * @notice Function to determine plasma address of ethereum address
     * @param me is the address (ethereum) of the user
     * @return an address
     */
    function plasmaOf(
        address me
    )
    public
    view
    returns (address)
    {
        address plasma = ITwoKeyReg(twoKeyRegistry).getEthereumToPlasma(me);
        if (plasma != address(0)) {
            return plasma;
        }
        return me;
    }

    /**
     * @notice Function to determine ethereum address of plasma address
     * @param me is the plasma address of the user
     * @return ethereum address
     */
    function ethereumOf(
        address me
    )
    public
    view
    returns (address)
    {
        address ethereum = ITwoKeyReg(twoKeyRegistry).getPlasmaToEthereum(me);
        if (ethereum != address(0)) {
            return ethereum;
        }
        return me;
    }

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradability/UpgradabilityStorage.sol

pragma solidity ^0.4.24;

/**
 * @title UpgradeabilityStorage
 * @dev This contract holds all the necessary state variables to support the upgrade functionality
 */
contract UpgradeabilityStorage {
    // Versions registry
    ITwoKeySingletonesRegistry internal registry;

    // Address of the current implementation
    address internal _implementation;

    /**
    * @dev Tells the address of the current implementation
    * @return address of the current implementation
    */
    function implementation() public view returns (address) {
        return _implementation;
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/upgradability/Upgradeable.sol

pragma solidity ^0.4.24;

contract Upgradeable is UpgradeabilityStorage {
    /**
     * @dev Validates the caller is the versions registry.
     * @param sender representing the address deploying the initial behavior of the contract
     */
    function initialize(address sender) public payable {
        require(msg.sender == address(registry));
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/singleton-contracts/ITwoKeySingletonUtils.sol

pragma solidity ^0.4.24;


contract ITwoKeySingletonUtils {

    address public TWO_KEY_SINGLETON_REGISTRY;

    // Modifier to restrict method calls only to maintainers
    modifier onlyMaintainer {
        address twoKeyMaintainersRegistry = getAddressFromTwoKeySingletonRegistry("TwoKeyMaintainersRegistry");
        require(ITwoKeyMaintainersRegistry(twoKeyMaintainersRegistry).onlyMaintainer(msg.sender));
        _;
    }

    // Internal function to fetch address from TwoKeyRegTwoistry
    function getAddressFromTwoKeySingletonRegistry(string contractName) internal view returns (address) {
        return ITwoKeySingletoneRegistryFetchAddress(TWO_KEY_SINGLETON_REGISTRY)
        .getContractProxyAddress(contractName);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/IStructuredStorage.sol

pragma solidity ^0.4.0;

contract IStructuredStorage {

    function setProxyLogicContractAndDeployer(address _proxyLogicContract, address _deployer) external;
    function setProxyLogicContract(address _proxyLogicContract) external;

    // *** Getter Methods ***
    function getUint(bytes32 _key) external view returns(uint);
    function getString(bytes32 _key) external view returns(string);
    function getAddress(bytes32 _key) external view returns(address);
    function getBytes(bytes32 _key) external view returns(bytes);
    function getBool(bytes32 _key) external view returns(bool);
    function getInt(bytes32 _key) external view returns(int);
    function getBytes32(bytes32 _key) external view returns(bytes32);

    // *** Getter Methods For Arrays ***
    function getBytes32Array(bytes32 _key) external view returns (bytes32[]);
    function getAddressArray(bytes32 _key) external view returns (address[]);
    function getUintArray(bytes32 _key) external view returns (uint[]);
    function getIntArray(bytes32 _key) external view returns (int[]);
    function getBoolArray(bytes32 _key) external view returns (bool[]);

    // *** Setter Methods ***
    function setUint(bytes32 _key, uint _value) external;
    function setString(bytes32 _key, string _value) external;
    function setAddress(bytes32 _key, address _value) external;
    function setBytes(bytes32 _key, bytes _value) external;
    function setBool(bytes32 _key, bool _value) external;
    function setInt(bytes32 _key, int _value) external;
    function setBytes32(bytes32 _key, bytes32 _value) external;

    // *** Setter Methods For Arrays ***
    function setBytes32Array(bytes32 _key, bytes32[] _value) external;
    function setAddressArray(bytes32 _key, address[] _value) external;
    function setUintArray(bytes32 _key, uint[] _value) external;
    function setIntArray(bytes32 _key, int[] _value) external;
    function setBoolArray(bytes32 _key, bool[] _value) external;

    // *** Delete Methods ***
    function deleteUint(bytes32 _key) external;
    function deleteString(bytes32 _key) external;
    function deleteAddress(bytes32 _key) external;
    function deleteBytes(bytes32 _key) external;
    function deleteBool(bytes32 _key) external;
    function deleteInt(bytes32 _key) external;
    function deleteBytes32(bytes32 _key) external;
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/storage-contracts/ITwoKeyFactoryStorage.sol

pragma solidity ^0.4.24;

contract ITwoKeyFactoryStorage is IStructuredStorage {

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/singleton-contracts/TwoKeyFactory.sol

pragma solidity ^0.4.0;










/**
 * @author Nikola Madjarevic
 * @title Contract used to deploy proxies for other non-singleton contracts
 */
contract TwoKeyFactory is Upgradeable, ITwoKeySingletonUtils {

    bool initialized;

    ITwoKeyFactoryStorage PROXY_STORAGE_CONTRACT;

    event ProxyForCampaign(
        address proxyLogicHandler,
        address proxyConversionHandler,
        address proxyAcquisitionCampaign,
        address proxyPurchasesHandler,
        address contractor
    );

    event ProxyForDonationCampaign(
        address proxyDonationCampaign,
        address proxyDonationConversionHandler,
        address proxyDonationLogicHandler,
        address contractor
    );


    /**
     * @notice Function to set initial parameters for the contract
     * @param _twoKeySingletonRegistry is the address of singleton registry contract
     */
    function setInitialParams(
        address _twoKeySingletonRegistry,
        address _proxyStorage
    )
    public
    {
        require(initialized == false);

        TWO_KEY_SINGLETON_REGISTRY = ITwoKeySingletoneRegistryFetchAddress(_twoKeySingletonRegistry);
        PROXY_STORAGE_CONTRACT = ITwoKeyFactoryStorage(_proxyStorage);
        initialized = true;
    }

    function getLatestContractVersion(string contractName) internal view returns (string) {
        return ITwoKeySingletoneRegistryFetchAddress(TWO_KEY_SINGLETON_REGISTRY).getLatestContractVersion(contractName);
    }


    /**
     * @notice Function used to deploy all necessary proxy contracts in order to use the campaign.
     * @dev This function will handle all necessary actions which should be done on the contract
     * in order to make them ready to work. Also, we've been unfortunately forced to use arrays
     * as arguments since the stack is not deep enough to handle this amount of input information
     * since this method handles kick-start of 3 contracts
     * @param addresses is array of addresses needed [assetContractERC20,moderator]
     * @param valuesConversion is array containing necessary values to start conversion handler contract
     * @param valuesLogicHandler is array of values necessary to start logic handler contract
     * @param values is array containing values necessary to start campaign contract
     * @param _currency is the main currency token price is set
     * @param _nonSingletonHash is the hash of non-singleton contracts active with responding
     * 2key-protocol version at the moment
     */
    function createProxiesForAcquisitions(
        address[] addresses,
        uint[] valuesConversion,
        uint[] valuesLogicHandler,
        uint[] values,
        string _currency,
        string _nonSingletonHash
    )
    public
    payable
    {

        //Deploy proxy for Acquisition contract
        ProxyCampaign proxyAcquisition = new ProxyCampaign(
            "TwoKeyAcquisitionCampaignERC20",
            getLatestContractVersion("TwoKeyAcquisitionCampaignERC20"),
            address(TWO_KEY_SINGLETON_REGISTRY)
        );

        //Deploy proxy for ConversionHandler contract
        ProxyCampaign proxyConversions = new ProxyCampaign(
            "TwoKeyConversionHandler",
            getLatestContractVersion("TwoKeyConversionHandler"),
            address(TWO_KEY_SINGLETON_REGISTRY)
        );

        //Deploy proxy for TwoKeyAcquisitionLogicHandler contract
        ProxyCampaign proxyLogicHandler = new ProxyCampaign(
            "TwoKeyAcquisitionLogicHandler",
            getLatestContractVersion("TwoKeyAcquisitionLogicHandler"),
            address(TWO_KEY_SINGLETON_REGISTRY)
        );


        //Deploy proxy for TwoKeyPurchasesHandler contract
        ProxyCampaign proxyPurchasesHandler = new ProxyCampaign(
            "TwoKeyPurchasesHandler",
            getLatestContractVersion("TwoKeyAcquisitionLogicHandler"),
            address(TWO_KEY_SINGLETON_REGISTRY)
        );


        //        UpgradeableCampaign(proxyPurchasesHandler).initialize.value(msg.value)(msg.sender);
        //        UpgradeableCampaign(proxyLogicHandler).initialize.value(msg.value)(msg.sender);
        //        UpgradeableCampaign(proxyConversions).initialize.value(msg.value)(msg.sender);
        //        UpgradeableCampaign(proxyAcquisition).initialize.value(msg.value)(msg.sender);

        IHandleCampaignDeployment(proxyPurchasesHandler).setInitialParamsPurchasesHandler(
            valuesConversion,
            msg.sender,
            addresses[0],
            getAddressFromTwoKeySingletonRegistry("TwoKeyEventSource"),
            proxyConversions
        );

        // Set initial arguments inside Conversion Handler contract
        IHandleCampaignDeployment(proxyConversions).setInitialParamsConversionHandler(
            valuesConversion,
            proxyAcquisition,
            proxyPurchasesHandler,
            msg.sender,
            addresses[0], //ERC20 address
            getAddressFromTwoKeySingletonRegistry("TwoKeyEventSource"),
            getAddressFromTwoKeySingletonRegistry("TwoKeyBaseReputationRegistry")
        );

        // Set initial arguments inside Logic Handler contract
        IHandleCampaignDeployment(proxyLogicHandler).setInitialParamsLogicHandler(
            valuesLogicHandler,
            _currency,
            addresses[0], //asset contract erc20
            addresses[1], // moderator
            msg.sender,
            proxyAcquisition,
            address(TWO_KEY_SINGLETON_REGISTRY),
            proxyConversions
        );

        // Set initial arguments inside AcquisitionCampaign contract
        IHandleCampaignDeployment(proxyAcquisition).setInitialParamsCampaign(
            address(TWO_KEY_SINGLETON_REGISTRY),
            address(proxyLogicHandler),
            address(proxyConversions),
            addresses[1], //moderator
            addresses[0], //asset contract
            msg.sender, //contractor
            values
        );

        // Validate campaign so it will be approved to interact (and write) to/with our singleton contracts
        ITwoKeyCampaignValidator(getAddressFromTwoKeySingletonRegistry("TwoKeyCampaignValidator"))
        .validateAcquisitionCampaign(proxyAcquisition, _nonSingletonHash);

        setAddressToCampaignType(proxyAcquisition, "TOKEN_SELL");
        // Emit an event with proxies for Acquisition campaign
        emit ProxyForCampaign(
            proxyLogicHandler,
            proxyConversions,
            proxyAcquisition,
            proxyPurchasesHandler,
            msg.sender
        );
    }


    /**
     * @notice Function to deploy proxy contracts for donation campaigns
     */
    function createProxiesForDonationCampaign(
        address _moderator,
        uint [] numberValues,
        bool [] booleanValues,
        string _currency,
        string tokenName,
        string tokenSymbol,
        string nonSingletonHash
    )
    public
    {

        // Deploying a proxy contract for donations
        ProxyCampaign proxyDonationCampaign = new ProxyCampaign(
            "TwoKeyDonationCampaign",
            getLatestContractVersion("TwoKeyDonationCampaign"),
            TWO_KEY_SINGLETON_REGISTRY
        );

        //Deploying a proxy contract for donation conversion handler
        ProxyCampaign proxyDonationConversionHandler = new ProxyCampaign(
            "TwoKeyDonationConversionHandler",
            getLatestContractVersion("TwoKeyDonationConversionHandler"),
            TWO_KEY_SINGLETON_REGISTRY
        );

        //Deploying a proxy contract for donation logic handler
        ProxyCampaign proxyDonationLogicHandler = new ProxyCampaign(
            "TwoKeyDonationLogicHandler",
            getLatestContractVersion("TwoKeyDonationLogicHandler"),
            TWO_KEY_SINGLETON_REGISTRY
        );

        IHandleCampaignDeployment(proxyDonationLogicHandler).setInitialParamsDonationLogicHandler(
            numberValues,
            _currency,
            msg.sender,
            _moderator,
            TWO_KEY_SINGLETON_REGISTRY,
            proxyDonationCampaign,
            proxyDonationConversionHandler
        );

        // Set initial parameters under Donation conversion handler
        IHandleCampaignDeployment(proxyDonationConversionHandler).setInitialParamsDonationConversionHandler(
            tokenName,
            tokenSymbol,
            _currency,
            msg.sender, //contractor
            proxyDonationCampaign,
            address(TWO_KEY_SINGLETON_REGISTRY)
        );

        // Set initial parameters under Donation campaign contract
        IHandleCampaignDeployment(proxyDonationCampaign).setInitialParamsDonationCampaign(
            msg.sender, //contractor
            _moderator, //moderator address
            TWO_KEY_SINGLETON_REGISTRY,
            proxyDonationConversionHandler,
            proxyDonationLogicHandler,
            numberValues,
            booleanValues
        );

        // Validate campaign
        ITwoKeyCampaignValidator(getAddressFromTwoKeySingletonRegistry("TwoKeyCampaignValidator"))
        .validateDonationCampaign(
            proxyDonationCampaign,
            proxyDonationConversionHandler,
            nonSingletonHash
        );

        setAddressToCampaignType(proxyDonationCampaign, "DONATION_CAMPAIGN");

//         Emit an event
        emit ProxyForDonationCampaign(
            proxyDonationCampaign,
            proxyDonationConversionHandler,
            proxyDonationLogicHandler,
            msg.sender
        );
    }

    /**
     * @notice internal function to set address to campaign type
     * @param _campaignAddress is the address of campaign
     * @param _campaignType is the type of campaign (String)
     */
    function setAddressToCampaignType(address _campaignAddress, string _campaignType) internal {
        bytes32 keyHash = keccak256("addressToCampaignType",_campaignAddress);
        PROXY_STORAGE_CONTRACT.setString(keyHash, _campaignType);
    }

    /**
     * @notice Function working as a getter
     * @param _key is the address of campaign
     */
    function addressToCampaignType(address _key) public view returns (string) {
        return PROXY_STORAGE_CONTRACT.getString(keccak256("addressToCampaignType", _key));
    }

}
