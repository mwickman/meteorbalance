Meteor.startup ->
  console.log "Starting server...#{new Date()}"

Meteor.publish "transactions", ->
  Transactions.find()
