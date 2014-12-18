Template.Admin.helpers
	time: new moment().format('MMM D, YYYY')

	typeOfError: ->
		Session.get 'typeOfError'

Template.Admin.events
	'click .logout': ->
		Meteor.logout (error) ->
			Router.go 'login'

		false