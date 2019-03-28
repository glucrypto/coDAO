const CoDAO = artifacts.require("CoDAO");


contract("CoDAO", accounts => {
	let community_owner = accounts[1];
	
	before(async function(){
		CoDAO.autogas = true;
		instance = await CoDAO.deployed();
		await instance.createCommunity({from: community_owner});
	});
	it('should get asset', async () => {
  		let communityOwnerOut = await instance.getCommunityRegistry(community_owner);
		assert.equal(communityOwnerOut,true);
	});
 	// TEST: function payTax(address community, bytes32 _asset)
  	// TEST: function foreclose (bytes32 _asset)
  	// TEST: function collectTax(bytes32 _asset, uint _dailyMultiplier)

});