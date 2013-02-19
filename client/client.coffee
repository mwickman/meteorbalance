Meteor.subscribe("transactions")

Template.transactionTable.transactions = () ->
  console.log('got here!')
  Transactions.find()

Template.newTransactionForm.events({ 
  'click #create' : (e, template) ->
    console.log('got here!')
    # prevent the form from submitting
    e.preventDefault()
    # build the data
    newTransaction = {
      targetBuddy: template.find('#targetBuddy').value
      amount: template.find('#amount').value
      memo: template.find('#memo').value
    }
    Meteor.call('createTransaction', newTransaction, (error)->
      console.log(error)
    )
    $('#newTransaction')[0].reset();
})

