//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

abstract contract Ownable {
  address public owner1;
  address public owner2;
  address public owner3;

  error Zero_address();
  error Unauthorized_caller(address caller);
  error Already_set_as_owner();

  constructor(address _owner1, address _owner2, address _owner3) {
    if (_owner1 == address(0) || _owner2 == address(0) || _owner3 == address(0)) {
      revert Zero_address();
    }

    owner1 = _owner1;
    owner2 = _owner2;
    owner3 = _owner3;
  }

  function changeFirstOwner(address _newOwner) external onlyOwner {
    if (owner2 == _newOwner || owner3 == _newOwner || owner1 == _newOwner) {
      revert Already_set_as_owner();
    }
    if (_newOwner == address(0)) {
      revert Zero_address();
    }
    owner1 = _newOwner;
  }

  function changeSecondOwner(address _newOwner) external onlyOwner {
    if (owner1 == _newOwner || owner3 == _newOwner || owner2 == _newOwner) {
      revert Already_set_as_owner();
    }
    if (_newOwner == address(0)) {
      revert Zero_address();
    }
    owner2 = _newOwner;
  }

  function changeThirdOwner(address _newOwner) external onlyOwner {
    if (owner1 == _newOwner || owner2 == _newOwner || owner3 == _newOwner) {
      revert Already_set_as_owner();
    }
    if (_newOwner == address(0)) {
      revert Zero_address();
    }
    owner3 = _newOwner;
  }

  function renounceOwnership() external onlyOwner {
    if (msg.sender == owner1) {
      owner1 = address(0);
    } else if (msg.sender == owner2) {
      owner2 = address(0);
    } else if (msg.sender == owner3) {
      owner3 = address(0);
    } else {
      revert Unauthorized_caller(msg.sender);
    }
  }

  modifier onlyOwner() {
    if (msg.sender != owner1 && msg.sender != owner2 && msg.sender != owner3) {
      revert Unauthorized_caller(msg.sender);
    }
    _;
  }
}
