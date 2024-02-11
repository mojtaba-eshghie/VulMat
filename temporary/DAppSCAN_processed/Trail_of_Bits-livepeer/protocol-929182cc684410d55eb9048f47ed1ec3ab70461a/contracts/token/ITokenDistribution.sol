// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-livepeer/protocol-929182cc684410d55eb9048f47ed1ec3ab70461a/contracts/token/ITokenDistribution.sol

pragma solidity ^0.4.18;


contract ITokenDistribution {
    function isOver() public view returns (bool);
    function getEndTime() public view returns (uint256);
}
