Template.Users.helpers
	users: ->
		Users.find().map (user) ->
			emails = []

			if user.emails
				emails = user.emails

			role = ''

			if user.profile.developer
				role = 'developer'

			if user.profile.admin
				role = 'admin'

			{
				_id: user._id
				created: user.createdAt
				emails: emails
				role: role
			}