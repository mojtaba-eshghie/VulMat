// File: ../sc_datasets/DAppSCAN/Coinfabrik-Security Audit for Patientory (PTOY) Token ICO/smart-contracts-master/contracts/security-token/tests/BogusAnnouncement.sol

pragma solidity ^0.4.18;

contract BogusAnnouncement {
  bytes32 public announcementName;
  bytes32 public announcementURI;
  uint256 public announcementType;
  uint256 public announcementHash;

  function BogusAnnouncement(bytes32 _announcementName, bytes32 _announcementURI, uint256 _announcementType, uint256 _announcementHash) public {
    announcementName = _announcementName;
    announcementURI = _announcementURI;
    announcementType = _announcementType;
    announcementHash = _announcementHash;
  }
}
