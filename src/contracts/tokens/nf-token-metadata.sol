// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./nf-token.sol";
import "./erc721-metadata.sol";
import "../gen/generator.sol";

/**
 * @dev Optional metadata implementation for ERC-721 non-fungible token standard.
 */
contract NFTokenMetadata is
  NFToken,
  ERC721Metadata
{

  /**
   * @dev A descriptive name for a collection of NFTs.
   */
  string internal nftName;

  /**
   * @dev An abbreviated name for NFTokens.
   */
  string internal nftSymbol;

  /**
   * @notice When implementing this contract don't forget to set nftName and nftSymbol.
   * @dev Contract constructor.
   */
  constructor()
  {
    supportedInterfaces[0x5b5e139f] = true; // ERC721Metadata
  }

  /**
   * @dev Returns a descriptive name for a collection of NFTokens.
   * @return _name Representing name.
   */
  function name()
    external
    override
    view
    returns (string memory _name)
  {
    _name = nftName;
  }

  /**
   * @dev Returns an abbreviated name for NFTokens.
   * @return _symbol Representing symbol.
   */
  function symbol()
    external
    override
    view
    returns (string memory _symbol)
  {
    _symbol = nftSymbol;
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
    validNFToken(_tokenId)
    returns (string memory)
  {
    bytes memory initialColorHex = Generator.getColorHex(_tokenId, 5, 1);
    bytes memory initialColorHexB64=Generator.getb64FromBytes3(initialColorHex);
    bytes memory colorB64x2=Generator.getb64FromBytes3(abi.encodePacked(initialColorHexB64,"I"));
    bytes memory numberB64 = Generator.getb64FromBytes3(Generator.fillString(_tokenId, bytes(" 0\""), 1));
    
    bytes memory gradientEffect = abi.encodePacked(Generator.gradientStartNoId,
        Generator.gradientId);
    
    for(uint i = 0;i<3;i++)
    {
        gradientEffect = abi.encodePacked(gradientEffect,
        Generator.offsetPercent,
        Generator.eightyPercent,
        Generator.offsetColor,
        i==0 ? Generator.lightColorB64x2 : colorB64x2,
        Generator.endOfColorB64x2);
    }
    gradientEffect = abi.encodePacked(gradientEffect,Generator.gradientEnd);
    gradientEffect[40]='S';
    gradientEffect[41]='X';
    gradientEffect[42]='d';

    gradientEffect[57]='H';
    gradientEffect[58]='l';
    
    gradientEffect[94]='R';
    gradientEffect[95]='6';

    gradientEffect[113]='X';
    gradientEffect[114]='p';

    gradientEffect[129]='W';
    gradientEffect[130]='p';
    
    gradientEffect[193]='U';
    gradientEffect[273]='l';
    
    //return string(gradientEffect);
    //UEhKaFpHbGhiRWR5WVdScFpXNTBJR1o0UFNJd0xqVXdJaUJtZVQwaU1DNDFNQ0lnWm5JOUlqQXVNREFpSUNCamVEMGlNQzQxTUNJZ1kzazlJakF1TlRBaUlISTlJakF1TlRBaUlDQnBaRDBpY2lJK0lDQWdJQ0FnUEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0FpT0RBbElpQnpkRzl3TFdOdmJHOXlQU0lqUmtaR1JrWkdJaTgrUEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0FpT0RBbElpQnpkRzl3TFdOdmJHOXlQU0lqTkRJd01FWkdJaTgrUEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0FpT0RBbElpQnpkRzl3TFdOdmJHOXlQU0lqTkRJd01FWkdJaTgrSUR3dmNtRmthV0ZzUjNKaFpHbGxiblEr
    //UEhKaFpHbGhiRWR5WVdScFpXNTBJR1o0UFNJd0xqSXdJaUJtZVQwaU1DNHlNQ0lnWm5JOUlqQXVNREFpSUNCamVEMGlNQzR6TUNJZ1kzazlJakF1TXpBaUlISTlJakF1TWpBaUlDQnBaRDBpY2lJK0lDQWdJQ0FnUEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0FpTURBbElpQnpkRzl3TFdOdmJHOXlQU0lqUmtaR1JrWkdJaTgrUEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0FpTlRBbElpQnpkRzl3TFdOdmJHOXlQU0lqTkRJd01FWkdJaTgrUEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0FpT0RBbElpQnpkRzl3TFdOdmJHOXlQU0lqTkRJd01FWkdJaTgrSUR3dmNtRmthV0ZzUjNKaFpHbGxiblEr
    
    gradientEffect = abi.encodePacked(gradientEffect,Generator.gradientStartNoId,
        Generator.gradientId);

        
    
    for(uint i = 0;i<3;i++)
    {
        gradientEffect = abi.encodePacked(gradientEffect,
        Generator.offsetPercent,
        Generator.eightyPercent,
        Generator.offsetColor,
        i==0 ? colorB64x2 : Generator.darkColorB64x2,
        Generator.endOfColorB64x2);
    }
    gradientEffect = abi.encodePacked(gradientEffect,Generator.gradientEnd);
    
    gradientEffect[472]='Z';
    gradientEffect[473]='3';
    gradientEffect[490]='R';
    gradientEffect[577]='n';
    gradientEffect[625]='U';
    gradientEffect[707]='n';
    gradientEffect[785]='1';
    gradientEffect[787]='r';
    
    bytes memory circlePhi = abi.encodePacked(Generator.circleBegin,
        Generator.circleRadiusPhi,
        Generator.circleEndNoFill,
        Generator.fillGradientB64x2,
        Generator.endOfTagPadded);
    
    circlePhi = abi.encodePacked(circlePhi,
        Generator.animateBeginNoSteps,
        Generator.animateSteps07_06_07,
        Generator.animateDuration,
        Generator.animate7s,
        Generator.animateEnd,
        Generator.circleEndTag);

    circlePhi = abi.encodePacked(Generator.circleBegin,
        Generator.circleRadiusPhi,
        Generator.circleEndNoFill,
        Generator.fillGradientB64x2,
        Generator.endOfTagPadded,
        Generator.circleEndTag,
        circlePhi);

    circlePhi[75]='i';
    circlePhi[76]='e';

    bytes memory orbEffect = abi.encodePacked(
        Generator.circleBegin,
        Generator.circleRadiusBig,
        Generator.circleEndNoFill,
        Generator.darkColorEndTagPaddedB64x2,
        Generator.defsStart);
    
    orbEffect = abi.encodePacked(orbEffect,
        gradientEffect,
        Generator.defsEnd,
        circlePhi,
        Generator.closeSvgJson);

    return string(abi.encodePacked(
        "data:application/json;base64,",
        Generator.backgroundDesc,"T25DaGFpbmVkIFJpbmcgd2l0aCBjb2xvciAj",
        initialColorHexB64,
        "IiwibmFtZSI6IlJpbmcg",
        numberB64,
        Generator.imageDataB64,
        Generator.svgHeaderB64,
        orbEffect));
  }

}
