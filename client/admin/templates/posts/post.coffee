Template.AdminPost.helpers
	errorMessage: (field) ->
		Session.get('postEditErrors')[field]

Template.AdminPost.events
	'click .delete': ->
		Meteor.call 'deletePost', @_id, (error, result) ->
			if result
				Router.go 'admin'
			else
				throwError 'Unable to delete post'

	'submit .update-post': (event) ->

		post = {
			id: @_id
			title: $(event.target).find('[name="title"]').val()
			content: $(event.target).find('[name="content"]').val()
			type: @type
		}

		errors = validatePost(post)
		
		if (errors.title || errors.content || errors.type)
			Session.set 'postEditErrors', errors

			return false

		Meteor.call 'updatePost', post, (error, result) ->
			
			if error
				throwError error.error
			else
				throwError result.message

				console.log result

		return false

Template.AdminPost.created = () ->
	Session.set('postEditErrors', {})