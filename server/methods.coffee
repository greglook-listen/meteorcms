Meteor.methods
	
	createCustomer: (customer) -> # customer = { firstName, lastName, phoneNumber }
		result = {}

		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else
			errors = validateCustomer(customer)
			
			if (errors.firstName || errors.lastName || errors.phoneNumber)
				result.success = false
				result.message = "Validation Error"
			else
				Customers.insert(
					{
						firstName: customer.firstName
						lastName: customer.lastName
						phoneNumber: customer.phoneNumber
						createdAt: new Date()
						updatedAt: new Date()
						owner: Meteor.userId()
					}
				)

				result.success = true
				result.message = "Successfully created customer"

		return result
	
	updateCustomer: (customer) -> # customer = { id, firstName, lastName, phoneNumber }
		result = {}

		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else
			errors = validateCustomer(customer)

			if (errors.firstName || errors.lastName || errors.phoneNumber)
				result.success = false
				result.message = "Validation Error"
			else
				Customers.update(
					{ _id: customer.id }
					{
						$set: {
							firstName: customer.firstName
							lastName: customer.lastName
							phoneNumber: customer.phoneNumber
							updatedAt: new Date()
						}
					}
				)

				result.success = true
				result.message = "Successfully updated customer"

		return result

	deleteCustomer: (id) ->
		if !Meteor.userId()
			return {
				success: false
				message: "not-authorized"
			}
		
		Customers.remove(id)



	createPage: (page) -> # page = { type }
		result = {}

		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else
			errors = validatePage(page)
			
			if (errors.type)
				result.success = false
				result.message = "Validation Error"
			else

				type = page.type

				url = type.toString().toLowerCase().replace(/\s+/g, '-').replace(/[^\w\-]+/g, '').replace(/\-\-+/g, '-').replace(/^-+/, '').replace(/-+$/, '')

				existingPage = Pages.findOne(url: url)

				if existingPage
					result.success = false
					result.message = "This url already exists"
				else
					Pages.insert(
						{
							type: page.type
							url: url
							createdAt: new Date()
							updatedAt: new Date()
							author: Meteor.userId()
						}
					)

					result.success = true
					result.message = "Successfully created page"

		return result

	updatePage: (page) -> # page = { id, type, oldUrl }
		result = {}

		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else
			errors = validatePage(page)

			if (errors.type)
				result.success = false
				result.message = "Validation Error"
			else

				type = page.type

				url = type.toString().toLowerCase().replace(/\s+/g, '-').replace(/[^\w\-]+/g, '').replace(/\-\-+/g, '-').replace(/^-+/, '').replace(/-+$/, '')

				existingPage = Pages.findOne(url: url)

				if existingPage
					result.success = false
					result.message = "This url already exists"
				else

					serverPage = Pages.findOne(_id: page.id)

					# update the type property on all posts associated with this page
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

					Pages.update(
						{ _id: page.id }
						{
							$set: {
								type: page.type
								url: url
								updatedAt: new Date()
							}
						}
					)

					result.success = true
					result.message = "Successfully updated post"

		return result

	deletePage: (id) ->
		if !Meteor.userId()
			return {
				success: false
				message: "not-authorized"
			}
		
		Pages.remove(id)




	createPost: (post) -> # post = { title, content, type }
		result = {}

		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else
			errors = validatePost(post)
			
			if (errors.title || errors.content || errors.type)
				result.success = false
				result.message = "Validation Error"
			else

				title = post.title

				url = title.toString().toLowerCase().replace(/\s+/g, '-').replace(/[^\w\-]+/g, '').replace(/\-\-+/g, '-').replace(/^-+/, '').replace(/-+$/, '')

				existingPost = Posts.findOne(type: post.type, url: url)

				if existingPost
					result.success = false
					result.message = "This url already exists"
				else
					Posts.insert(
						{
							title: post.title
							content: post.content
							type: post.type
							url: url
							createdAt: new Date()
							updatedAt: new Date()
							author: Meteor.userId()
						}
					)

					result.success = true
					result.message = "Successfully created post"

		return result
	
	updatePost: (post) -> # post = { id, title, content, type }
		result = {}

		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else
			errors = validatePost(post)

			if (errors.title || errors.content)
				result.success = false
				result.message = "Validation Error"
			else

				title = post.title

				url = title.toString().toLowerCase().replace(/\s+/g, '-').replace(/[^\w\-]+/g, '').replace(/\-\-+/g, '-').replace(/^-+/, '').replace(/-+$/, '')

				existingPost = Posts.findOne(type: post.type, url: url)

				if existingPost
					result.success = false
					result.message = "This url already exists"
				else
					Posts.update(
						{ _id: post.id }
						{
							$set: {
								title: post.title
								content: post.content
								url: url
								updatedAt: new Date()
							}
						}
					)

					result.success = true
					result.message = "Successfully updated post"

		return result

	deletePost: (id) ->
		if !Meteor.userId()
			return {
				success: false
				message: "not-authorized"
			}
		
		Posts.remove(id)