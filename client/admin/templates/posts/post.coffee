Template.AdminPost.helpers
	fields: ->
		customFields = @fields

		fields = Fields.find({}, { sort: { createdAt: -1 } }).fetch()

		fields.forEach (field) ->
			if customFields.hasOwnProperty(field.slug)
				field['value'] = customFields[field.slug].value

			if field.type == 'String'
				field.string = true

			if field.type == 'Number'
				field.number = true

			if field.type == 'Textarea' || field.type == 'HTML'
				field.textarea = true

			if field.type == 'Repeater'
				field.repeater = true

		fields

	errorMessage: (field) ->
		Session.get('postEditErrors')[field]

Template.AdminPost.events
	'click .delete': ->
		Meteor.call 'deletePost', @_id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully deleted post'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to delete post'

	'click .restore': ->
		Meteor.call 'restorePost', @_id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully restored post'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to restore post'

	'submit .update-post': (event) ->

		post = {
			id: @_id
			title: $(event.target).find('[name="title"]').val()
			url: $(event.target).find('[name="url"]').val()
			activated: $(event.target).find('[name="activated"]').prop('checked')
			updateUrl: $(event.target).find('[name="updateUrl"]').prop('checked')
			content: $(event.target).find('[name="content"]').val()
			type: @type
			customFields: {}
		}

		$(event.target).find('.custom-field').each ->
			post.customFields[$(this).prop('name')] = {
				type: $(this).data('type')
				value: $(this).val()
			}

		$(event.target).find('.repeater-group').each ->
			fields = []

			$(this).find('.repeater-field input').each ->
				fields.push { value: $(this).val() }

			post.customFields[$(this).data('name')] = {
				type: $(this).data('type')
				value: fields
			}

		errors = validatePost(post)
		
		if (errors.title || errors.content || errors.type || errors.url)
			Session.set 'postEditErrors', errors

			return false

		Meteor.call 'updatePost', post, (error, result) ->
			
			if error
				Session.set 'typeOfError', 'failure'
				throwError error.error
			else
				if result.success
					Session.set 'typeOfError', 'success'

					$('.update-post').find('.appended').remove()
				else
					Session.set 'typeOfError', 'failure'

				Session.set('postEditErrors', {})
				
				throwError result.message

		return false

Template.AdminPost.created = () ->
	Session.set('postEditErrors', {})