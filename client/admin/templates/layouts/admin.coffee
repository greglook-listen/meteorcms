Template.Admin.helpers
	time: new moment().format('MMM D, YYYY')

Template.Admin.events
	'click .logout': ->
		Meteor.logout (error) ->
			Router.go 'login'

		false