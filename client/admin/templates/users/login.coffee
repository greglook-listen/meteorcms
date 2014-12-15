Template.Login.events
	'submit .login-form': ->

		email = $('#login-email').val()
		password = $('#login-password').val()

		Meteor.loginWithPassword email, password, (error, result) ->
			if error
				throwError error
			else
				Router.go 'admin'

		return false