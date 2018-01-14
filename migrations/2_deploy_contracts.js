
var Listen = artifacts.require('./TenancyContract.sol');

module.exports = function(deployer) {


  //const address = 0x155aa299e29abe2ddbe5dced4c051f8f5268c0a9;

  //deployer.deploy(FlinnCoinSale, startBlock, endBlock, rate, wallet, cap);

  deployer.deploy(Listen, web3.toWei("ether",1));
};
