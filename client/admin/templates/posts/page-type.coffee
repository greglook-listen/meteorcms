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

	fields: ->
		fields = Fields.find({}, { sort: { createdAt: -1 } }).fetch()

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
		
		post = {
			title: $(event.target).find('[name="title"]').val()
			url: $(event.target).find('[name="url"]').val()
			content: $(event.target).find('[name="content"]').val()
			activated: $(event.target).find('[name="activated"]').prop('checked')
			type: @url
			customFields: {}
		}

		$(event.target).find('.custom-field').each ->
			post.customFields[$(this).prop('name')] = {
				type: $(this).data('type')
				value: $(this).val()
			}

		$(event.target).find('.repeater-group').each ->
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

	'click .restore': ->
		Meteor.call 'restorePage', @_id, (error, result) ->
			if result
				Session.set 'typeOfError', 'success'
				throwError 'Successfully restored page'
			else
				Session.set 'typeOfError', 'failure'
				throwError 'Unable to restore page'

	'submit .update-page': (event) ->

		page = {
			id: @_id
			type: $(event.target).find('[name="type"]').val()
			url: $(event.target).find('[name="url"]').val()
			activated: $(event.target).find('[name="activated"]').prop('checked')
			updateUrl: $(event.target).find('[name="updateUrl"]').prop('checked')
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