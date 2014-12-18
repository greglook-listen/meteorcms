Template.Customer.helpers
	errorMessage: (field) ->
		Session.get('customerEditErrors')[field]

Template.Customer.events
	'click .delete': ->
		Meteor.call 'deleteCustomer', @_id, (error, result) ->
			if result
				Router.go 'customers'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to delete customer'

	'submit .update-customer': (event) ->

		customer = {
			id: @_id
			firstName: $(event.target).find('[name="firstName"]').val()
			lastName: $(event.target).find('[name="lastName"]').val()
			phoneNumber: $(event.target).find('[name="phoneNumber"]').val()
		}

		errors = validateCustomer(customer)
		
		if (errors.firstName || errors.lastName || errors.phoneNumber)
			Session.set 'customerEditErrors', errors

			return false

		Meteor.call 'updateCustomer', customer, (error, result) ->
			
			if error
				Session.set 'typeOfError', 'failure'
				throwError error.error
			else
				if result.success
					Session.set 'typeOfError', 'success'
				else
					Session.set 'typeOfError', 'failure'

				Session.set('customerEditErrors', {})

				throwError result.message

		return false

Template.Customer.created = () ->
	Session.set('customerEditErrors', {})