Template.AdminPost.helpers
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
				else
					Session.set 'typeOfError', 'failure'

				Session.set('postEditErrors', {})
				
				throwError result.message

		return false

Template.AdminPost.created = () ->
	Session.set('postEditErrors', {})