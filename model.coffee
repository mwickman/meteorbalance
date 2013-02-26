Transactions = new Meteor.Collection("transactions")
Balances = new Meteor.Collection("balances")

Meteor.methods({
  createTransaction: (options) ->
    options = options || {}
    options.created_at = new Date()

    return Transactions.insert({
      to: options['to']
      from: options['from']
      amount: options['amount']
      memo: options['memo']
    })
})
