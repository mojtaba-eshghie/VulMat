// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/interfaces/ISTO.sol

pragma solidity 0.5.8;

/**
 * @title Interface to be implemented by all STO modules
 */
interface ISTO {

    enum FundRaiseType {ETH, POLY, SC}

    // Event
    event SetFundRaiseTypes(FundRaiseType[] _fundRaiseTypes);

    event RevokePreMintFlag(address indexed _owner, uint256 _tokens, bool _preMint);

    event AllowPreMintFlag(address indexed _owner, uint256 _tokens, bool _preMint);

    /**
     * @notice Returns the total no. of tokens sold
     */
    function getTokensSold() external view returns(uint256 soldTokens);

    /**
     * @notice Returns funds raised by the STO
     */
    function getRaised(FundRaiseType _fundRaiseType) external view returns(uint256 raisedAmount);

    /**
     * @notice Pause (overridden function)
     * @dev Only securityToken owner restriction applied on the super function
     */
    function pause() external;

}
