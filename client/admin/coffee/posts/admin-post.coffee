Template.AdminPost.helpers
	postFields: ->
		customFields = @fields

		fields = Fields.find(
			{
				pageType: @type
				location: 'post'
			}
			{
				sort: { createdAt: -1 }
			}
		).fetch()

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

		return false

	'click .restore': ->
		Meteor.call 'restorePost', @_id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully restored post'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to restore post'

		return false
		
	'submit .update-post': (event) ->
		form = $(event.target)

		post = {
			id: @_id
			title: form.find('[name="title"]').val()
			url: form.find('[name="url"]').val()
			activated: form.find('[name="activated"]').prop('checked')
			updateUrl: form.find('[name="updateUrl"]').prop('checked')
			content: form.find('[name="content"]').val()
			type: @type
			customFields: {}
		}

		form.find('.custom-field').each ->
			post.customFields[$(this).prop('name')] = {
				type: $(this).data('type')
				value: $(this).val()
			}

		form.find('.repeater-group').each ->
			fields = []

			$(this).find('.repeater-field input').each ->
				fields.push { value: $(this).val() }

			post.customFields[$(this).data('name')] = {
				type: $(this).data('type')
				value: fields
			}

		errors = postMethods.validatePost(post)
		
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
	console.log 'created'

Template.AdminPost.rendered = () ->
	console.log 'rendered'

Template.AdminPost.destroyed = () ->
	console.log 'destroyed'