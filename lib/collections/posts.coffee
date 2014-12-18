@validatePost = (post) ->
	errors = {}

	unless post.title.length && Match.test(post.title, String)
		errors.title = "Title is required"

	unless post.content.length && Match.test(post.content, String)
		errors.content = "Content is required"

	unless post.url.length && Match.test(post.url, String)
		errors.url = "Url is required"

	errors

@Posts = new Mongo.Collection "posts"