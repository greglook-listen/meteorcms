Meteor.publish 'customers', ->
	Customers.find(
		{
			owner: @userId
		}
		{
			sort: { createdAt: -1 }
		}
	)

Meteor.publish 'users', ->
	Users.find(
		{
			owner: @userId
		}
		{
			sort: { createdAt: -1 }
		}
	)

Meteor.publish 'posts', ->
	Posts.find(
		{

		}
		{
			sort: { createdAt: -1 }
		}
	)

Meteor.publish 'pages', ->
	Pages.find(
		{

		}
		{
			sort: { createdAt: -1 }
		}
	)