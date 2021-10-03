// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "../tokens/nf-token-metadata.sol";

/**
 * @dev This is an example contract implementation of NFToken with metadata extension.
 */
contract NFTokenMetadataMock is
  NFTokenMetadata 
{

  /**
   * @dev Contract constructor.
   * @param _name A descriptive name for a collection of NFTs.
   * @param _symbol An abbreviated name for NFTokens.
   */
  constructor(
    string memory _name,
    string memory _symbol
  )
  {
    nftName = _name;
    nftSymbol = _symbol;
  }

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

  /**
   * @dev A distinct URI (RFC 3986) for a given NFT.
   * @param _tokenId Id for which we want uri.
   * @return URI of _tokenId.
   */
  function tokenURI(
    uint256 _tokenId
  )
    external
    virtual
    override
    view
    returns (string memory)
  {
    return super.tokenURI(_tokenId);
  }

}
