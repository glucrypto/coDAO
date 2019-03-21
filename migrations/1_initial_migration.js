const Migrations = artifacts.require("Migrations");
const Cost = artifacts.require("Cost");
const CoDAO = artifacts.require("CoDAO");
//const ParkingCoDAO = artifacts.require("parkingCoDAO");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Cost);
  deployer.deploy(CoDAO);
  //deployer.deploy(ParkingCoDAO); 
};
