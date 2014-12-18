Meteor.methods
	
	createPage: (page) -> # page = { type, url }
		result = {}

		# validate logged in user
		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else

			# validate data
			errors = validatePage(page)
			
			if (errors.type || errors.url)
				result.success = false
				result.message = "Validation Error"
			else

				# check for existing url
				url = formatUrl(page.url)

				existingPage = Pages.findOne(url: url)

				if existingPage
					result.success = false
					result.message = "This url already exists"
				else
					Pages.insert(
						{
							type: page.type
							url: url
							activated: page.activated
							createdAt: new Date()
							updatedAt: new Date()
							deletedAt: null
							author: Meteor.userId()
						}
					)

					result.success = true
					result.message = "Successfully created page"

		return result

	updatePage: (page) -> # page = { id, type, url, updateUrl }
		result = {}

		# validate logged in user
		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else

			# validate data
			errors = validatePage(page)

			if (errors.type || errors.url)
				result.success = false
				result.message = "Validation Error"
			else

				# check for existing url
				url = formatUrl(page.url)

				existingPage = Pages.findOne(url: url)

				if page.updateUrl && existingPage
					result.success = false
					result.message = "This url already exists"
				else

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
					revisions = generatePageRevisions(serverPage)

					if page.updateUrl
						data = {
							type: page.type
							url: url
							activated: page.activated
							revisions: revisions
							updatedAt: new Date()
						}
					else
						data = {
							type: page.type
							activated: page.activated
							revisions: revisions
							updatedAt: new Date()
						}
					
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
		updateDeletedPage(id, new Date())

	restorePage: (id) ->
		updateDeletedPage(id, null)


# this either soft deletes or restores a page depending on what is passed in for deletedAt
@updateDeletedPage = (id, deletedAt) ->
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

	revisions = generatePageRevisions(serverPage)
	
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
@generatePageRevisions = (serverPage) ->
	revision = {
		type: serverPage.type
		url: serverPage.url
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