Meteor.startup ->
  if Meteor.isServer
    console.log "Starting server...#{new Date()}"
    Transactions.remove({})
    Balances.remove({})


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

Meteor.methods({
  createTransaction: (options) ->
    options = options || {}
    options.created_at = new Date()

    balance = Balances.findOne( {
      owner: this.userId, target_buddy: options['target_buddy']
    } )

    console.log(balance)
    if balance
      Balances.update({
        owner: this.userId, target_buddy: options['target_buddy']
      }, {
        $inc: {amount: options['direction'] * options['amount'] }
      })
    else
      console.log this.userId
      Balances.insert({
        owner: this.userId
        target_buddy: options['target_buddy']
        amount: options['direction'] * options['amount']
      })

    return Transactions.insert({
      owner: Meteor.userId()
      direction: options['direction']
      target_buddy: options['target_buddy']
      amount: options['amount']
      memo: options['memo']
      created_at: new Date()
    })
})
