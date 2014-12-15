Template.Customer.helpers
	errorMessage: (field) ->
		Session.get('customerEditErrors')[field]

Template.Customer.events
	'click .delete': ->
		Meteor.call 'deleteCustomer', @_id, (error, result) ->
			if result
				Router.go 'customers'
			else
				throwError 'Unable to delete customer'

	'submit .update-customer': ->

		customer = {
			id: @_id
			firstName: $('.update-customer [name="firstName"]').val()
			lastName: $('.update-customer [name="lastName"]').val()
			phoneNumber: $('.update-customer [name="phoneNumber"]').val()
		}

		errors = validateCustomer(customer)
		
		if (errors.firstName || errors.lastName || errors.phoneNumber)
			Session.set 'customerEditErrors', errors

			return false

		Meteor.call 'updateCustomer', customer, (error, result) ->
			
			if error
				throwError error.error
			else
				throwError result.message

				console.log result

		return false

Template.Customer.created = () ->
	Session.set('customerEditErrors', {})