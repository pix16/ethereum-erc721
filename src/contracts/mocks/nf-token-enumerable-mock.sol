// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "../../contracts/tokens/nf-token-enumerable.sol";

/**
 * @dev This is an example contract implementation of NFToken with enumerable extension.
 */
contract NFTokenEnumerableMock is
  NFTokenEnumerable
{
  /**
   * @dev Removes a NFT from owner.
   * @param _tokenId Which NFT we want to remove.
   */
  function burn(
    uint256 _tokenId
  )
    external
    onlyOwner
  {
    super._burn(_tokenId);
  }

}
