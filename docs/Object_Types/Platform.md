## Platform
###### Fields
* id - the unique identifier
* name - the player friendly name
* startAmount - the starting market share (0 = 0%, 1 = 100%)
* marketKeyPoints - an array of market share after certain dates:
  * date - the date for which the point starts
  * amount - the value of the market share after the date
* unitsSold - the units sold
* licensePrize - the one time licensing price
* published - the date the platform goes on the market
* platformRetireDate - the date which the platform will come of the market
* developmentCosts - the base cost to develop
* techLevel - the tech level for the platform
* Either:
  * iconUri - the icon to display for the platform
  * Multi-icon (follows like so, '&lt;baseIconUri>/&lt;id>' and adds '-&lt;2,3,4,5,...>' if there is 2 or more dates):  
    * baseIconUri - the base icon uri
    * imageDates - the array of dates to change the icon

### Possible Future
There might be a date control system which would allow this model as well, the previous model can be used for starting information:
* id - the unique identifier
* name - the player friendly name
* published - the date the platform goes on the market
* platformRetireDate - the date which the platform will come of the market
* An array of infomation representing this plaftorm at certain dates [undefined forces previous date behavior]:
  * date - the date this info takes effect
  * marketShare - the value of market share after the date
  * licensePrize - the one time licensing price after the date
  * developmentCosts - the base cost to develop after the date
  * techLevel - the tech level for the platform after the date
  * iconUri - the icon for the platform after the date (if absent, will try to use baseIconUri and that behavior to find icon, otherwise returns iconUri)
  * refineEvent - the event on platform refinement