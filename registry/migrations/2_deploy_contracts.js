var ECVerify = artifacts.require("./ECVerify.sol");
var KeybaseRegistry = artifacts.require("./KeybaseRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(ECVerify);
  deployer.link(ECVerify, KeybaseRegistry);
  deployer.deploy(KeybaseRegistry);
};
