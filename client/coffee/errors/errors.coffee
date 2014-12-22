@Errors = new Mongo.Collection(null)

@throwError = (message) ->
	Errors.insert {
		message: message
	}

Template.Errors.helpers
	errors: ->
		Errors.find()

Template.Error.rendered = () ->
	error = @data

	removeError = () ->
		Errors.remove error._id

	Meteor.setTimeout removeError, 2000