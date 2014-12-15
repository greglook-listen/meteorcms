Meteor.startup ->
	Tracker.autorun ->
		console.log Users.find().fetch()
		console.log Customers.find().fetch()

Template.Main.helpers
	time: new moment().format('MMM D, YYYY')

	pages: ->
		Pages.find(
			{}
			{
				sort: { createdAt: -1 }
			}
		)

Template.Main.events
	'click .logout': ->
		Meteor.logout (error) ->
			Router.go 'login'

		false