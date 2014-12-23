Template.Register.helpers()

Template.Register.events
	'submit .register-form': (event) ->

		user = {
			email: $('#account-email').val()
			password: $('#account-password').val()
			profile: {
				admin: true
			}
		}

		Accounts.createUser(user, (error) ->
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