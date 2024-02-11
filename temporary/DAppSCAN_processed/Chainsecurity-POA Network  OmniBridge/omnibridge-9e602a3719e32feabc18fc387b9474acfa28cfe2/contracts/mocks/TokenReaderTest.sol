// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/libraries/TokenReader.sol

pragma solidity 0.7.5;

// solhint-disable
interface ITokenDetails {
    function name() external view;
    function NAME() external view;
    function symbol() external view;
    function SYMBOL() external view;
    function decimals() external view;
    function DECIMALS() external view;
}
// solhint-enable

/**
 * @title TokenReader
 * @dev Helper methods for reading name/symbol/decimals parameters from ERC20 token contracts.
 */
library TokenReader {
    /**
     * @dev Reads the name property of the provided token.
     * Either name() or NAME() method is used.
     * Both, string and bytes32 types are supported.
     * @param _token address of the token contract.
     * @return token name as a string or an empty string if none of the methods succeeded.
     */
    function readName(address _token) internal view returns (string memory) {
        (bool status, bytes memory data) = _token.staticcall(abi.encodeWithSelector(ITokenDetails.name.selector));
        if (!status) {
            (status, data) = _token.staticcall(abi.encodeWithSelector(ITokenDetails.NAME.selector));
            if (!status) {
                return "";
            }
        }
        return _convertToString(data);
    }

    /**
     * @dev Reads the symbol property of the provided token.
     * Either symbol() or SYMBOL() method is used.
     * Both, string and bytes32 types are supported.
     * @param _token address of the token contract.
     * @return token symbol as a string or an empty string if none of the methods succeeded.
     */
    function readSymbol(address _token) internal view returns (string memory) {
        (bool status, bytes memory data) = _token.staticcall(abi.encodeWithSelector(ITokenDetails.symbol.selector));
        if (!status) {
            (status, data) = _token.staticcall(abi.encodeWithSelector(ITokenDetails.SYMBOL.selector));
            if (!status) {
                return "";
            }
        }
        return _convertToString(data);
    }

    /**
     * @dev Reads the decimals property of the provided token.
     * Either decimals() or DECIMALS() method is used.
     * @param _token address of the token contract.
     * @return token decimals or 0 if none of the methods succeeded.
     */
    function readDecimals(address _token) internal view returns (uint8) {
        (bool status, bytes memory data) = _token.staticcall(abi.encodeWithSelector(ITokenDetails.decimals.selector));
        if (!status) {
            (status, data) = _token.staticcall(abi.encodeWithSelector(ITokenDetails.DECIMALS.selector));
            if (!status) {
                return 0;
            }
        }
        return abi.decode(data, (uint8));
    }

    /**
     * @dev Internal function for converting returned value of name()/symbol() from bytes32/string to string.
     * @param returnData data returned by the token contract.
     * @return string with value obtained from returnData.
     */
    function _convertToString(bytes memory returnData) private pure returns (string memory) {
        if (returnData.length > 32) {
            return abi.decode(returnData, (string));
        } else if (returnData.length == 32) {
            bytes32 data = abi.decode(returnData, (bytes32));
            string memory res = new string(32);
            assembly {
                let len := 0
                mstore(add(res, 32), data) // save value in result string

                // solhint-disable
                for { } gt(data, 0) { len := add(len, 1) } { // until string is empty
                    data := shl(8, data) // shift left by one symbol
                }
                // solhint-enable
                mstore(res, len) // save result string length
            }
            return res;
        } else {
            return "";
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/mocks/TokenReaderTest.sol

/* solhint-disable */
pragma solidity 0.7.5;

contract Token1 {
    function name() external pure returns (string memory) {
        return "Token";
    }

    function symbol() external pure returns (string memory) {
        return "TKN";
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }
}

contract Token2 {
    function NAME() external pure returns (string memory) {
        return "Token";
    }

    function SYMBOL() external pure returns (string memory) {
        return "TKN";
    }

    function DECIMALS() external pure returns (uint8) {
        return 18;
    }
}

contract Token3 {
    function name() external pure returns (bytes32) {
        return bytes32("Token");
    }

    function symbol() external pure returns (bytes32) {
        return bytes32("TKN");
    }

    function decimals() external pure returns (uint256) {
        return 9;
    }
}

contract Token4 {
    function NAME() external pure returns (bytes32) {
        return bytes32("Token");
    }

    function SYMBOL() external pure returns (bytes32) {
        return bytes32("TKN");
    }
}

contract Token5 {
    function name() external pure returns (bytes32) {
        return bytes32("0123456789abcdef0123456789abcdef");
    }

    function SYMBOL() external pure returns (bytes32) {
        return bytes32("0123456789abcdef0123456789abcdef");
    }
}

contract Token6 {
    function NAME() external pure returns (string memory) {
        return "0123456789abcdef0123456789abcdefX";
    }

    function symbol() external pure returns (string memory) {
        return "0123456789abcdef0123456789abcdefY";
    }
}

contract Token7 {
    function symbol() external pure returns (string memory) {
        return "";
    }

    function decimals() external pure returns (uint8) {
        return 0;
    }
}

contract Token8 {
    fallback() external {
        revert("Error message");
    }
}

contract TokenReaderTest {
    function test1() external {
        address token = address(new Token1());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256("Token"));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256("TKN"));
        require(TokenReader.readDecimals(token) == 18);
    }

    function test2() external {
        address token = address(new Token2());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256("Token"));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256("TKN"));
        require(TokenReader.readDecimals(token) == 18);
    }

    function test3() external {
        address token = address(new Token3());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256("Token"));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256("TKN"));
        require(TokenReader.readDecimals(token) == 9);
    }

    function test4() external {
        address token = address(new Token4());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256("Token"));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256("TKN"));
        require(TokenReader.readDecimals(token) == 0);
    }

    function test5() external {
        address token = address(new Token5());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256("0123456789abcdef0123456789abcdef"));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256("0123456789abcdef0123456789abcdef"));
        require(TokenReader.readDecimals(token) == 0);
    }

    function test6() external {
        address token = address(new Token6());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256("0123456789abcdef0123456789abcdefX"));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256("0123456789abcdef0123456789abcdefY"));
        require(TokenReader.readDecimals(token) == 0);
    }

    function test7() external {
        address token = address(new Token7());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256(""));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256(""));
        require(TokenReader.readDecimals(token) == 0);
    }

    function test8() external {
        address token = address(new Token8());

        require(keccak256(abi.encodePacked(TokenReader.readName(token))) == keccak256(""));
        require(keccak256(abi.encodePacked(TokenReader.readSymbol(token))) == keccak256(""));
        require(TokenReader.readDecimals(token) == 0);
    }
}
/* solhint-enable */
