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

					$('.new-post input').val('')
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