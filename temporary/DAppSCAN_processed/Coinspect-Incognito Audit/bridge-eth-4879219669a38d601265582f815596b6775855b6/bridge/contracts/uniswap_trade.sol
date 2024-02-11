// File: ../sc_datasets/DAppSCAN/Coinspect-Incognito Audit/bridge-eth-4879219669a38d601265582f815596b6775855b6/bridge/contracts/IERC20.sol

pragma solidity ^0.6.6;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see `ERC20Detailed`.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transfer(address recipient, uint amount) external;

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an `Approval` event.
     */
    function approve(address spender, uint amount) external;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transferFrom(address sender, address recipient, uint amount) external;

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() external view returns (uint);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to `approve`. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint value);
}

// File: ../sc_datasets/DAppSCAN/Coinspect-Incognito Audit/bridge-eth-4879219669a38d601265582f815596b6775855b6/bridge/contracts/trade_utils.sol

pragma solidity ^0.6.6;

contract TradeUtils {
	IERC20 constant public ETH_CONTRACT_ADDRESS = IERC20(0x0000000000000000000000000000000000000000);

	function balanceOf(IERC20 token) internal view returns (uint256) {
		if (token == ETH_CONTRACT_ADDRESS) {
			return address(this).balance;
		}
        return token.balanceOf(address(this));
    }

	function transfer(IERC20 token, uint amount) internal {
		if (token == ETH_CONTRACT_ADDRESS) {
			require(address(this).balance >= amount);
			(bool success, ) = msg.sender.call{value: amount}("");
          	require(success);
		} else {
			token.transfer(msg.sender, amount);
			require(checkSuccess());
		}
	}

	function approve(IERC20 token, address proxy, uint amount) internal {
		if (token != ETH_CONTRACT_ADDRESS) {
			token.approve(proxy, 0);
			require(checkSuccess());
			token.approve(proxy, amount);
			require(checkSuccess());
		}
	}

	/**
     * @dev Check if transfer() and transferFrom() of ERC20 succeeded or not
     * This check is needed to fix https://github.com/ethereum/solidity/issues/4116
     * This function is copied from https://github.com/AdExNetwork/adex-protocol-eth/blob/master/contracts/libs/SafeERC20.sol
     */
    function checkSuccess() internal pure returns (bool) {
		uint256 returnValue = 0;

		assembly {
			// check number of bytes returned from last function call
			switch returndatasize()

			// no bytes returned: assume success
			case 0x0 {
				returnValue := 1
			}

			// 32 bytes returned: check if non-zero
			case 0x20 {
				// copy 32 bytes into scratch space
				returndatacopy(0x0, 0x0, 0x20)

				// load those bytes into returnValue
				returnValue := mload(0x0)
			}

			// not sure what was returned: don't mark as success
			default { }
		}
		return returnValue != 0;
	}
}

// File: ../sc_datasets/DAppSCAN/Coinspect-Incognito Audit/bridge-eth-4879219669a38d601265582f815596b6775855b6/bridge/contracts/uniswap_trade.sol

pragma solidity ^0.6.6;


interface UniswapV2 {
  function factory() external pure returns (address);
  function WETH() external pure returns (address);

  function swapExactTokensForTokens(
      uint amountIn,
      uint amountOutMin,
      address[] calldata path,
      address to,
      uint deadline
  ) external returns (uint[] memory amounts);
  function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
      external
      payable
      returns (uint[] memory amounts);
  function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
      external
      returns (uint[] memory amounts);
  function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
}

contract UniswapV2Trade is TradeUtils {
    // Variables
    UniswapV2 public uniswapV2;
    address public wETH;

    // Functions
    /**
     * @dev Contract constructor
     * @param _uniswapV2 uniswap routes contract address
     */
    constructor(UniswapV2 _uniswapV2) public {
        uniswapV2 = _uniswapV2;
        wETH = uniswapV2.WETH();
    }

    // Reciever function which allows transfer eth.
    receive() external payable {}

    function trade(IERC20 srcToken, uint srcQty, IERC20 destToken, uint amountOutMin) public payable returns (address, uint) {
        require(balanceOf(srcToken) >= srcQty);
        require(srcToken != destToken);
        address[] memory path = new address[](2);
        uint[] memory amounts;
        if (srcToken != ETH_CONTRACT_ADDRESS) {
            path[0] = address(srcToken);
            // approve
            approve(srcToken, address(uniswapV2), srcQty);
            if (destToken != ETH_CONTRACT_ADDRESS) { // token to token.
                path[1] = address(destToken);
                amounts = tokenToToken(path, srcQty, amountOutMin);
            } else {
                path[1] = address(wETH);
                amounts = tokenToEth(path, srcQty, amountOutMin);
            }
        } else {
            path[0] = address(wETH);
            path[1] = address(destToken);
            amounts = ethToToken(path, srcQty, amountOutMin);
        }
        require(amounts.length >= 2);
        require(amounts[amounts.length - 1] >= amountOutMin && amounts[0] == srcQty);
        return (address(destToken), amounts[amounts.length - 1]);
    }

    function ethToToken(address[] memory path, uint srcQty, uint amountOutMin) internal returns (uint[] memory) {
        return uniswapV2.swapExactETHForTokens{value: srcQty}(amountOutMin, path, msg.sender, now + 600);
    }

    function tokenToEth(address[] memory path, uint srcQty, uint amountOutMin) internal returns (uint[] memory) {
        return uniswapV2.swapExactTokensForETH(srcQty, amountOutMin, path, msg.sender, now + 600);
    }

    function tokenToToken(address[] memory path, uint srcQty, uint amountOutMin) internal returns (uint[] memory) {
        return uniswapV2.swapExactTokensForTokens(srcQty, amountOutMin, path, msg.sender, now + 600);
    }

    /**
     * @dev Given an input asset amount and an array of token addresses, calculates all subsequent maximum output token.
     * @param srcToken source token contract address
     * @param srcQty amount of source tokens
     * @param destToken destination token contract address
     */
    function getAmountsOut(address srcToken, uint srcQty, address destToken) external view returns(uint[] memory) {
        address[] memory path = new address[](2);
        path[0] = srcToken;
        path[1] = destToken;
        return uniswapV2.getAmountsOut(srcQty, path);
    }
}
