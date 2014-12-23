Template.AdminPageList.helpers
	count: ->
		console.log @url
		Posts.find(
			{
				type: @url
			}
		).count()