const Cost = artifacts.require("Cost");


contract("Cost", accounts => {
	let co_dao = accounts[1];
	let price = 10;
	let lister = accounts[2];
	let newBidder_winner = accounts[3];
	let bid2 = 20;
	let selfBid = 10;
	let newBidder_loser = accounts[4];
	let bid3 = 5; 
	let testAsset = web3.utils.fromAscii("testString").replace(/\0/g, '');
	let instance;

	before(async function(){
		Cost.autogas = true;
		instance = await Cost.deployed();
		await instance.listAsset(co_dao,testAsset,10,{from: lister});
	});
  		
	it('should get asset', async () => {
		let coDao = await instance.getCoDAO(testAsset);
		assert.equal(coDao,co_dao);
	});
	it('should get lessee', async () => {
		let lesseeOut = await instance.getLessee(testAsset);
		assert.equal(lesseeOut,lister);
	});
	it('should get Price', async () => {
		let priceOut = await instance.getPrice(testAsset);
		assert.equal(priceOut,price);
	});
	it('should place Bid and assign new lessee', async () => {
		await instance.placeBid(testAsset,{from: newBidder_winner,value:bid2});
		let priceOut = await instance.getPrice(testAsset);
		let coDao = await instance.getCoDAO(testAsset);
		let lesseeOut = await instance.getLessee(testAsset);
		assert.equal(lesseeOut,newBidder_winner);
		assert.equal(coDao,co_dao);
		assert.equal(priceOut,bid2);
	});
	it('should place Bid and reject new lessee', async () => {
		try{
			await instance.placeBid(testAsset,{from: newBidder_loser,value:bid3});		
		}
		catch(error){
			assert.equal(error.reason,"Someone Bid Higher");
		}
	});
	it('should allow new lessee to change price', async () => {
		await instance.selfAssess(testAsset,{from: newBidder_winner,value:selfBid});		
		let priceOut = await instance.getPrice(testAsset);
		let coDao = await instance.getCoDAO(testAsset);
		let lesseeOut = await instance.getLessee(testAsset);
		assert.equal(lesseeOut,newBidder_winner);
		assert.equal(coDao,co_dao);
		assert.equal(priceOut,selfBid);
	});
	it('should deny non lessee to change price', async () => {
		try{
			await instance.selfAssess(testAsset,{from: newBidder_loser,value:selfBid});		
		}
		catch(error){
			assert.equal(error.reason,"You are not the current lessee");
		}
	});
});