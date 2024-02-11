// File: ../sc_datasets/DAppSCAN/Iosiro-Nexus Mutual Stacked Risk, On-chain MCR, and Swap Operator Smart Contract Audit/smart-contracts-d38ab4145a2a3d0b9d2de871ce646cf40b3b210a/contracts/mocks/Pool/P1MockMCR.sol

/* Copyright (C) 2020 NexusMutual.io

  This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

  This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/ */

pragma solidity ^0.5.17;

contract P1MockMCR {
    uint public mcr;

    function getMCR() public view returns (uint) {
        return mcr;
    }

    function changeMasterAddress(address) external {
        // no-op
    }

    function changeDependentContractAddress() external {
        // no-op
    }

    function setMCR(uint _mcr) public  {
        mcr = _mcr;
    }

    function updateMCR(uint) external {
        // no-op
    }

    function updateMCRInternal(uint, bool) public {
        // no-op
    }
}
