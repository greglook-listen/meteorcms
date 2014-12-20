Template.AdminPostFields.helpers()

Template.AdminPostFields.events
	'click .add-field': (event) ->
		$(event.target).parent().find('.repeater-fields').append('<div class="repeater-field appended"><input type="text"/><span class="repeater-remove">x</span>')

	'click .repeater-remove': (event) ->
		$(event.target).parent().remove()