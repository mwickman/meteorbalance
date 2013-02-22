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

Meteor.publish "balances", ->
  ts = Transactions.find({
    $or: [
      {to: this.userId},
      {from: this.userId}
    ]
  }).fetch()
  _.uniq(
    _.reject(
      _.union(
        _.pluck( ts, 'to' ),
        _.pluck( ts, 'from' )
      )
      , (x) ->
        x != this.userId ) )
