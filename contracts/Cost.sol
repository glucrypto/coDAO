pragma solidity >=0.4.21 <0.6.0;

contract Cost {
  struct asset {
    address payable community_owner; // Address of the Community
    address lessee; // Current Highest Bidder
    uint price; // Current Price of the Asset
    uint taxFund; // Tax amount the member has paid
  }

  // Map of lessees to assets
  mapping (bytes32 => asset) public asset_registry;

  // Tax as a Percentage
  uint public tax_rate = 7;

  // Contract owner
  address public owner;

  constructor() public {
    owner = msg.sender; 
  }
  // Allow anyone to list an asset that contributes to a common DAO
  function listAsset(address payable community_owner, bytes32 _asset,uint price) public {

    asset_registry[_asset] = asset(community_owner,msg.sender,price,0);
  }

  // Anyone can place a bid
  function placeBid(bytes32 _asset) public payable {
    // Convert to modifier
    require(msg.value > asset_registry[_asset].price, "Someone Bid Higher");
    //TODO: Return money to sender ?
    asset_registry[_asset].lessee = msg.sender;
    asset_registry[_asset].price = msg.value;
  }

  // Allows the lessee to reassess the price of the asset
  function selfAssess(bytes32 _asset) payable public{
  	// Allows current lessee of asset to self assess
  	require (msg.sender == asset_registry[_asset].lessee,"You are not the current lessee");
    asset_registry[_asset].price = msg.value;
  }
  // Allows the lessee to fund their tax owed
  function fundTaxAccount(bytes32 _asset) payable public{
    // Allows current lessee of asset to self assess
    require (msg.sender == asset_registry[_asset].lessee,"You are not the current lessee");
    asset_registry[_asset].taxFund += msg.value;
  }
  

  function() external payable {

  }
  function getCoDAO(bytes32 _asset) view public returns(address){
    return asset_registry[_asset].community_owner; 
  }
  function getLessee(bytes32 _asset) view public returns(address){
    return asset_registry[_asset].lessee; 
  }
  function getPrice(bytes32 _asset) view public returns(uint){
    return asset_registry[_asset].price; 
  }
}
  