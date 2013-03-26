Meteor.startup ->
  if Meteor.isServer
    console.log "Starting server...#{new Date()}"
    #Transactions.remove({})


Meteor.publish "balances", ->
  Balances.find({
    owner: this.userId
  })

Meteor.publish "transactions", ->
  Transactions.find({
      owner: this.userId
    },
    {
      sort: {created_at: -1}
    }
  )

