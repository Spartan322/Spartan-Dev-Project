## Review Message
###### Fields
* message - the message which to state
* isPositive - whether this message is praise (optional, default: false)
* isNegative - whether this message is critique (optional, default: false)

(If isPositive and isNegative are treated false, assumes the message is generic)

###### Functions
* getMessage(game, score) - the message to display based on the game and score (precedes message)