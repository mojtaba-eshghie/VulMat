// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-dd7fc9096637a699da64736d44d1bc8aaab53919/contracts/utils/MathUtils.sol

// SPDX-License-Identifier: AGPL-3.0-only

/*
    MathUtils.sol - SKALE Manager
    Copyright (C) 2018-Present SKALE Labs
    @author Dmytro Stebaiev

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

pragma solidity 0.8.11;


library MathUtils {

    uint constant private _EPS = 1e6;

    event UnderflowError(
        uint a,
        uint b
    );    

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
        assert(type(uint).max - _EPS > b);
        return a > b + _EPS;
    }

    function approximatelyEqual(uint256 a, uint256 b) internal pure returns (bool) {
        if (a > b) {
            return a - b < _EPS;
        } else {
            return b - a < _EPS;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-dd7fc9096637a699da64736d44d1bc8aaab53919/contracts/test/MathUtilsTester.sol

// SPDX-License-Identifier: AGPL-3.0-only

/*
    MathUtilsTester.sol - SKALE Manager
    Copyright (C) 2018-Present SKALE Labs
    @author Dmytro Stebaiev

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

pragma solidity 0.8.11;

interface IMathUtilsTester {
    function boundedSub(uint256 a, uint256 b) external returns (uint256);
    function boundedSubWithoutEvent(uint256 a, uint256 b) external pure returns (uint256);
    function muchGreater(uint256 a, uint256 b) external pure returns (bool);
    function approximatelyEqual(uint256 a, uint256 b) external pure returns (bool);
}


contract MathUtilsTester is IMathUtilsTester {
    using MathUtils for uint;

    function boundedSub(uint256 a, uint256 b) external override returns (uint256) {
        return a.boundedSub(b);
    }

    function boundedSubWithoutEvent(uint256 a, uint256 b) external pure override returns (uint256) {
        return a.boundedSubWithoutEvent(b);
    }

    function muchGreater(uint256 a, uint256 b) external pure override returns (bool) {
        return a.muchGreater(b);
    }

    function approximatelyEqual(uint256 a, uint256 b) external pure override returns (bool) {
        return a.approximatelyEqual(b);
    }
}
