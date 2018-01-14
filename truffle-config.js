var HDWalletProvider = require("truffle-hdwallet-provider");

var mnemonic = 'soul strike glance human render shoe analyst enjoy letter enhance eagle curtain';
module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network i
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/Z5KrTvJi8wtkaF92UA81")
      },
      network_id: 3,
      gas:4000000,
    }
  }, 
  solc: { optimizer: { enabled: true, runs: 200 } }  
};