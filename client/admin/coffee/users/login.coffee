Template.Login.events
	'submit .login-form': ->

		email = $('#login-email').val()
		password = $('#login-password').val()

		Meteor.loginWithPassword email, password, (error, result) ->
			if error
				Session.set 'typeOfError', 'failure'
				throwError error
			else
				Session.set 'typeOfError', 'success'
				Router.go 'dashboard'

		return false