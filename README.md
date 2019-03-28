# COST Contracts

Welcome to a new form of managing communities. Inspired by thoughts in the book Radical Markets (link to book/website) these contract aims to provide a base layer to run communities based on collecting COST taxes. It allows communities to define how they would like to disperse community funds, handle foreclosures, and develop timeframes for collecting taxes. 

## Stack
* cost.sol - Registry for Assets, base tax layer, allows member to self asses
* coDAO.sol - (calls cost) Registry for Communities: handles tax calculation, forclosure, paying tax, register communities, handle intra community sqabbles
* Communities.sol (calls coDAO) - handle assets of the same type, register with coDAO
* test/test_cost.js - testing for cost.sol - 90% completed
* test/test_coDAO.sol - testing for CoDAO.sol - 5% completed


## Pay Breakdown
* Owner:      93%
* Communities: 7%

## Community
Creating a community costs 1 eth currently. Subject to change.
Communities can: 
- Parse out Community Funds
- Pay coDAO dev fee 
- Determine when to foreclose
- Determine different times to collect
- Determine ownership periods

# Example Community:
Coming Soon...

### TODO:
* Test coDAO.sol
* Test taxFund variable in cost.sol
* Create Example community
