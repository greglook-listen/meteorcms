UI.registerHelper 'renderField', (field) ->
	
	if field.type == 'HTML'
		Spacebars.SafeString field.value
	else
		field.value