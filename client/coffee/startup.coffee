Meteor.startup ->
	Tracker.autorun ->
		console.log Users.find().fetch()
		console.log Customers.find().fetch()