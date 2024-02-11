// File: ../sc_datasets/DAppSCAN/Smartdec-BCShop Smart Contracts Security Analysis/bcshop.io-3023172e3192b317e291a68bc191840e6b5e462c/contracts/common/Random.sol

pragma solidity ^0.4.18;

/**@dev Based on Random Number Generator from Winem project */
contract Random {    
    uint32 state;
    uint32 MAX = 0xffffffff;
    uint32 current;

    function Random(uint32 seed) {
        state = seed;
    }
    
    /**@dev Returns random integer number from the range [min, max], including borders */
    function getInt(uint32 min, uint32 max) public returns (uint32) {
        getNextNumber();        
        current = uint32(min + (uint256(state) * (max + 1 - min) / MAX));
        return current;
    }

    function getNextNumber() internal {
        state = (69069 * state) + 362437;
    }
}
