//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
 * @title Ownable contract
 * @author Abinash Burman (@itsabinashb)
 * @notice :=
 *  1. there are seperate functions to set each owner variables.
 *  2. Same address cannot be assigned more than 1 time as owner.
 *  3. address(0) cannot be assigned as owner.
 *  4. Any of 3 owners can call all 3 functions to set new owners, usefull if a owner lost is private key then other owners can assign another address as admin.
 *  5. Any owner renounce their ownership whenever they wants, after renouncing the variable will be set with zero address i.e address(0)
 */

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
