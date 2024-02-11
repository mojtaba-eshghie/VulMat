// File: ../sc_datasets/DAppSCAN/openzeppelin-Opyn_Contracts/Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/lib/MockUniswapFactory.sol

pragma solidity 0.5.10;

contract MockUniswapFactory {

    constructor () public {
    }

    address public exchangeTemplate;
    uint256 public tokenCount;
    // Create Exchange
    function createExchange(address token) external returns (address exchange) {
        return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    }
    // Get Exchange and Token Info
    function getExchange(address token) external view returns (address exchange){
        return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    }
    function getToken(address exchange) external view returns (address token) {
        return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    }
    function getTokenWithId(uint256 tokenId) external view returns (address token) {
        return 0x06D014475F84Bb45b9cdeD1Cf3A1b8FE3FbAf128;
    }
    // Never use
    function initializeFactory(address template) external {
    }
}
