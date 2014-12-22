Template.PageType.helpers
	posts: ->
		Posts.find(
			{
				type: @url
				activated: true
				deletedAt: null
			}
			{
				sort: { createdAt: -1 }
			}
		)

Template.PageExample.helpers
	posts: ->
		Posts.find(
			{
				type: @url
				activated: true
				deletedAt: null
			}
			{
				sort: { createdAt: -1 }
			}
		)