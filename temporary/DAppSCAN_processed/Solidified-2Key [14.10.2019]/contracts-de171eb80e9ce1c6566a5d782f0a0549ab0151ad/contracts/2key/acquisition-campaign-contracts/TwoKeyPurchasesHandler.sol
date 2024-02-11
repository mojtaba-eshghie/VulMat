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
