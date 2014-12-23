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
			{
				deletedAt: null
			}
			{
				sort: { createdAt: -1 }
			}
		).fetch()

	errorMessage: (field) ->
		Session.get('errorMessage')[field]

Template.AdminFields.events
	'submit .new-field': (event) ->
		form = $(event.target)

		field = {
			name: form.find('[name="fieldName"]').val()
			type: form.find('[name="fieldType"]').val()
			pageType: form.find('[name="pageType"]').val()
			location: form.find('[name="location"]').val()
		}

		errors = fieldMethods.validateField(field)
		
		if (errors.fieldName || errors.type || errors.pageType || errors.location)
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

	'click .delete': (event) ->
		id = $(event.target).data('id')

		Meteor.call 'deleteField', id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully deleted field'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to delete field'

		return false

	'keyup .new-field [name="fieldName"]': (event) ->
		value = formatSlug(event.target.value)

		$('.new-field-url').html(value)

	'click .show-field-records': (event) ->
		$('.show-field-records, .field-creation-records').addClass('active')
		$('.show-field-creation, .field-creation-form').removeClass('active')

	'click .show-field-creation': (event) ->
		$('.show-field-creation, .field-creation-form').addClass('active')
		$('.show-field-records, .field-creation-records').removeClass('active')

Template.AdminFields.created = () ->
	Session.set('errorMessage', {})