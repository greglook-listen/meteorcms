@Pages = new Mongo.Collection "pages"

@pageMethods = {}

pageMethods.validatePage = (page) ->
	errors = {}

	unless page.type.length && Match.test(page.type, String)
		errors.type = "Type is required"

	unless page.url.length && Match.test(page.url, String)
		errors.url = "Url is required"
	
	unless page.content.length && Match.test(page.content, String)
		errors.content = "Content is required"
				
	errors