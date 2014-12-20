Template.AdminFields.helpers
	fields: ->
		Fields.find(
			{}
			{
				sort: { createdAt: -1 }
			}
		)

	types: ->
		Pages.find(
			{}
			{
				sort: { createdAt: -1 }
			}
		)

	errorMessage: (field) ->
		Session.get('errorMessage')[field]

Template.AdminFields.events
	'submit .new-field': (event) ->
		form = $(event.target)

		field = {
			name: form.find('[name="fieldName"]').val()
			type: form.find('[name="fieldType"]').val()
			pageType: form.find('[name="pageType"]').val()
		}

		errors = validateField(field)
		
		if (errors.name || errors.type || errors.pageType)
			Session.set 'errorMessage', errors

			return false

		Meteor.call 'createField', field, (error, result) ->
				
			if error
				Session.set 'typeOfError', 'failure'
				throwError error.error
			else
				if result.success
					Session.set 'typeOfError', 'success'

					$('.new-field input').val('')
				else
					Session.set 'typeOfError', 'failure'

				Session.set('errorMessage', {})
				
				throwError result.message

		return false

Template.AdminFields.created = () ->
	Session.set('errorMessage', {})