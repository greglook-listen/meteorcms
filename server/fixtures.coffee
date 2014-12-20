# This files creates fixture data on initial load

# To not have the fixture data (run the following inside project root):

# meteor mongo
# use meteor
# db.pages.remove()
# db.posts.remove()
# db.fields.remove()

# Delete this file or it will create the fixture data again

if Users.find().count() == 0
	user = {
		email: 'beans@fake.com'
		password: 'abcde123'
	}

	Accounts.createUser(user)

if Pages.find().count() == 0
	Pages.insert(
		{
			type: 'Example'
			url: 'example'
			activated: true
			createdAt: new Date()
			updatedAt: new Date()
			deletedAt: null
			author: null
		}
	)

if Fields.find().count() == 0
	Fields.insert(
		{
			name: 'Example Field'
			type: 'String'
			pageType: 'example'
			slug: 'examplefield'
			createdAt: new Date()
			updatedAt: new Date()
			deletedAt: null
			author: null
		}
	)

	Fields.insert(
		{
			name: 'Example Repeater'
			type: 'Repeater'
			pageType: 'example'
			slug: 'examplerepeater'
			createdAt: new Date()
			updatedAt: new Date()
			deletedAt: null
			author: null
		}
	)

if Posts.find().count() == 0
	Posts.insert(
		{
			title: 'Example Post'
			content: 'This is the content of the post'
			type: 'example'
			url: 'example-post'
			activated: true
			fields: {
				examplefield: {
					type: 'String'
					value: 'Example Field Content'
				}
				examplerepeater: {
					type: 'Repeater'
					value: [
						{
							value: 'Repeater Field 1'
						}
						{
							value: 'Repeater Field 2'
						}
					]
				}
			}
			createdAt: new Date()
			updatedAt: new Date()
			deletedAt: null
			author: null
		}
	)