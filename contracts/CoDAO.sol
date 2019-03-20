pragma solidity >=0.4.21 <0.6.0;

import "./Cost.sol";

contract CoDAO is Cost{

	mapping (address => uint) pendingWithdraws;
	
	constructor() public{

	}

	//Member pays tax
  function payTax(bytes32 _asset) payable public{	
  	// Look up asset and grab the owner
  	require (msg.sender == asset_registry[_asset].lessee,"Member does not lease the asset");
  	// Calc taxes 
  	uint dailyTax = asset_registry[_asset].price * (tax_rate / 365);
  	address coDAO_withdraw = asset_registry[_asset].co_dao;  	
  	// Queue up a withdraw from the tax
  	pendingWithdraws[coDAO_withdraw] += msg.value;
  }
	
	function calcTax(bytes32 _asset) public returns(uint){
		uint dailyTax = asset_registry[_asset].price * (tax_rate / 365);
		return dailyTax;
	   }
	      
  // Allows DAO to get the the funds
  function withdraw() public {
  	uint amount = pendingWithdraws[msg.sender];
  	pendingWithdraws[msg.sender] = 0;
  	msg.sender.transfer(amount);
  	
  }
  function() external payable {

  }
}
