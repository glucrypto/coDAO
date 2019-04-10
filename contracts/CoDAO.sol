pragma solidity >=0.4.21 <0.6.0;

import "./Cost.sol";

contract CoDAO is Cost{

	mapping (address => bool) community_registry;
	address payable coDAOowner;

	constructor() public{
		coDAOowner = msg.sender;
	}
  
  /* Create a Community
     Costs 1 eth to create a community (subject to change, in the future may be a COST tax of it's own)
     Community is an address of a contract
  */ 
  function createCommunity() payable public {
    // add a protective clause around (pending withdraws)
    coDAOowner.transfer(msg.value);
    community_registry[msg.sender] = true; 
  }
  
  /////////////// Methods to help communities manage assets and members ///////////////////
  function listCommunityAsset(bytes32 _asset,uint price) public {
    require (community_registry[msg.sender] == true,"You are not a community owner");
    listAsset(msg.sender,_asset,price);

  }

  // Forclose (if there is no money left for asset attached to lessee), called by community
  function foreclose (bytes32 _asset) public {
    require (msg.sender == asset_registry[_asset].community_owner,"You are not the community owner");
    require (0 == asset_registry[_asset].taxFund,"The lessee still has funds left in their tax account");
   
    asset_registry[_asset].lessee = msg.sender;
    asset_registry[_asset].price = 0;
    
  }

  // Allows community owner to collect taxes on an asset
  function collectTax(bytes32 _asset, uint _multiplier) public {
    // Calc taxes with DAI integration for the price
    uint collections = asset_registry[_asset].price * (tax_rate / 365) * _multiplier;

    require (collections >= asset_registry[_asset].taxFund,"Not enough taxes, consider notifying the member or foreclosing");
    // Subtracts the funds
    asset_registry[_asset].taxFund -= collections;
    // All good to tansfer the funds
    msg.sender.transfer(collections);    
  }

  function() external payable {

  }

  function getCommunityRegistry(address community) external view returns(bool){
    if(community_registry[community] == true){
      return true;
    }
    else{
      return false;
    }
  }  
}
