// migrations/2_deploy.js
const Rings = artifacts.require('NFTokenMetadata');
//const Generator = artifacts.require('Generator');

module.exports = async function (deployer, network, addresses) {
  //var gen=await Generator.deployed()
  //await deployer.link("0x9ec93A6710bE2322c399f1033cdD1cF9aBF6B1E1", Rings);
  
  //await deployer.deploy(Generator);
  //await deployer.link(Generator, Rings);
  await deployer.deploy(Rings);

}