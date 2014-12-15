Template.PageType.helpers
	posts: ->
		Posts.find(
			{
				type: @url
			}
			{
				sort: { createdAt: -1 }
			}
		)