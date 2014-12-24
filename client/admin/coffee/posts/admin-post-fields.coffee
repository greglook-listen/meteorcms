Template.AdminPostFields.helpers()

Template.AdminPostFields.events
	'click .add-field': (event) ->
		$(event.target).parent().find('.repeater-fields').append('<div class="repeater-field appended"><input type="text"/><span class="repeater-remove"><i class="glyphicon glyphicon-remove"></i></span>')

	'click .repeater-remove': (event) ->
		$(event.target).parents('.repeater-field').remove()