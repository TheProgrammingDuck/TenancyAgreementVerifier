pragma solidity ^0.4.13;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';

contract TenancyCoin is MintableToken {
  string public name = "TENANCY COIN";
  string public symbol = "TEN";
  uint8 public decimals = 18;
}