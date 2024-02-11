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
