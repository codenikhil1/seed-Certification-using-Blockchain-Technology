var seedStorage = artifacts.require("./seedStorage");
var seedSupply = artifacts.require("./seedSupply");

module.exports = function(deployer){
	deployer.deploy(seedStorage)
	.then(()=>{
		return deployer.deploy(seedSupply,seedStorage.address);
	})
	.then(()=>{
   		return seedStorage.deployed();
    }).then(async function(instance){
		await instance.authorizeCaller(seedSupply.address); 
		return instance;
	})
	.catch(function(error)
	{
		console.log(error);
	});
};
