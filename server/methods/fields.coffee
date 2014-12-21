Meteor.methods
	
	createField: (field) -> # field = { name, type, pageType, location }
		result = {}

		# validate logged in user
		if !Meteor.userId()
			result.success = false
			result.message = "not-authorized"
		else

			# validate data
			errors = validateField(field)
			
			if (errors.name || errors.type || errors.pageType || errors.location)
				result.success = false
				result.message = "Validation Error"
			else

				slug = formatSlug(field.name)

				existingField = Fields.findOne(slug: slug)

				if existingField
					result.success = false
					result.message = "A field with this slug already exists"
				else

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