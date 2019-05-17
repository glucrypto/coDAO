pragma solidity >=0.4.21 <0.6.0;

import "./Community.sol";

contract LogoCommunity is Community{

	mapping (address => address) community_assets;
	address payable logoOwner;

	constructor() public{
		logoOwner = msg.sender;
	}

  struct LogoAsset {
    bytes32 listedAsset; // Hash of asset
    uint ownStart; // Time listed
    uint foreclosureTime; // Time till the asset is taken assuming taxFund = 0
    uint taxRate; // Tax rate for the specific asset
  }
  
  
  function addAsset(bytes32 _asset) public {

    community_assets[_asset] = LogoAsset(_asset,now,now+30,7);
    listCommunityAsset(_asset,uint 10,logoOwner);
  }

  function collectTax(bytes32 _asset) public{
    if(ownStart == 30 days){
      collectTax(_asset,0);
    }

  }

  function foreclose(_asset) public {

    if(now == foreclosureTime){
      foreclose(_asset,msg.sender);
    }
  }

  function disbursefunds(bytes32 _asset,address payable recipient, unint taxRate) public {
    mapping (address => address) community_assets;
    //Transfer Funds to recipient depending on how much assets they own
    // Check to see if they are the owner
    address lessee = getLessee(_asset);
    uint price = getPrice(_asset);
    uint totalPrice = getSumOfAssets(); // Returns # of assets
    
    uint fundAllowance = taxRate * (price - totalPrice);
   recipient.transfer(fundAllownance);

  }

    
}
