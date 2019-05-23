pragma solidity >=0.4.21 <0.6.0;

import "./Community.sol";

contract Parking is Community{

	mapping (address => address) community_spots;
	address payable logoOwner;

	constructor() public{
		logoOwner = msg.sender;
	}

  struct Spot {
    bytes32 listedAsset; // Hash of asset
    uint ownStart; // Time listed
    uint foreclosureTime; // Time till the asset is taken assuming taxFund = 0
    uint taxRate; // Tax rate for the specific asset
  }
  
  
  function addAsset(bytes32 spot) public {

    community_spots[spot] = Spot(spot,now,now+30,7);
    listCommunityAsset(spot,uint 10,logoOwner);
  }

   function collectTax(bytes32 spot) public{
    if(now == community_spots[spot].ownStart + 1 hours){
      collectTax(spot,0);
      community_spots[spot].ownStart = now;
    }


  }

  function foreclose(spot) public {

    if(now == foreclosureTime){
      foreclose(spot,msg.sender);
    }
  }

  function disburseFunds(bytes32 spot, uint taxRate) public {
    //Transfer Funds to recipient depending on how much assets they own
    // Check to see if they are the owner
    address lessee = getLessee(spot);
    uint apartmentPeople = getApartments(spot); // Returns the people who live on the street 
    
    uint fundAllowance = taxRate / apartmentPeople;
   recipient.transfer(fundAllowance);

  }

    
}
