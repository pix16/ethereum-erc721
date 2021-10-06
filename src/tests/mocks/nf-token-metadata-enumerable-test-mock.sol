// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "../../contracts/mocks/nf-token-metadata-enumerable-mock.sol";

contract NFTokenMetadataEnumerableTestMock is
  NFTokenMetadataEnumerableMock
{

  constructor(
    string memory _name,
    string memory _symbol
  )
    NFTokenMetadataEnumerableMock(_name, _symbol)
  {
  }
}
