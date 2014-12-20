@validateField = (field) ->
	errors = {}

	unless field.name.length && Match.test(field.name, String)
		errors.name = "Name is required"

	unless field.type.length && Match.test(field.type, String)
		errors.type = "Type is required"

	errors

@Fields = new Mongo.Collection "fields"