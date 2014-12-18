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
			url: $(event.target).find('[name="url"]').val()
			activated: $(event.target).find('[name="activated"]').prop('checked')
		}

		errors = validatePage(page)
		
		if (errors.type || errors.url)
			Session.set 'pageCreationErrors', errors

			return false

		Meteor.call 'createPage', page, (error, result) ->
				
			if error
				Session.set 'typeOfError', 'failure'
				throwError error.error
			else
				if result.success
					Session.set 'typeOfError', 'success'

					$('.new-page input').val('')
				else
					Session.set 'typeOfError', 'failure'
				
				Session.set('pageCreationErrors', {})

				throwError result.message

		return false

	'keyup .new-page [name="type"]': (event) ->
		value = formatUrl(event.target.value)

		$('.new-page [name="url"]').val(value)

Template.AdminPage.created = () ->
	Session.set('pageCreationErrors', {})