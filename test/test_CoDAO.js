const Community = artifacts.require("Community");


contract("CoDAO", accounts => {
	let community_owner = accounts[2];
	let fake_comm = accounts[6];
	let testAsset = web3.utils.fromAscii("samwillthiswork").replace(/\0/g, '');
	let leesse1 = accounts[7];
	let commContractAddr = accounts[3];
	before(async function(){
		Community.autogas = true;
		instance = await Community.deployed();
		let commRes = await instance.createCommunity(commContractAddr,{from: community_owner});
		//console.log(commRes);
	});
	it('should verify if community exists', async () => {
		let communityOwnerOut = await instance.getCommunityRegistry(community_owner,commContractAddr);
		//console.log(communityOwnerOut);
		assert.equal(communityOwnerOut,true);
	});
	it('should assert not a community', async () => {
		let communityOwnerOut = await instance.getCommunityRegistry(fake_comm,commContractAddr);
		assert.equal(communityOwnerOut,false);
	});
	it('should allow a community owner to list and asset', async () => {
		// List asset
		await instance.listCommunityAsset(testAsset,0,commContractAddr, {from: community_owner});
		let community_owner_saved = await instance.getCommunity(testAsset);
		assert.equal(commContractAddr,community_owner_saved);
	});
	it('should allow a community owner to collect Tax', async() => {
		await instance.collectTax(testAsset,1, {from: community_owner});
		let balOut = await web3.eth.getBalance(community_owner);
		assert.equal(balOut,'99997053260000000000');
	});
  	// TEST: function foreclose (bytes32 _asset)
	it('should allow a community owner to foreclose on an Asset', async () => {
		let taxPay = await instance.foreclose(testAsset,commContractAddr,{from: community_owner});
		let priceOut = await instance.getPrice(testAsset);
		let priceConverted = priceOut.toString(10);
		let lesseeOut = await instance.getLessee(testAsset);
		//console.log(lesseeOut);
		assert.equal(community_owner, lesseeOut);
		assert.equal(0,priceOut);

	});
});