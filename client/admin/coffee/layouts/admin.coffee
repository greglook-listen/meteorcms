Template.Admin.helpers
	time: new moment().format('MMM D, YYYY')
	currentUserEmail: ->
		if Meteor.user()
			Meteor.user().emails[0].address
	typeOfError: ->
		Session.get 'typeOfError'

Template.Admin.events
	'click .logout': ->
		Meteor.logout (error) ->
			Router.go 'login'

		false

	'click .show-navigation': ->
		$('.left-navigation, .main-content').addClass('active')

	'click .hide-navigation': ->
		$('.left-navigation, .main-content').removeClass('active')

	'click .left-navigation ul li a': ->
		$('.left-navigation, .main-content').removeClass('active')


UI.registerHelper 'formatTime', (time) ->
	moment(time).format('MMM, D, YYYY')

UI.registerHelper 'truncateContent', (content) ->
	if content.length > 100
		content = content.substr(0, 100)
		content + '...'
	else
		content

UI.registerHelper 'formatPhone', (phone) ->
	if phone
		phone.replace(/(\d{3})(\d{3})(\d{4})/, "($1) $2-$3")