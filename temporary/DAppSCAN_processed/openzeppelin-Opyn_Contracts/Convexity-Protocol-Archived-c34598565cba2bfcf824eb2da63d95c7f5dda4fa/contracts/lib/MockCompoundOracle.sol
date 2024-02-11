// File: ../sc_datasets/DAppSCAN/openzeppelin-Opyn_Contracts/Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/lib/MockCompoundOracle.sol

pragma solidity 0.5.10;

contract MockCompoundOracle {
    constructor() public {
    }

    uint256 price = 200 * (10 ** 18);
    function getPrice(address asset) public view returns (uint) {
        return price;
    }

    function updatePrice(uint256 newPrice) public {
        price = newPrice * (10 ** 18);
    }
}
