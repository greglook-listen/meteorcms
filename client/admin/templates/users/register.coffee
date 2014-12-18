Template.Register.helpers()

Template.Register.events
	'submit .register-form': (event) ->

		email = $('#account-email').val()
		password = $('#account-password').val()

		Accounts.createUser({ email: email, password: password}, (error) ->
			if error
				Session.set 'typeOfError', 'failure'
				throwError error
			else
				Session.set 'typeOfError', 'success'

				$('#account-email').val('')
				$('#account-password').val('')

				throwError 'User successfully created'
		)

		return false