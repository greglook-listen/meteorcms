Template.AdminPageType.helpers
	posts: ->
		Posts.find(
			{
				type: @url
			}
			{
				sort: { createdAt: -1 }
			}
		)

	pageFields: ->
		customFields = @fields

		fields = Fields.find(
			{
				pageType: @url
				location: 'page'
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

	postFields: ->
		fields = Fields.find(
			{
				pageType: @url
				location: 'post'
			}
			{
				sort: { createdAt: -1 }
			}
		).fetch()

		fields.forEach (field) ->
			
			if field.type == 'String'
				field.string = true

			if field.type == 'Number'
				field.number = true

			if field.type == 'Textarea' || field.type == 'HTML'
				field.textarea = true

			if field.type == 'Repeater'
				field.repeater = true
				
		fields

	creationMessage: (field) ->
		Session.get('postCreationErrors')[field]

	editMessage: (field) ->
		Session.get('pageEditErrors')[field]

Template.AdminPageType.events
	'submit .new-post': (event) ->
		form = $(event.target)

		post = {
			title: form.find('[name="title"]').val()
			url: form.find('[name="url"]').val()
			content: form.find('[name="content"]').val()
			activated: form.find('[name="activated"]').prop('checked')
			type: @url
			customFields: {}
		}

		form.find('.custom-field').each ->
			post.customFields[$(this).prop('name')] = {
				type: $(this).data('type')
				value: $(this).val()
			}

		form.find('.repeater-group').each ->
			console.log $(this).find('.repeater-field')

			fields = []

			$(this).find('.repeater-field input').each ->
				fields.push { value: $(this).val() }

			post.customFields[$(this).data('name')] = {
				type: $(this).data('type')
				value: fields
			}

		errors = validatePost(post)
		
		if (errors.title || errors.content || errors.type || errors.url)
			Session.set 'postCreationErrors', errors

			return false

		Meteor.call 'createPost', post, (error, result) ->
				
			if error
				Session.set 'typeOfError', 'failure'
				throwError error.error
			else
				if result.success
					Session.set 'typeOfError', 'success'

					$('.new-post input, .new-post textarea').val('')
				else
					Session.set 'typeOfError', 'failure'

				Session.set('postCreationErrors', {})

				throwError result.message

		return false

	'keyup .new-post [name="title"]': (event) ->
		value = formatUrl(event.target.value)
			
		$('.new-post [name="url"]').val(value)

	'click .delete': ->
		Meteor.call 'deletePage', @_id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully deleted page'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to delete page'

		return false

	'click .restore': ->
		Meteor.call 'restorePage', @_id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully restored page'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to restore page'

		return false
		
	'submit .update-page': (event) ->
		form = $(event.target)

		page = {
			id: @_id
			type: form.find('[name="type"]').val()
			url: form.find('[name="url"]').val()
			activated: form.find('[name="activated"]').prop('checked')
			updateUrl: form.find('[name="updateUrl"]').prop('checked')
			customFields: {}
		}

		form.find('.custom-field').each ->
			page.customFields[$(this).prop('name')] = {
				type: $(this).data('type')
				value: $(this).val()
			}

		form.find('.repeater-group').each ->
			console.log $(this).find('.repeater-field')

			fields = []

			$(this).find('.repeater-field input').each ->
				fields.push { value: $(this).val() }

			page.customFields[$(this).data('name')] = {
				type: $(this).data('type')
				value: fields
			}

		errors = validatePage(page)
		
		if (errors.type || errors.url)
			Session.set 'pageEditErrors', errors

			return false

		Meteor.call 'updatePage', page, (error, result) ->
			
			if error
				Session.set 'typeOfError', 'failure'
				throwError error.error
			else
				if result.success
					Session.set 'typeOfError', 'success'
				else
					Session.set 'typeOfError', 'failure'

				Session.set('pageEditErrors', {})

				throwError result.message

		return false

Template.AdminPageType.created = () ->
	Session.set('postCreationErrors', {})
	Session.set('pageEditErrors', {})