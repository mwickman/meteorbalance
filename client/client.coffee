# template helpers
Handlebars.registerHelper("date", (dateObject) ->
  new Date(dateObject).toLocaleDateString()
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

Template.newTransactionForm.events({
  'click #create' : createTransaction
})

createTransaction = (e, template) ->
  # prevent the form from submitting
  e.preventDefault()

  dir = if $('#toMe').hasClass('active') then -1 else 1
  newTransaction = {
    direction: dir
    target_buddy: $('#targetBuddy').val()
    amount: template.find('#amount').value
    memo: template.find('#memo').value
  }
  console.log('got here!')
  Meteor.call('createTransaction', newTransaction, (error)->
    console.log(error)
  )
  $('#newTransaction')[0].reset()
