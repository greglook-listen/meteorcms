@Fields = new Mongo.Collection "fields"

@fieldMethods = {}

fieldMethods.validateField = (field) ->
	errors = {}

	unless field.name.length && Match.test(field.name, String)
		errors.fieldName = "Field Name is required"

	unless field.type.length && Match.test(field.type, String)
		errors.type = "Type is required"

	unless field.pageType.length && Match.test(field.pageType, String)
		errors.pageType = "Page Type is required"

	unless field.location.length && Match.test(field.location, String)
		errors.location = "Location is required"

	errors