pragma solidity >=0.4.21 <0.6.0;

import "./CoDAO.sol";

// Manages members of the Parking DAO
contract ParkingCoDAO is CoDAO{
  
  mapping (address => address) public members;

  constructor() public {
    owner = msg.sender;
  }

  
  function() external payable {

  }
}
  