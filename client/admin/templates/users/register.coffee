Template.Register.helpers()

Template.Register.events
	'submit .register-form': (event) ->

		email = $('#account-email').val()
		password = $('#account-password').val()

		Accounts.createUser({ email: email, password: password}, (error) ->
			if error
				throwError error
			else
				throwError result
		)

		return false