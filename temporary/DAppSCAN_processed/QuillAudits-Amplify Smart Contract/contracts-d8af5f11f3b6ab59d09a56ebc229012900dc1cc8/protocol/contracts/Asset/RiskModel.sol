// File: ../sc_datasets/DAppSCAN/QuillAudits-Amplify Smart Contract/contracts-d8af5f11f3b6ab59d09a56ebc229012900dc1cc8/protocol/contracts/Asset/RiskModel.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Risk {
    struct Data {
        mapping(string => RiskItem) riskItems;
    }

    struct RiskItem {
        uint256 interestRate;
        uint256 advanceRate;
    }
    
    function set(Data storage self, string memory key, uint256 interestRate, uint256 advanceRate) public {
        self.riskItems[key] = RiskItem(interestRate, advanceRate);
    }

    function getInterestRate(Data storage self, string memory key) public view returns (uint256) {
        return self.riskItems[key].interestRate;
    }

    function getAdvanceRate(Data storage self, string memory key) public view returns (uint256) {
        return self.riskItems[key].advanceRate;
    }

    function remove(Data storage self, string memory key) public {
        delete self.riskItems[key];
    }
}
