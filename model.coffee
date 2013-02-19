Transactions = new Meteor.Collection("transactions")

Meteor.methods({
  createTransaction: (options) ->
    options = options || {}
    options.created_at = new Date()
    console.log(options)
    return Transactions.insert(options)
})
