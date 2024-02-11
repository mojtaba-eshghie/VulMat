// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-ac7dafbf461695ad10f41cdb2bcc32d3b9fc9caf/contracts/test-helpers/MockMintableSynthetix.sol

pragma solidity ^0.5.16;

contract MockMintableSynthetix {
    address public mintSecondaryCallAccount;
    uint public mintSecondaryCallAmount;

    address public burnSecondaryCallAccount;
    uint public burnSecondaryCallAmount;

    function mintSecondary(address account, uint amount) external {
        mintSecondaryCallAccount = account;
        mintSecondaryCallAmount = amount;
    }

    function burnSecondary(address account, uint amount) external {
        burnSecondaryCallAccount = account;
        burnSecondaryCallAmount = amount;
    }
}
