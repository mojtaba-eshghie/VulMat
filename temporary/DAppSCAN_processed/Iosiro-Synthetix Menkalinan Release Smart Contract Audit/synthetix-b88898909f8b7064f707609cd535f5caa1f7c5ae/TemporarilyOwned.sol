// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Menkalinan Release Smart Contract Audit/synthetix-b88898909f8b7064f707609cd535f5caa1f7c5ae/TemporarilyOwned.sol

pragma solidity ^0.5.16;

contract TemporarilyOwned {
    address public temporaryOwner;
    uint public expiryTime;

    constructor(address _temporaryOwner, uint _ownershipDuration) public {
        require(_temporaryOwner != address(0), "Temp owner address cannot be 0");

        temporaryOwner = _temporaryOwner;
        expiryTime = now + _ownershipDuration;
    }
//SWC-Use of Deprecated Solidity Functions:L11, 20
    modifier onlyTemporaryOwner {
        _onlyTemporaryOwner();
        _;
    }

    function _onlyTemporaryOwner() private view {
        require(now < expiryTime, "Ownership expired");
        require(msg.sender == temporaryOwner, "Only executable by temp owner");
    }
}
