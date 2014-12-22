Meteor.methods
	
	createField: (field) -> # field = { name, type, pageType, location }

		# format slug
		slug = formatSlug(field.name)

		# validate data and other stuff
		result = parseField(field, slug)

		if result.validated
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



# this handles all the validation stuff

# validate logged in user
# validate data
# check for existing field

@parseField = (field, slug) ->
	result = {}
	result.success = false
	result.validated = false

	# validate logged in user
	if !Meteor.userId()
		result.message = "not-authorized"
		return result

	# validate data
	errors = validateField(field)
	
	if (errors.name || errors.type || errors.pageType || errors.location)
		result.message = "Validation Error"
		return result

	existingField = Fields.findOne(slug: slug)

	if existingField
		result.message = "A field with this slug already exists"
		return result

	result.validated = true

	return result