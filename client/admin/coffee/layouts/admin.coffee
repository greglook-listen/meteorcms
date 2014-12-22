Template.Admin.helpers
	time: new moment().format('MMM D, YYYY')

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