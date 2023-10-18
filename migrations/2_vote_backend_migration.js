const VoteBackend = artifacts.require("VoteBackend");

module.exports = function (deployer) {
  deployer.deploy(VoteBackend);
};