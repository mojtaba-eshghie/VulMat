// File: ../sc_datasets/DAppSCAN/Quantstamp-RariCapital V2/rari-stable-pool-contracts-7f351ca3df72a0196f3640f30a6db73660ab1467/contracts/external/aave/AToken.sol

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.5.17;

/**
 * @title Aave ERC20 AToken
 * @dev Implementation of the interest bearing token for the DLP protocol.
 * @author Aave
 */
contract AToken {
    /**
     * @dev redeems aToken for the underlying asset
     * @param _amount the amount being redeemed
     */
    function redeem(uint256 _amount) external;

    /**
     * @dev calculates the balance of the user, which is the
     * principal balance + interest generated by the principal balance + interest generated by the redirected balance
     * @param _user the user for which the balance is being calculated
     * @return the total balance of the user
     */
    function balanceOf(address _user) public view returns (uint256);
}