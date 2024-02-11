// File: ../sc_datasets/DAppSCAN/Coinfabrik-Worldbit Token Sale Smart Contract Audit/ico-world-bit/contracts/EIP20Token.sol

pragma solidity ^0.4.18;

/**
 * Interface for the standard token.
 * Based on https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
 */
contract EIP20Token {

  function totalSupply() public constant returns (uint256);
  function balanceOf(address who) public constant returns (uint256);
  function transfer(address to, uint256 value) public returns (bool success);
  function transferFrom(address from, address to, uint256 value) public returns (bool success);
  function approve(address spender, uint256 value) public returns (bool success);
  function allowance(address owner, address spender) public constant returns (uint256 remaining);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  /**
  ** Optional functions
  *
  function name() public constant returns (string name);
  function symbol() public constant returns (string symbol);
  function decimals() public constant returns (uint8 decimals);
  *
  **/

}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Worldbit Token Sale Smart Contract Audit/ico-world-bit/contracts/LostAndFoundToken.sol

pragma solidity ^0.4.18;

/**
 * Authored by https://www.coinfabrik.com/
 */

// This contract aims to provide an inheritable way to recover tokens from a contract not meant to hold tokens
// To use this contract, have your token-ignoring contract inherit this one and implement getLostAndFoundMaster to decide who can move lost tokens.
// Of course, this contract imposes support costs upon whoever is the lost and found master.
contract LostAndFoundToken {
  /**
   * @return Address of the account that handles movements.
   */
  function getLostAndFoundMaster() internal constant returns (address);

  /**
   * @param agent Address that will be able to move tokens with transferFrom
   * @param tokens Amount of tokens approved for transfer
   * @param token_contract Contract of the token
   */
  function enableLostAndFound(address agent, uint tokens, EIP20Token token_contract) public {
    require(msg.sender == getLostAndFoundMaster());
    // We use approve instead of transfer to minimize the possibility of the lost and found master
    //  getting them stuck in another address by accident.
    token_contract.approve(agent, tokens);
  }
}
