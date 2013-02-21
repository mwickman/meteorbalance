Transactions = new Meteor.Collection("transactions")

Meteor.methods({
  createTransaction: (options) ->
    options = options || {}
    options.created_at = new Date()
    console.log(options)
    return Transactions.insert(options)

  # this will fetch all the users' to and from transactions
  myTransactions: (options) ->
    console.log(Meteor.userId())
    t = Transactions.find({
      $or: [ {to: Meteor.userId()} , {from: Meteor.userId()} ]
    })#.fetch()
    console.log(t)
    return t

  myBuddies: (options) ->
    myTs = Meteor.call 'myTransactions()'
    console.log(myTs)
    _.uniq(
      _.reject(
        _.union(
          _.pluck( myTs, 'to' ),
          _.pluck( myTs, 'from' )
        )
        , Meteor.userId() ) )

  myBalances: (options) ->

})
