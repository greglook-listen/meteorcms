UI.registerHelper 'renderField', (field) ->
	
	if field
		if field.type == 'HTML'
			Spacebars.SafeString field.value
		else
			field.value
	else
		console.log 'You have a reference to a custom field in this template that is undefined'