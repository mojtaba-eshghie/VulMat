// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/campaign-mutual-contracts/ArcERC20.sol

pragma solidity ^0.4.24;

/**
 * @author Nikola Madjarevic
 */
contract ArcERC20 {

    uint256 internal totalSupply_ = 1000000;

    mapping(address => uint256) internal balances;

    /**
    * @dev Total number of tokens in existence
    */
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint256 representing the amount owned by the passed address.
    */
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

}
