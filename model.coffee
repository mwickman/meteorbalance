Transactions = new Meteor.Collection("transactions")

Meteor.methods({
  createTransaction: (options) ->
    options = options || {}
    options.created_at = new Date()

  # this will fetch all the user's to and from transactions
  myTransactions: (options) ->
    t = Transactions.find({
      $or: [ {to: Meteor.userId()} , {from: Meteor.userId()} ]
    }).fetch()
    return t

  myBuddies: (options) ->
    myTs = Meteor.call 'myTransactions()', (e, d) ->
      if (e)
        console.log(e)
      else
        _.uniq(
          _.reject(
            _.union(
              _.pluck( myTs, 'to' ),
              _.pluck( myTs, 'from' )
            )
            , Meteor.userId() ) )

  myBalances: (options) ->
    this.myBuddies({}, (e, d) -> console.log(d))

})
