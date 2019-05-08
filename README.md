# COST Contracts

Welcome to a new form of managing communities. Inspired by thoughts in the book [Radical Markets](http://radicalmarkets.com/) these contracts and corresponding README aim to provide a base layer to run communities based on collecting COST taxes for property. This COST platform essentially allows everyone to own anything they want, provided they pay (1) a well defined and marketable price and (2) a tax. 

More information can be found at: 
[RadicalxChange.org](https://radicalxchange.org/)


# Motivation

This project aims to explore a COST based system of ownership at scale. COST stands for common ownership self assessed tax on wealth.[1] COST attempts to shift some properties of ownership from possessors to the public. [2] It does this by honoring the highest bid on an an asset in which anyone can place a bid. A 7% yearly tax is applied to the asset owner. The asset owner is now referred to as an lessee since they effectively borrow the asset from the public. Government intervention is then unnecessary as the community tax/ bidding scheme will promote living within your means and enjoying/participating in the community fund. The benefits of a COST based system can be found in the the book Radical Markets, specifically Chapter 1.

This is system is a radical shift from current market solutions and requires a vast amount of research and study to implement in an efficient manner. We provide a more structured and thorough solution to better understand the effectiveness of COST in a large scale environment. 

First off, attempting to define the community lends us to a host of possibilities and solutions. Is the community referred to as the entirety of the world's population? How then would a COST based system be able to handle the almost infinite amount of assets that will be hosted on this platform, ensure tax collection and general rules about specific assets? I propose to define the larger COST community as a group of communities who organize assets under which a governance model tends to duplicate, tax collection, and community fund decisions. This structure not unlike what the U.S. Congress attempts to do with Committees and Departments. The ideal being that assets can be organized by dedicated people to best serve the needs of the public still rings true in this proposal. However, it turns out those organization amounts to creating centrally controlled markets where one rule maker decides how every asset is parsed out. In our case we offer a solution to vastly improve the allocation efficiency issues of the current Committee structure.

Our communities will be maintained by a series of smart contracts. First and foremost this system is permissionless, anyone is allow to post an asset and separately create a community. Community creation is handled by a COST based committee of general public committees. Communities have at their disposal the ability to collect tax from assets, handle foreclosure of assets and accessing the community funds. Group members are incentively to maintain their assets as well as the community fund to suit the needs of everyone as the value of their assets are directly tied to their community fund. If members become dissatisfied they may sell their assets at a lower price and accept losses and move. As prices shrink others may be incentive to rebuild the community. On another thread communities may implement an asset to voting mechanism akin to Proof of Stake. Of course this brings up a variety of monopolistic issues among other potential pitfalls.

We hope these issues and pitfalls can be explored on our platform. Our platform can host land, art, ERC271 tokens and any other item that is biddable (within reason). By providing the base contracts for the system namely COST.sol and Community.sol we allow communities to define their own rules. We plan to implement a DAO ontop of the Community Registry (CoDAO) to handle some of the inter community interactions.

Some questions we would like to see answered:

* How many communities will be created?
* How can we implement the CoDAO community registry Organization?
* Will communities be able to implement advanced governance models while at the same time provide enough 'right to exit' coverage so as to not maintain adversarial control?
* What would a cross community monopoly look like and how would it be handled?
* Would sub communities pay COST take to communities in a hierarchal pattern?
* Should an asset be allowed to be a community itself?
* How should community registration be handled, should any community be allowed to fork and revert assets in the case of a bad actor? How would the CoDAO handle this situation.
* Will people actually understand the balancing metric of the 
* What would the community fund be used for? Developer compensation? Maybe a direct dividend?
* How does investment efficiency per asset transfer to communities as this project scales?


## Technical Details


## Stack
The cost.sol contract contains the tax information and the asset registry while the Community.sol contract contains the Community Registry. A CoDAO.sol contract will solve community level problems and inter community issues. Communities are created within the Community.sol and can then start adding assets to the cost.sol registry and planning their society.

Code breakdown:
* Cost.sol - Registry for Assets, base tax layer, allows member to self asses, place a bid, and list an asset
* Community.sol - Registry for Communities: handles tax calculation, foreclosure, and registering communities and community assets.
* CoDAO.sol - controls Community.sol and Cost.sol

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
* Test coDAO.sol - done 
* Test taxFund variable in cost.sol
* Create Example community
* Ropsten testnet
* UI frontend - codao.io

Issues:
* [1] Return funds from tax account when someone else takes over the asset
* [2] Allow lag time between when someone takes an asset from someone and it's awarded
* [3] Add saving of Community Contract
* [4] Add saving of assets
* [5] Add tendermint tests

### Planned Technical features:
Tendermint/Cosmos integration (to improve transaction times)
Full IPFS integration (for large scale distributed hosting of asset and community information)