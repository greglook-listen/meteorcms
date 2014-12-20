@formatUrl = (url) ->
	url.toString()
		.toLowerCase()
		.replace(/\s+/g, '-')
		.replace(/[^\w\-]+/g, '')
		.replace(/\-\-+/g, '-')
		.replace(/^-+/, '')
		.replace(/-+$/, '')

@formatSlug = (name) ->
	name.toString()
		.toLowerCase()
		.replace(/\s+/g, '')
		.replace(/[^\w\-]+/g, '')
		.replace(/^-+/, '')
		.replace(/-+$/, '')