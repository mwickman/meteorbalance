# template helpers
Handlebars.registerHelper("date", (dateObject) ->
  new Date(dateObject).toLocaleDateString()
)
Handlebars.registerHelper("getTargetBuddy", (transaction) ->
  if( Meteor.userId() == transaction.to )
    return transaction.from
  else
    return transaction.to
)
Handlebars.registerHelper("getDirection", (transaction) ->
  if( Meteor.userId() == transaction.to )
    return 'owed'
  else
    return 'you owe'
)

Meteor.subscribe("transactions")
Meteor.subscribe("balances")

Template.transactionTable.transactions = () ->
  Transactions.find()

Template.transactionTable.events({
  'click .set-transaction-target': (e, template) ->
    e.preventDefault()
    $('#targetBuddy').val(e.target.innerHTML)
})

Template.balanceTable.balances = () ->
  ts = Transactions.find().
    fetch()
  r = _.uniq(
    _.reject(
      _.union(
        _.pluck( ts, 'to' ),
        _.pluck( ts, 'from' )
      )
      , (x) ->
        x != Meteor.userId() ) )

  console.log(r)
  r

Template.newTransactionForm.events({
  'click #create' : (e, template) ->
    # prevent the form from submitting
    e.preventDefault()
    # build the data
    if $('#toMe').hasClass('active')
      to = Meteor.userId()
      from = template.find('#targetBuddy').value
    else
      from = Meteor.userId()
      to = template.find('#targetBuddy').value
    newTransaction = {
      to: to
      from: from
      amount: template.find('#amount').value
      memo: template.find('#memo').value
    }
    Meteor.call('createTransaction', newTransaction, (error)->
      console.log(error)
    )
    $('#newTransaction')[0].reset()
})

