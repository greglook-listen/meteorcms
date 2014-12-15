Template.Customers.helpers
	customers: ->
		Customers.find(
			{}
			{
				sort: { createdAt: -1 }
			}
		)

	errorMessage: (field) ->
		Session.get('customerCreationErrors')[field]

Template.Customers.events
	'submit .new-customer': (event) ->
		
		customer = {
			firstName: $('.new-customer [name="firstName"]').val()
			lastName: $('.new-customer [name="lastName"]').val()
			phoneNumber: $('.new-customer [name="phoneNumber"]').val()
		}

		errors = validateCustomer(customer)
		
		if (errors.firstName || errors.lastName || errors.phoneNumber)
			Session.set 'customerCreationErrors', errors

			return false

		Meteor.call 'createCustomer', customer, (error, result) ->
				
			if error
				throwError error.error
			else
				throwError result.message

				console.log result

		return false

Template.Customers.created = () ->
	Session.set('customerCreationErrors', {})