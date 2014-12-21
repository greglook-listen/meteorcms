Template.Dashboard.helpers
	activePageCount: ->
		Pages.find(
			{
				activated: true
				deletedAt: null
			}
		).count()

	pageCount: ->
		Pages.find(
			{
				deletedAt: null
			}
		).count()

	activePostCount: ->
		Posts.find(
			{
				activated: true
				deletedAt: null
			}
		).count()

	postCount: ->
		Posts.find(
			{
				deletedAt: null
			}
		).count()

	userCount: ->
		Users.find().count()

	fieldCount: ->
		Fields.find().count()