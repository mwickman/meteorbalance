# template helpers
toMoney = (mny) ->
  '$'+mny.toFixed(2)

Handlebars.registerHelper "date", (dateObject) ->
  new Date(dateObject).toLocaleDateString()

Handlebars.registerHelper "balanceStatus", (amount) ->
  amount > 0 ? "OWES YOU" : "YOU OWE"

Handlebars.registerHelper "balanceAmountPrint", (amount) ->
  toMoney(Math.abs(amount))

Meteor.subscribe("transactions")
Meteor.subscribe("balances")

Template.balanceTable.balances = () ->
  Balances.find()

Template.transactionTable.transactions = () ->
  Transactions.find()

Template.transactionTable.events({
  'click .set-transaction-target': (e, template) ->
    e.preventDefault()
    $('#targetBuddy').val(e.target.innerHTML)
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
  Meteor.call('createTransaction', newTransaction, (error)->
    console.log(error)
  )
  $('#newTransaction')[0].reset()

Template.newTransactionForm.events({
  'click #create' : createTransaction
})
