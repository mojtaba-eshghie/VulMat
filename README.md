## Vulnerability <-> Detector Relationship Matrix

<table style="border-collapse: collapse; width: 100%;">
  <tr>
    <th rowspan="2"><b>N</b></th>
    <th rowspan="2"><b>General Category</b></th>
    <th colspan="4" style="text-align: center;"><b>Detectors and Applications</b></th>
  </tr>
  <tr>
    <th style="text-align: center;"><b style="text-align: center;">Target Applications</b></th>
    <th style="text-align: center;"><b>Slither</b></th>
    <th style="text-align: center;"><b>Smartcheck</b></th>
    <th style="text-align: center;"><b>Semgrep</b></th>
  </tr>

<!-- row 1 -->
  <tr>
    <td rowspan="10" style="text-align: center; border-bottom: 2px solid black;">1</td>
    <td rowspan="10" style="text-align: center; border-bottom: 2px solid black;"><a href="#reentrancy">Re-entrancy</a></td>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">compound-borrowfresh-reentrancy</td>
  </tr>
  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">erc721-reentrancy</td>
  </tr>
  <tr>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">curve-readonly-reentrancy</td>
  </tr>
  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">erc777-reentrancy</td>
  </tr>

  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">erc677-reentrancy</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">reentrancy-benign</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Reentrancy-events</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">reentrancy-no-eth</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">reentrancy-unlimited-gas</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>
  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">reentrancy-eth</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 2 -->

  <tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">2</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"><a href="#low-level-calls">Low-level calls</a></td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Arbitrary-low-level-call</td>
  </tr>

<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">SOLIDITY_CALL_WITHOUT_DATA</td>
    <td style="text-align: center;">N/A</td>

  </tr>

  <!-- row 3 -->

<tr>
    <td rowspan="10" style="text-align: center; border-bottom: 2px solid black;">3</td>
    <td rowspan="10" style="text-align: center; border-bottom: 2px solid black;"><a href="#access-control">Access Control</a></td>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Compound-sweeptoken-not-restricted</td>
  </tr>

  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Erc20-public-burn</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Accessible-selfdestruct</td>
  </tr>

  <tr>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Oracle-price-update-not-restricted</td>
  </tr>

  <tr>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Uniswap-callback-not-protected</td>
  </tr>

  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">arbitrary-send-erc20</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">arbitrary-send-eth</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">suicidal</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">arbitrary-send-erc20-permit</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">SOLIDITY_TX_ORIGIN</td>
    <td style="text-align: center;">N/A</td>
  </tr>

   <!-- row 4 -->

<tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">4</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"><a href="#delegation">Delegation</a></td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">controlled-delegatecall</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Delegatecall-to-arbitrary-address</td>
</tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">delegatecall-loop</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 5 -->

<tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">5</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"><a href="#arithmetic">Arithmetic</a></td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Basic-arithmetic-underflow</td>
</tr>

<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">divide-before-multiply</td>
    <td style="text-align: center;">SOLIDITY_DIV_MUL</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 6 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">6</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"><a href="#oracle-manipulation">Oracle Manipulation</a></td>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Keeper-network-oracle-manipulation</td>
</tr>

<!-- row 7 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">7</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> <a href="#input-validation">Input Validation</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Missing-zero-check</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 8 -->

<tr>
    <td rowspan="3" style="text-align: center; border-bottom: 2px solid black;">8</td>
    <td rowspan="3" style="text-align: center; border-bottom: 2px solid black;"> <a href="#shadowing">Shadowing</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Shadowing-local</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">shadowing-state</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">shadowing-abstract</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 9 -->

<tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">9</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"> <a href="#compliance">Compliance</a></td>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">erc20-interface</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>
<tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">SOLIDITY_ERC20_TRANSFER_SHOULD_THROW</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 10 -->

<tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">10</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"> <a href="#timestamp">Timestamp</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">timestamp</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">weak-prng</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 11 -->

<tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">11</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"> <a href="#initialization">Initialization</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">uninitialized-local</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>
<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">uninitialized-state</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 12 -->

<tr>
    <td rowspan="3" style="text-align: center; border-bottom: 2px solid black;">12</td>
    <td rowspan="3" style="text-align: center; border-bottom: 2px solid black;"> <a href="#poor-logic-flaws">Poor Logic Flaws</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Incorrect-equality</td>
    <td style="text-align: center;">SOLIDITY_EXACT_TIME, <br/>SOLIDITY_BALANCE_EQUALITY</td>
    <td style="text-align: center;">N/A</td>
</tr>
<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">boolean-cst</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">incorrect-use-of-blockhash</td>
  </tr>

<!-- row 13 -->

<tr>
    <td rowspan="3" style="text-align: center; border-bottom: 2px solid black;">13</td>
    <td rowspan="3" style="text-align: center; border-bottom: 2px solid black;"> <a href="#denial-of-service">Denial of Service</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">locked-ether</td>
    <td style="text-align: center;">SOLIDITY_LOCKED_MONEY</td>
    <td style="text-align: center;">N/A</td>
</tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">calls-loop</td>
    <td style="text-align: center;">SOLIDITY_TRANSFER_IN_LOOP</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">msg-value-loop</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 14 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">14</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> <a href="#state-corruption">State Corruption</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">controlled-array-length</td>
    <td style="text-align: center;">SOLIDITY_ARRAY_LENGTH_MANIPULATION</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 15 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">15</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> <a href="#function-behavior">Function Behavior</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">incorrect-modifier</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 16 -->

<tr>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;">16</td>
    <td rowspan="2" style="text-align: center; border-bottom: 2px solid black;"> <a href="#external-call-validation">External Call Validation</a> </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">unchecked-transfer</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">unchecked-lowlevel</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 17 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">17</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> Front-Running </td>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">SOLIDITY_ERC20_APPROVE</td>
    <td style="text-align: center;">N/A</td>
</tr>

</table>

## General Category Descriptions

<a id="reentrancy"></a>

### Re-entrancy

Any vulnerability directly related to reentrant feature of smart contract execution.

<a id="low-level-calls"></a>

### Low-level Calls

This category is concerned with the way low-level calls are made. Especially, it concerns the way `data` field of the call is assigned (data source, being checked, etc.).

<a id="access-control"></a>

### Access Control

Detectors that detect any authentication/authorization vulnerability fall into this category. This includes authorizing the function caller and checking their permissions in callee function or setting up an external call with the correct attributes in the caller function.

<a id="delegation"></a>

### Delegation

Delegation is a tricky subject in smart contracts as delegated calls could be exploited by malicious callee to bypass access control mechanism of the contract, and in extreme cases take over the whole contract by setting the state variables pertaining to certain high-permissioned roles.

<a id="arithmetic"></a>

### Arithmetic

Any vulnerability and accordingly detector pertaining to the way arithmetic operations are performed and ordered on blockchain.

<a id="oracle-manipulation"></a>

### Oracle Manipulation

Exploitations regarding changing the integrity of data gathered with the help of oracles; both in the oracle service contract and the user contract.

<a id="input-validation"></a>

### Input Validation

Instances of this vulnerability class are failing to perform checks on arbitrary user-supplied data not to be uninitialized or with malicious data in a general sense.

<a id="shadowing"></a>

### Shadowing

Occurs when a variable from a scope has the same identifier from another scope resulting in the unintended value to be used during runtime.

<a id="compliance"></a>

### Compliance

Failing to comply to the specification of the standard in the contract implementation. The least severe effect will be the interacting contracts/users (who expect the correct complying implementation) will fail to execute external calls/transactions to the function (reverted transactions if external call validation is implemented).

<a id="timestamp"></a>

### Timestamp

Usage of unreliable/inaccurate blockchain timestamp primitive in critical scenarios such as random number generation or for checking conditions with high accuracy.

<a id="initialization"></a>

### Initialization

Failing to initialize (function-local/state) variables.

<a id="poor-logic-flaws"></a>

### Poor Logic Flaws

This class concerns using conditional statements that are poorly designed, and might not result in intended way. Additionally, relying on poorly designed boolean conditions that could be manipulated by an interacting user leads to an exploit.

<a id="denial-of-service"></a>

### Denial of Service

Vulnerabilities related to a function in the contract not functioning as intended. Transactions to the vulnerable function might be reverted because of poorly designed usage of loops and msg.\* constructs.

<a id="state-corruption"></a>

### State Corruption

The contract state is corrupted or manipulated in unintended ways.

<a id="function-behavior"></a>

### Function Behavior

This category encompasses vulnerabilties related to the behavior and flow of execution within functions, including the use of modifiers.

<a id="external-call-validation"></a>

### External Call Validation

The core issue here is ensuring that transactions or external function calls (especially token transfers) are executed as intended and their outcomes are validated.
Proper handling of external calls (transfer, transferFrom, etc.) and checking their return values, which is a key aspect of transaction handling in smart contract development.

## Notes

- **N/A for target application**: This means the vulnerability does not pertain to a specific high-level application category.
- **Vulnerability detection results that should be used in conjunction**: If the vulneraiblity detected by two tools refers to the same bug localization point (same function, same line, same code snippet depending on different detectors) and same type of vulnerability, they should be considered together (for comparison/benchmarking).

## References

[The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend.](https://eips.ethereum.org/EIPS/eip-20)
