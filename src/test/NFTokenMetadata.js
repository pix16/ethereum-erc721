// test/NFTokenMetadata.js
// Load dependencies
const { expect } = require('chai');

// Import utilities from Test Helpers
const { BN, expectEvent, expectRevert } = require('@openzeppelin/test-helpers');


// Load compiled artifacts
const Rings = artifacts.require('NFTokenMetadata');
const buyer='0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0';
const owner='0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1';
const operatorAllTokens = '0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b';
const operatorAllTokens2 = '0xd03ea8624C8C5987235048901fB614fDcA89b117';
const operatorSingleToken = '0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d'
const zeroAddress = '0x0000000000000000000000000000000000000000';
const initialSupply = 61;

// Start test block
contract('Rings', function () {
    // Use large integers ('big numbers')
  const tokenId = (initialSupply-1).toString();
  
  beforeEach(async function () {
    // Deploy a new Rings contract for each test
    this.Rings = await Rings.new();
  });

  it('Total supply', async function () {
    expect((await this.Rings.totalSupply()).toString()).to.equal(initialSupply.toString());
  });

  it('Token URIs', async function () {
    this.timeout(1000000);
    for(var i=0;i<5;//initialSupply;
        i++){
        console.log("tokenURI for token ",i);
        var uri=await this.Rings.tokenURI(i);
        console.log(uri);
    }
  });

  /* we no longer need this test, since contract is now Ownable, and should be edited on the marketplace website
  it('Contract URI', async function () {

    uri=await this.Rings.contractURI();
  });*/

  it('Ownable', async function () {
    expect((await this.Rings.owner()).toString()).to.equal(owner);
    const receipt = await this.Rings.transferOwnership(buyer);
    expectEvent(receipt, 'OwnershipTransferred', { previousOwner: owner, newOwner: buyer });
    expect((await this.Rings.owner()).toString()).to.equal(buyer);
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('0');
  });

  // Test case
  it('Transfer a token', async function () {
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('0');
    const receipt = await this.Rings.transferFrom(owner,buyer,tokenId);
    expectEvent(receipt, 'Transfer', { _from: owner, _to: buyer, _tokenId:tokenId });
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('1');
    expect((await this.Rings.ownerOf(tokenId)).toString()).to.equal(buyer);
    await expectRevert(this.Rings.transferFrom(owner,buyer,tokenId), '003004');
  });

  // Test case
  it('Burn a token', async function () {
    await this.Rings.transferFrom(owner,buyer,tokenId)
    const receipt = await this.Rings.burnToken(tokenId,{ from: buyer });
    expectEvent(receipt, 'Transfer', { _from: buyer, _to: zeroAddress, _tokenId:tokenId });
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('0');
    expect((await this.Rings.totalSupply()).toString()).to.equal((initialSupply-1).toString());  
    await expectRevert(this.Rings.ownerOf(tokenId), '404');
    await expectRevert(this.Rings.tokenURI(tokenId), '404');
  });//*/

  // Test case
  it('Approve for a token and transfer', async function () {
    expect((await this.Rings.getApproved(tokenId)).toString()).to.equal(zeroAddress);
    const receipt = await this.Rings.approve(operatorSingleToken, tokenId)
    expectEvent(receipt, 'Approval', { _owner: owner, _approved: operatorSingleToken, _tokenId:tokenId });
    expect((await this.Rings.getApproved(tokenId)).toString()).to.equal(operatorSingleToken);
    
    await this.Rings.transferFrom(owner,buyer,tokenId,{ from: operatorSingleToken })
    expect((await this.Rings.ownerOf(tokenId)).toString()).to.equal(buyer);
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('1');
    expect((await this.Rings.getApproved(tokenId)).toString()).to.equal(zeroAddress);
    
  });//*/

  it('Approve for a token and burn', async function () {
    await this.Rings.transferFrom(owner,buyer,tokenId)
    
    await this.Rings.approve(operatorSingleToken, tokenId,{ from: buyer })
    await this.Rings.burnToken(tokenId,{ from: operatorSingleToken });
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('0');
    
  });//*/

  // Test case
  it('Approve for all tokens and transfer', async function () {
    
    expect((await this.Rings.isApprovedForAll(owner, operatorAllTokens)).toString()).to.equal('false');
    const receipt = await this.Rings.setApprovalForAll(operatorAllTokens, true) 
    expectEvent(receipt, 'ApprovalForAll', { _owner: owner, _operator: operatorAllTokens, _approved:true});
    
    expect((await this.Rings.isApprovedForAll(owner, operatorAllTokens)).toString()).to.equal('true');
    await this.Rings.approve(operatorSingleToken, tokenId)
    
    await this.Rings.transferFrom(owner,buyer,tokenId,{ from: operatorAllTokens })
    expect((await this.Rings.ownerOf(tokenId)).toString()).to.equal(buyer);
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('1');
    expect((await this.Rings.getApproved(tokenId)).toString()).to.equal(zeroAddress);
    expect((await this.Rings.isApprovedForAll(owner, operatorAllTokens)).toString()).to.equal('true');
    
    expect((await this.Rings.isApprovedForAll(owner, operatorAllTokens2)).toString()).to.equal('false');
    await this.Rings.setApprovalForAll(operatorAllTokens2, true) 
    expect((await this.Rings.isApprovedForAll(owner, operatorAllTokens2)).toString()).to.equal('true');
    
    await this.Rings.setApprovalForAll(operatorAllTokens, false);
    expect((await this.Rings.isApprovedForAll(owner, operatorAllTokens)).toString()).to.equal('false');
  });//*/

  // Test case
  it('Approve for all tokens and burn', async function () {
    
    await this.Rings.transferFrom(owner,buyer,tokenId)
    await this.Rings.setApprovalForAll(operatorAllTokens, true,{ from: buyer }) 
    await this.Rings.burnToken(tokenId,{ from: operatorAllTokens });
    expect((await this.Rings.balanceOf(buyer)).toString()).to.equal('0');
  });//*/

  // Test case
  it('Validate supported interfaces with ERC 165', async function () {
    expect((await this.Rings.supportsInterface('0x01ffc9a7')).toString()).to.equal('true'); //ERC165
    expect((await this.Rings.supportsInterface('0xffffffff')).toString()).to.equal('false'); //default ERC165 behavior
    expect((await this.Rings.supportsInterface('0x80ac58cd')).toString()).to.equal('true'); //ERC721
    expect((await this.Rings.supportsInterface('0x5b5e139f')).toString()).to.equal('true'); //ERC721 metadataa
    expect((await this.Rings.supportsInterface('0x2a55205a')).toString()).to.equal('true'); //ERC2981 royalties
  });//*/
});