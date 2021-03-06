Meteor.methods
	
	createPost: (post) -> # post = { title, content, type, url, customFields }
		
		# check for existing url
		url = formatUrl(post.url)

		result = postMethods.parsePost(post, url)

		if result.validated
			Posts.insert(
				{
					title: post.title
					content: post.content
					type: post.type
					url: url
					activated: post.activated
					fields: post.customFields
					createdAt: new Date()
					updatedAt: new Date()
					deletedAt: null
					author: Meteor.userId()
				}
			)

			result.success = true
			result.message = "Successfully created post"

		return result
	
	updatePost: (post) -> # post = { id, title, content, type, url, updateUrl, customFields }
		
		# check for existing url
		url = formatUrl(post.url)

		result = postMethods.parsePost(post, url)

		if result.validated
			serverPost = Posts.findOne(_id: post.id)

			# add new revision JSON object to revisions property
			revisions = postMethods.generatePostRevisions(serverPost)

			data = {
				title: post.title
				content: post.content
				activated: post.activated
				fields: post.customFields
				revisions: revisions
				updatedAt: new Date()
			}

			if post.updateUrl
				data['url'] = url

			# update post
			Posts.update(
				{ 
					_id: post.id
				}
				{
					$set: data
				}
			)

			result.success = true
			result.message = "Successfully updated post"

		return result

	deletePost: (id) ->
		postMethods.updateDeletedPost(id, new Date())

	restorePost: (id) ->
		postMethods.updateDeletedPost(id, null)



# this either soft deletes or restores a post depending on what is passed in for deletedAt
postMethods.updateDeletedPost = (id, deletedAt) ->
	if !Meteor.userId()
		return {
			success: false
			message: "not-authorized"
		}

	serverPost = Posts.findOne(_id: id)

	# add new revision JSON object to revisions property
	revisions = postMethods.generatePostRevisions(serverPost)

	Posts.update(
		{ _id: id }
		{
			$set: {
				deletedAt: deletedAt
				revisions: revisions
			}
		}
	)



# this gets the existing post revisions array and pushes a new revision
postMethods.generatePostRevisions = (p) ->
	revision = {
		title: p.title
		content: p.content
		type: p.type
		url: p.url
		fields: p.fields
		createdAt: p.createdAt
		updatedAt: p.updatedAt
		deletedAt: p.deletedAt
		author: p.author
	}

	revisions = []

	if p.revisions
		revisions = p.revisions

	revision = JSON.stringify(revision)

	revisions.push(revision: revision)

	revisions



# this handles all the validation stuff

# validate logged in user
# validate data
# check for existing post

postMethods.parsePost = (post, url) ->
	result = {}
	result.success = false
	result.validated = false

	# validate logged in user
	if !Meteor.userId()
		result.message = "not-authorized"
		
		return result

	# validate data
	errors = postMethods.validatePost(post)
	
	if (errors.title || errors.content || errors.type || errors.url)
		result.message = "Validation Error"
		
		return result

	existingPost = Posts.findOne(type: post.type, url: url)

	if post.updateUrl && existingPost
		result.message = "This url already exists"
		
		return result

	result.validated = true

	return result