var seedCertification = artifacts.require("seedStorage");

module.exports = function(deployer){
    deployer.deploy(seedCertification);
}