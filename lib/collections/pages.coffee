@validatePage = (page) ->
	errors = {}

	unless page.type.length && Match.test(page.type, String)
		errors.type = "Type is required"

	errors

@Pages = new Mongo.Collection "pages"