Meteor.methods
	
	createPost: (post) -> # post = { title, content, type, url, customFields }
		
		# check for existing url
		url = formatUrl(post.url)

		result = parsePost(post, url)

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

		result = parsePost(post, url)

		if result.validated
			serverPost = Posts.findOne(_id: post.id)

			# add new revision JSON object to revisions property
			revisions = generatePostRevisions(serverPost)

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
		updateDeletedPost(id, new Date())

	restorePost: (id) ->
		updateDeletedPost(id, null)



# this either soft deletes or restores a post depending on what is passed in for deletedAt
@updateDeletedPost = (id, deletedAt) ->
	if !Meteor.userId()
		return {
			success: false
			message: "not-authorized"
		}

	serverPost = Posts.findOne(_id: id)

	# add new revision JSON object to revisions property
	revisions = generatePostRevisions(serverPost)

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
@generatePostRevisions = (serverPost) ->
	revision = {
		title: serverPost.title
		content: serverPost.content
		type: serverPost.type
		url: serverPost.url
		fields: serverPost.fields
		createdAt: serverPost.createdAt
		updatedAt: serverPost.updatedAt
		deletedAt: serverPost.deletedAt
		author: serverPost.author
	}

	revisions = []

	if serverPost.revisions
		revisions = serverPost.revisions

	revision = JSON.stringify(revision)

	revisions.push(revision: revision)

	revisions



# this handles all the validation stuff

# validate logged in user
# validate data
# check for existing post

@parsePost = (post, url) ->
	result = {}
	result.success = false
	result.validated = false

	# validate logged in user
	if !Meteor.userId()
		result.message = "not-authorized"
		
		return result

	# validate data
	errors = validatePost(post)
	
	if (errors.title || errors.content || errors.type || errors.url)
		result.message = "Validation Error"
		
		return result

	existingPost = Posts.findOne(type: post.type, url: url)

	if post.updateUrl && existingPost
		result.message = "This url already exists"
		
		return result

	result.validated = true

	return result