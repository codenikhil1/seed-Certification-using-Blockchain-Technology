var seedCertification = artifacts.require("seed");

module.exports = function(deployer){
    deployer.deploy(seedCertification);
}