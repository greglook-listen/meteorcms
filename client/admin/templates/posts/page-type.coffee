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
			content: $(event.target).find('[name="content"]').val()
			type: @url
		}

		errors = validatePost(post)
		
		if (errors.title || errors.content || errors.type)
			Session.set 'postCreationErrors', errors

			return false

		Meteor.call 'createPost', post, (error, result) ->
				
			if error
				throwError error.error
			else
				throwError result.message

				console.log result

		return false

	'click .delete': ->
		Meteor.call 'deletePage', @_id, (error, result) ->
			if result
				Router.go 'admin'
			else
				throwError 'Unable to delete post'

	'submit .update-page': (event) ->

		page = {
			id: @_id
			type: $(event.target).find('[name="type"]').val()
		}

		errors = validatePage(page)
		
		if (errors.type)
			Session.set 'pageEditErrors', errors

			return false

		Meteor.call 'updatePage', page, (error, result) ->
			
			if error
				throwError error.error
			else
				throwError result.message

				console.log result

		return false

Template.AdminPageType.created = () ->
	Session.set('postCreationErrors', {})
	Session.set('pageEditErrors', {})