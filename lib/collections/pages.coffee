@validatePage = (page) ->
	errors = {}

	unless page.type.length && Match.test(page.type, String)
		errors.type = "Type is required"

	unless page.url.length && Match.test(page.url, String)
		errors.url = "Url is required"
		
	errors

@Pages = new Mongo.Collection "pages"