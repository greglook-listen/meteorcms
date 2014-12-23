Meteor.publish 'customers', ->
	if @userId
		Customers.find(
			{

			}
			{
				sort: { createdAt: -1 }
			}
		)

Meteor.publish 'users', ->
	if @userId
		Users.find(
			{

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

Meteor.publish 'fields', ->
	Fields.find(
		{

		}
		{
			sort: { createdAt: -1 }
		}
	)