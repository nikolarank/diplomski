var Adoption = artifacts.require("./Adoption.sol");
var Purchase = artifacts.require("./Purchase.sol");
var Store = artifacts.require("./Store.sol");

module.exports = function (deployer) {
    deployer.deploy(Adoption);
    //deployer.deploy(Purchase);
    deployer.deploy(Store);
};