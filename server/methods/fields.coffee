Meteor.methods
	
	createField: (field) -> # field = { name, type, pageType, location }
		result = {}
		result.success = false

		# validate logged in user
		if !Meteor.userId()
			result.message = "not-authorized"
			return result

		# validate data
		errors = validateField(field)
		
		if (errors.name || errors.type || errors.pageType || errors.location)
			result.message = "Validation Error"
			return result

		slug = formatSlug(field.name)

		existingField = Fields.findOne(slug: slug)

		if existingField
			result.message = "A field with this slug already exists"
			return result

		Fields.insert(
			{
				name: field.name
				type: field.type
				pageType: field.pageType
				slug: slug
				location: field.location
				createdAt: new Date()
				updatedAt: new Date()
				deletedAt: null
				author: Meteor.userId()
			}
		)

		result.success = true
		result.message = "Successfully created field"

		return result

	deleteField: (id) ->
		if !Meteor.userId()
			return {
				success: false
				message: "not-authorized"
			}

		Fields.remove(_id: id)