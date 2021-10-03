// truffle-config.js
const { alchemyApiKey, mnemonic } = require('./secrets.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');



/*var LedgerWalletProvider = require("truffle-ledger-provider");
//var infura_apikey = "..."; // set your Infura API key
var ledgerOptions = {
    networkId: 4, 
    accountsOffset: 0 // we use the first address
};
module.exports = {
    networks: {
        
    }
}; */

module.exports={
    plugins: ["truffle-contract-size"],
    networks: {
        /*rinkebyledger: {
            provider: new LedgerWalletProvider(ledgerOptions, `https://eth-rinkeby.alchemyapi.io/v2/${alchemyApiKey}`),
            network_id: 4
        },*/
        rinkeby: {
            provider: () => new HDWalletProvider(
              mnemonic, `https://eth-rinkeby.alchemyapi.io/v2/${alchemyApiKey}`,
            ),
            network_id: 4,
            gasPrice: 20e9,
            skipDryRun: true,
          },
        development: {
        host: "127.0.0.1",     // Localhost (default: none)
        port: 8545,            // Standard Ethereum port (default: none)
        network_id: "*",       // Any network (default: none)
        gasPrice: 40e9,
       },

    },
    // Configure your compilers
    compilers: {
      solc: {
        version: "0.8.7",   // Fetch exact version from solc-bin (default: truffle's version)
        // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
        // See the solidity docs for advice about optimization and evmVersion
        settings: {          
          optimizer: {
            enabled: true,
            runs: 200,
            /*"details": {
                // The peephole optimizer is always on if no details are given,
                // use details to switch it off.
                "peephole": true,
                // The inliner is always on if no details are given,
                // use details to switch it off.
                "inliner": true,
                // The unused jumpdest remover is always on if no details are given,
                // use details to switch it off.
                "jumpdestRemover": true,
                // Sometimes re-orders literals in commutative operations.
                "orderLiterals": true,
                // Removes duplicate code blocks
                "deduplicate": true,
                // Common subexpression elimination, this is the most complicated step but
                // can also provide the largest gain.
                "cse": true,
                // Optimize representation of literal numbers and strings in code.
                "constantOptimizer": true,
                } //*/
          }
          //"evmVersion": "london"
        
        
        }
        
      }
    }
}