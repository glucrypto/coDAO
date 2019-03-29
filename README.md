# COST Contracts

Welcome to a new form of managing communities. Inspired by thoughts in the book [Radical Markets](http://radicalmarkets.com/) these contracts aim to provide a base layer to run communities based on collecting COST taxes for property. Communities are smart contracts that manage similar assets and the general society that is affected by those assets. The communities themselves define how to disperse community funds, handle foreclosures, and add logic to collecting taxes such as timeframes. 

Communities list assets and community members or lessees take ownership until someone outbids their price. Lessees can self assess their tax at any time to represent the true value. To foster a successful community, the assets listed should be unique enough that members will be incentivised to improve the asset.

More information can be found at: 
* [RadicalxChange.org](https://radicalxchange.org/)

## Stack
The cost.sol contract contains the tax information and the asset registry while the coDAO.sol contract contains the Community Registry. This way the coDAO contract can solve community level problems and allow communities with overlapping assets to work together. Communities are created within the coDAO and can then start adding assets to the cost.sol registry and planning their society.

Code breakdown:
* cost.sol - Registry for Assets, base tax layer, allows member to self asses
* coDAO.sol - (calls cost.sol) Registry for Communities: handles tax calculation, foreclosure, paying tax, register communities, handle intra community squabbles
* Communities.sol (calls coDAO.sol) - handle assets of the same type, register with coDAO
* test/test_cost.js - testing for cost.sol - 90% completed
* test/test_coDAO.sol - testing for CoDAO.sol - 5% completed


## Tax Breakdown
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

## Example Community:
Coming Soon...

### TODO:
* Test coDAO.sol
* Test taxFund variable in cost.sol
* Create Example community
