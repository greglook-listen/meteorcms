Template.AdminPage.helpers
	pages: ->
		Pages.find(
			{}
			{
				sort: { createdAt: -1 }
			}
		)

	errorMessage: (field) ->
		Session.get('pageCreationErrors')[field]

Template.AdminPage.events
	'submit .new-page': (event) ->
		
		page = {
			type: $(event.target).find('[name="type"]').val()
		}

		errors = validatePage(page)
		
		if (errors.type)
			Session.set 'pageCreationErrors', errors

			return false

		Meteor.call 'createPage', page, (error, result) ->
				
			if error
				throwError error.error
			else
				throwError result.message

				console.log result

		return false

Template.AdminPage.created = () ->
	Session.set('pageCreationErrors', {})