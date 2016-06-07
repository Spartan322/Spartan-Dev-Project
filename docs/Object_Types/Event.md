## Event
###### Fields
* id - the unique identifier
* date - the date the event's notification will start counting down to trigger
* ignoreGameLengthModifier - ignores the date modifier, triggering on the actual date specificed no matter what (optionl, default: false)

###### Functions
* getNotification(company) - retrieves the notification object for the event (optional if event contains a `notification` fields)