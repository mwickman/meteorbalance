Transactions = new Meteor.Collection("transactions")
Balances = new Meteor.Collection("balances")

Meteor.methods({
  createTransaction: (options) ->
    console.log('got here!')
    options = options || {}
    options.created_at = new Date()

    balance = Balances.find( {
      owner: this.userId, target_buddy: options['target_buddy']
    } ).fetch()

    console.log(balance)

    if balance
      Balances.update({
        owner: this.userId, target_buddy: options['target_buddy']
      }, {
        $inc: {amount: options['direction'] * options['amount'] }
      })
    else
      Balances.insert({
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
