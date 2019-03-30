const CoDAO = artifacts.require("CoDAO");


contract("CoDAO", accounts => {
	let community_owner = accounts[5];
	let fake_comm = accounts[6];
	let testAsset = web3.utils.fromAscii("testCommunityString").replace(/\0/g, '');
	let leesse1 = accounts[7];

	before(async function(){
		CoDAO.autogas = true;
		instance = await CoDAO.deployed();
		await instance.createCommunity({from: community_owner});
	});
	it('should verify if community exists', async () => {
		let communityOwnerOut = await instance.getCommunityRegistry(community_owner);
		assert.equal(communityOwnerOut,true);
	});
	it('should assert not a community', async () => {
		let communityOwnerOut = await instance.getCommunityRegistry(fake_comm);
		assert.equal(communityOwnerOut,false);
	});
	it('should allow a community owner to list and asset', async () => {
		// List asset
		let asset1 = await instance.listCommunityAsset(testAsset,0, {from: community_owner});
		await instance.getCommunity(asset1);
		assert.equal(community_owner,asset1);
	});
	it('should allow a community owner to collect Tax', async() => {
		let taxPay = await instance.collectTax(testAsset,1, {from: community_owner});
		let balOut = await web3.eth.getBalance(community_owner);
		asset.equal(balOut,taxPay);
	});
  	// TEST: function foreclose (bytes32 _asset)
	it('should allow a community owner to foreclose on an Asset', async () => {
		let taxPay = await instance.foreclose(testAsset,{from: community_owner});
		let priceOut = await instance.getPrice(testAsset);
		let lesseeOut = await instance.getLessee(testAsset);
		asset.equal(community_owner, lesseeOut);
		assert.equal(1,priceOut);

	});
});