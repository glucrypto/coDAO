const CoDAO = artifacts.require("CoDAO");


contract("ASSETS3", accounts => {
	let community_owner = accounts[4];
	let fake_comm = accounts[9];
	let asset1 = web3.utils.fromAscii("Asset 1").replace(/\0/g, '');
	let asset2 = web3.utils.fromAscii("Asset 2").replace(/\0/g, '');
	let asset3 = web3.utils.fromAscii("Asset 3").replace(/\0/g, '');
	let asset4 = web3.utils.fromAscii("Asset 4").replace(/\0/g, '');
	let asset5 = web3.utils.fromAscii("Asset 5").replace(/\0/g, '');
	let asset6 = web3.utils.fromAscii("Asset 6").replace(/\0/g, '');
	let leesse1 = accounts[7];
	let commContractAddr = accounts[5];
	before(async function(){
		CoDAO.autogas = true;
		instance = await CoDAO.deployed();
		let commRes = await instance.createCommunity(commContractAddr,{from: community_owner});
	});
	it('should verify if community exists', async () => {
		let communityOwnerOut = await instance.getCommunityRegistry(community_owner,commContractAddr);
		assert.equal(communityOwnerOut,true);
	});
	it('should allow a community owner to list and asset', async () => {
		// List asset
		await instance.listCommunityAsset(asset1,1,commContractAddr, {from: community_owner});
		await instance.listCommunityAsset(asset2,2,commContractAddr, {from: community_owner});
		await instance.listCommunityAsset(asset3,3,commContractAddr, {from: community_owner});
		await instance.listCommunityAsset(asset4,4,commContractAddr, {from: community_owner});
		await instance.listCommunityAsset(asset5,5,commContractAddr, {from: community_owner});
		await instance.listCommunityAsset(asset6,6,commContractAddr, {from: community_owner});
		let community_owner_saved = await instance.getCommunity(testAsset);
		//assert.equal(commContractAddr,community_owner_saved);
	});
});