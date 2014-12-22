Template.Users.helpers
	users: ->
		Users.find().map (user) ->
			created = ''
			emails = []

			if user.emails
				emails = user.emails

			if user.createdAt
				created = moment(user.createdAt).format('MMM, D, YYYY')

			{
				_id: user._id
				created: created
				emails: emails
			}