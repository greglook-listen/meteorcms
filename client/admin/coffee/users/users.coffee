Template.Users.helpers
	users: ->
		Users.find().map (user) ->
			created = ''
			emails = []

			if user.emails
				emails = user.emails

			if user.createdAt
				created = moment(user.createdAt).format('MMM, D, YYYY')

			role = ''

			if user.profile.developer
				role = 'developer'

			if user.profile.admin
				role = 'admin'

			{
				_id: user._id
				created: created
				emails: emails
				role: role
			}