const Migrations = artifacts.require("Migrations");
const Cost = artifacts.require("Cost");
const Community = artifacts.require("Community");
//const ParkingCoDAO = artifacts.require("parkingCoDAO");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Cost);
  deployer.deploy(Community);
  //deployer.deploy(ParkingCoDAO); 
};
