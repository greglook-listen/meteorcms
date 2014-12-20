Template.AdminFields.helpers
	fields: ->
		Fields.find(
			{}
			{
				sort: { createdAt: -1 }
			}
		)

	errorMessage: (field) ->
		Session.get('errorMessage')[field]

Template.AdminFields.events
	'submit .new-field': (event) ->
		
		field = {
			name: $(event.target).find('[name="fieldName"]').val()
			type: $(event.target).find('[name="fieldType"]').val()
		}

		errors = validateField(field)
		
		if (errors.name || errors.type)
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