// File: ../sc_datasets/DAppSCAN/PeckShield-OpenLeverage1.0/openleverage-contracts-e31d971bcb38ec8737cf1942b8fdf6a9452e5834/contracts/test/MockTLAdmin.sol

// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;



contract MockTLAdmin {
    address public admin;
    uint public decimal;
    constructor (address _admin) {
        admin = _admin;
    }

    function changeDecimal(uint _decimal) public {
        require(msg.sender == admin, 'sender is not admin');
        decimal = _decimal;
    }
}
