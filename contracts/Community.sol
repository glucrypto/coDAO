pragma solidity >=0.4.21 <0.6.0;

import "./Cost.sol";

contract Community is Cost{

	mapping (address => address) community_registry;
	address payable coDAOowner;

	constructor() public{
		coDAOowner = msg.sender;
	}
  
  /* Create a Community
     Costs 1 eth to create a community (subject to change, in the future may be a COST tax of it's own)
     Community is an address of a contract
  */ 
  function createCommunity(address commContractAddr) payable public {
    // add a protective clause around (pending withdraws)
    coDAOowner.transfer(msg.value);
    community_registry[msg.sender] = commContractAddr; 
  }
  
  /////////////// Methods to help communities manage assets and members ///////////////////
  function listCommunityAsset(bytes32 _asset,uint price, address payable commContractAddr) public {
    //require (community_registry[msg.sender] == commContractAddr,"You are not a community owner");
    listAsset(commContractAddr,_asset,price);

  }

  // Forclose (if there is no money left for asset attached to lessee), called by community
  function foreclose (bytes32 _asset, address payable commContractAddr) public {
    require (community_registry[msg.sender] == commContractAddr,"You are not a community owner");
    require (commContractAddr == asset_registry[_asset].community_contract,"You are not the community owner");
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

  function getCommunityRegistry(address communityOwner,address commContractAddr) external view returns(bool){
    if(community_registry[communityOwner] == commContractAddr){
      return true;
    }
    else{
      return false;
    }
  }  
}
