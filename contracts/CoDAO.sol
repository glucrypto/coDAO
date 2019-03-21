pragma solidity >=0.4.21 <0.6.0;

import "./Cost.sol";

contract CoDAO is Cost{

	mapping (address => uint) pendingWithdraws;
	address coDAOowner;

	constructor() public{
		coDAOowner = msg.sender;
	}

	//Member pays tax
  function payTax(bytes32 _asset) payable public{	
  	// Look up asset and grab the owner
  	require (msg.sender == asset_registry[_asset].lessee,"Member does not lease the asset");
  	// Calc taxes with DAI integration for the price
  	uint dailyTax = asset_registry[_asset].price * (tax_rate / 365);
  	address coDAO_withdraw = asset_registry[_asset].co_dao;  	
  	// Queue up a withdraw from the tax
  	pendingWithdraws[coDAO_withdraw] += msg.value;
  }
	      
  // Allows DAO organizer to get the the funds
  function withdraw() public {

  	require (msg.sender == coDAOowner);
  	uint amount = pendingWithdraws[msg.sender];
  	pendingWithdraws[msg.sender] = 0;
  	msg.sender.transfer(amount);
  	
  }
  function() external payable {

  }
}
