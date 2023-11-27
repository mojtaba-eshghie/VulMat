## Vulnerability detection results that should be used in conjunction

If the vulneraiblity detected by two tools refers to the same function or same line (depending on detection results) and same type of vulnerability, they should be considered together (for comparison/benchmarking).

## Detection relationship categorization

<table border="1" style="border-collapse: collapse; width: 100%;">
  <tr>
    <th rowspan="2"><b>N</b></th>
    <th rowspan="2"><b>Assigned general category</b></th>
    <th colspan="4"><b>Detectors and Applications</b></th>
  </tr>
  <tr>
    <th><b>Target Applications</b></th>
    <th style="text-align: center;"><b>Slither</b></th>
    <th style="text-align: center;"><b>Smartcheck</b></th>
    <th style="text-align: center;"><b>Semgrep</b></th>
  </tr>

<!-- row 1 -->
  <tr>
    <td rowspan="7" style="text-align: center; border-bottom: 2px solid black;">1</td>
    <td rowspan="7" style="text-align: center; border-bottom: 2px solid black;">Re-entrancy</td>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Compound-borrowfresh-reentrancy</td>
  </tr>
  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Erc721-reentrancy</td>
  </tr>
  <tr>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Curve-readonly-reentrancy</td>
  </tr>
  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Erc777-reentrancy</td>
  </tr>

  <tr>
    <td style="text-align: center;">Tokenization</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">erc677-reentrancy</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Reentrancy-benign</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

  <tr>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Reentrancy-events</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
  </tr>

<!-- row 2 -->

  <tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">2</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">Low-level calls</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Arbitrary-low-level-call</td>
  </tr>

  <!-- row 3 -->

<tr>
    <td rowspan="5" style="text-align: center; border-bottom: 2px solid black;">3</td>
    <td rowspan="5" style="text-align: center; border-bottom: 2px solid black;">Access Control</td>
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

   <!-- row 4 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">4</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">Delegation</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Delegatecall-to-arbitrary-address</td>
</tr>

<!-- row 5 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">5</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">Arithmetic</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Basic-arithmetic-underflow</td>
</tr>

<!-- row 6 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">6</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">Oracle Manipulation</td>
    <td style="text-align: center;">DeFi</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Keeper-network-oracle-manipulation</td>
</tr>

<!-- row 7 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">7</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> Input Validation </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Missing-zero-check</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 8 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">8</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> Shadowing </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">Shadowing-local</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

<!-- row 9 -->

<tr>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;">9</td>
    <td rowspan="1" style="text-align: center; border-bottom: 2px solid black;"> - </td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
    <td style="text-align: center;">N/A</td>
</tr>

</table>
