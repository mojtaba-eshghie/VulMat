// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/Address.sol

pragma solidity 0.4.25;

/**
 * Utility library of inline functions on addresses
 */
library Address {
    /**
     * Returns whether the target address is a contract
     * @dev This function will return false if invoked during the constructor of a contract,
     * as the code is not actually created until after the constructor finishes.
     * @param account address of the account to check
     * @return whether the target address is a contract
     */
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        // XXX Currently there is no better way to check if there is a contract in an address
        // than to check the size of the code at that address.
        // See https://ethereum.stackexchange.com/a/14016/36603
        // for more details about how this works.
        // TODO Check this again before the Serenity release, because all addresses will be
        // contracts then.
        // solium-disable-next-line security/no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/oracle-contract/PriceGetter.sol

pragma solidity 0.4.25;

interface Aggregator {
    function currentAnswer() external view returns(uint256);
    function updatedHeight() external view returns(uint256);
}

contract PriceGetter {
    using Address for address;

    Aggregator aggr;

    uint256 public expiration;

    constructor() public {
        if (address(0x79fEbF6B9F76853EDBcBc913e6aAE8232cFB9De9).isContract()) {
            // mainnet
            aggr = Aggregator(0x79fEbF6B9F76853EDBcBc913e6aAE8232cFB9De9);
            expiration = 120;
        } else if (address(0x0Be00A19538Fac4BE07AC360C69378B870c412BF).isContract()) {
            // ropsten
            aggr = Aggregator(0x0Be00A19538Fac4BE07AC360C69378B870c412BF);
            expiration = 4000;
        } else if (address(0x1AddCFF77Ca0F032c7dCA322fd8bFE61Cae66A62).isContract()) {
            // rinkeby
            aggr = Aggregator(0x1AddCFF77Ca0F032c7dCA322fd8bFE61Cae66A62);
            expiration = 1000;
        } else revert();
    }

    function ethUsdPrice() public view returns (uint256) {
        require(block.number - aggr.updatedHeight() < expiration, "Oracle data are outdated");
        return aggr.currentAnswer() / 1000;
    }
}
