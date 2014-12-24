Template.Main.helpers
	time: new moment().format('MMM D, YYYY')

	typeOfError: ->
		Session.get 'typeOfError'
		
	pages: ->
		Pages.find(
			{
				activated: true
				deletedAt: null
				home: { $ne: true }
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


UI.registerHelper 'renderField', (field) ->
	
	if field
		if field.type == 'HTML'
			Spacebars.SafeString field.value
		else
			field.value
	else
		console.log 'You have a reference to a custom field in this template that is undefined'