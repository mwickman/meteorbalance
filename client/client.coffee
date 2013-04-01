# template helpers
toMoney = (money) ->
  '$'+(parseFloat(money)).toFixed(2)

Handlebars.registerHelper "toMoney", (money) ->
  toMoney (money)

Handlebars.registerHelper "date", (dateObject) ->
  new Date(dateObject).toLocaleDateString()

Handlebars.registerHelper "balanceStatus", (amount) ->
  if amount > 0 then "OWES YOU" else "YOU OWE"

Handlebars.registerHelper "directionHelper", (direction) ->
  if direction > 0 then "YOU PAID" else "PAID YOU" 

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
