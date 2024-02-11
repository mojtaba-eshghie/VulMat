// File: ../sc_datasets/DAppSCAN/PeckShield-Venus/venus-protocol-48c7400f668116f5e5fa92299e28cf16b49b485c/contracts/VAIControllerInterface.sol

pragma solidity ^0.5.16;

contract VAIControllerInterface {
    function getVAIAddress() public view returns (address);
    function getMintableVAI(address minter) public view returns (uint, uint);
    function mintVAI(address minter, uint mintVAIAmount) external returns (uint);
    function repayVAI(address repayer, uint repayVAIAmount) external returns (uint);

    function _initializeVenusVAIState(uint blockNumber) external returns (uint);
    function updateVenusVAIMintIndex() external returns (uint);
    function calcDistributeVAIMinterVenus(address vaiMinter) external returns(uint, uint, uint, uint);
}
