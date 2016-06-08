## Contract
###### Fields
* name - the player friendly name
* description - the description of the contract project
* tF - the tech factor required
* dF - the design factor required
* rF - the research factor that is likely to be generated (optional, default: 0)

###### Functions
* isAvailable(company) - whether this contract can currently be used with the company (optional, default: `return true`)