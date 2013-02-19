Meteor.startup ->
  console.log "Starting server...#{new Date()}"

Meteor.publish "transactions", ->
  Transactions.find({
    $or: [
      {to: this.userId},
      {from: this.userId}
    ]
  },
    {
      sort: {created_at: -1}
    }
  )
