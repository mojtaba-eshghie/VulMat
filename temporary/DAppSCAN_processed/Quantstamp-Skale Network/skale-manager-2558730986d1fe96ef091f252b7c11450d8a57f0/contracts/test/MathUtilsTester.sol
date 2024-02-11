// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/utils/MathUtils.sol

/*
    StringUtils.sol - SKALE Manager
    Copyright (C) 2018-Present SKALE Labs
    @author DmytroStebaiev

    SKALE Manager is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SKALE Manager is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with SKALE Manager.  If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity 0.5.16;


library MathUtils {
    event UnderflowError(
        uint a,
        uint b
    );

    uint constant EPS = 1e6;

    function boundedSub(uint256 a, uint256 b) internal returns (uint256) {
        if (a >= b) {
            return a - b;
        } else {
            emit UnderflowError(a, b);
            return 0;
        }
    }

    function boundedSubWithoutEvent(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a >= b) {
            return a - b;
        } else {
            return 0;
        }
    }

    function muchGreater(uint256 a, uint256 b) internal pure returns (bool) {
        assert(uint(-1) - EPS > b);
        return a > b + EPS;
    }

    function approximatelyEqual(uint256 a, uint256 b) internal pure returns (bool) {
        if (a > b) {
            return a - b < EPS;
        } else {
            return b - a < EPS;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/test/MathUtilsTester.sol

pragma solidity 0.5.16;

contract MathUtilsTester {
    using MathUtils for uint;

    function boundedSub(uint256 a, uint256 b) external returns (uint256) {
        return a.boundedSub(b);
    }

    function boundedSubWithoutEvent(uint256 a, uint256 b) external pure returns (uint256) {
        return a.boundedSubWithoutEvent(b);
    }

    function muchGreater(uint256 a, uint256 b) external pure returns (bool) {
        return a.muchGreater(b);
    }

    function approximatelyEqual(uint256 a, uint256 b) external pure returns (bool) {
        return a.approximatelyEqual(b);
    }
}
