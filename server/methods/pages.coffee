Meteor.methods
	
	createPage: (page) -> # page = { type, url, updateUrl }
		
		# format url
		url = formatUrl(page.url)

		# validate data and other stuff
		result = pageMethods.parsePage(page, url)

		if result.validated
			Pages.insert(
				{
					type: page.type
					url: url
					content: page.content
					activated: page.activated
					fields: {}
					createdAt: new Date()
					updatedAt: new Date()
					deletedAt: null
					author: Meteor.userId()
				}
			)

			result.success = true
			result.message = "Successfully created page"

		return result

	updatePage: (page) -> # page = { id, type, url, updateUrl, customFields }

		# format url
		url = formatUrl(page.url)

		# validate data and other stuff
		result = pageMethods.parsePage(page, url)

		if result.validated
			serverPage = Pages.findOne(_id: page.id)

			# update the type property on all posts associated with this page
			# the type property == the url property of the Page (type)
			Posts.update(
				{
					type: serverPage.url
				}
				{
					$set: {
						type: url
						updatedAt: new Date()
					}
				}
			)

			# add new revision JSON object to revisions property
			revisions = pageMethods.generatePageRevisions(serverPage)

			data = {
				type: page.type
				content: page.content
				activated: page.activated
				fields: page.customFields
				revisions: revisions
				updatedAt: new Date()
			}

			if page.updateUrl
				data['url'] = url
			
			# update page
			Pages.update(
				{ _id: page.id }
				{
					$set: data
				}
			)

			result.success = true
			result.message = "Successfully updated post"

		return result

	deletePage: (id) ->
		pageMethods.updateDeletedPage(id, new Date())

	restorePage: (id) ->
		pageMethods.updateDeletedPage(id, null)



# this either soft deletes or restores a page depending on what is passed in for deletedAt
pageMethods.updateDeletedPage = (id, deletedAt) ->
	if !Meteor.userId()
		return {
			success: false
			message: "not-authorized"
		}

	serverPage = Pages.findOne(_id: id)

	# update the deletedAt property for all posts that are children of this page
	Posts.update(
		{
			type: serverPage.url
		}
		{
			$set: {
				deletedAt: deletedAt
			}
		}
	)

	revisions = pageMethods.generatePageRevisions(serverPage)
	
	Pages.update(
		{ _id: id }
		{
			$set: {
				deletedAt: deletedAt
				revisions: revisions
			}
		}
	)



# this gets the existing page revisions array and pushes a new revision
pageMethods.generatePageRevisions = (serverPage) ->
	revision = {
		type: serverPage.type
		url: serverPage.url
		content: serverPage.content
		fields: serverPage.fields
		createdAt: serverPage.createdAt
		updatedAt: serverPage.updatedAt
		deletedAt: serverPage.deletedAt
		author: serverPage.author
	}

	revisions = []

	if serverPage.revisions
		revisions = serverPage.revisions

	revision = JSON.stringify(revision)

	revisions.push(revision: revision)

	revisions



# this handles all the validation stuff

# validate logged in user
# validate data
# check for existing page
# check against reserved paths

pageMethods.parsePage = (page, url) ->
	result = {}
	result.success = false
	result.validated = false

	# validate logged in user
	if !Meteor.userId()
		result.message = "not-authorized"
		return result

	# validate data
	errors = pages.validatePage(page)
	
	if (errors.type || errors.url)
		result.message = "Validation Error"
		return result

	existingPage = Pages.findOne(url: url)

	# check for existing url
	if page.updateUrl && existingPage
		result.message = "This url already exists"
		return result

	reserved = false

	# check against reserved paths (i.e., those defined in router)
	['login', 'admin'].forEach (path) ->
		if path == url then reserved = true

	if reserved
		result.message = "This url is a reserved path"
		return result

	result.validated = true

	return result