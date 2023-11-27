//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import './Ownable.sol';

contract Test is Ownable {
  constructor(address _owner1, address _owner2, address _owner3) Ownable(_owner1, _owner2, _owner3) {}

  uint public number;

  function assignNumber(uint _num) external onlyOwner {
    number = _num;
  }
}
