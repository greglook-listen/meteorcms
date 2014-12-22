Template.Main.helpers
	time: new moment().format('MMM D, YYYY')

	typeOfError: ->
		Session.get 'typeOfError'
		
	pages: ->
		Pages.find(
			{
				activated: true
				deletedAt: null
			}
			{
				sort: { createdAt: -1 }
			}
		)

Template.Main.events
	'click .logout': ->
		Meteor.logout (error) ->
			Router.go 'login'

		false