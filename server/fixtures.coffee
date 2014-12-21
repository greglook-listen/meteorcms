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

	console.log "User created: ", user

	Accounts.createUser(user)

if Pages.find().count() == 0
	page = {
		type: 'Example'
		url: 'example'
		activated: true
		fields: {
			examplefieldforpage: {
				type: 'String'
				value: 'Example Field Content For Page'
			}
		}
		createdAt: new Date()
		updatedAt: new Date()
		deletedAt: null
		author: null
	}

	Pages.insert(page)

	console.log "Page example created: ", page.type

if Fields.find().count() == 0
	string = {
		name: 'Example Field'
		type: 'String'
		pageType: 'example'
		slug: 'examplefield'
		location: 'post'
		createdAt: new Date()
		updatedAt: new Date()
		deletedAt: null
		author: null
	}

	Fields.insert(string)

	pageString = {
		name: 'Example Field For Page'
		type: 'String'
		pageType: 'example'
		slug: 'examplefieldforpage'
		location: 'page'
		createdAt: new Date()
		updatedAt: new Date()
		deletedAt: null
		author: null
	}

	Fields.insert(pageString)

	repeater = {
		name: 'Example Repeater'
		type: 'Repeater'
		pageType: 'example'
		slug: 'examplerepeater'
		location: 'post'
		createdAt: new Date()
		updatedAt: new Date()
		deletedAt: null
		author: null
	}

	Fields.insert(repeater)

	console.log "String field example created: ", string.name
	console.log "String field for page example created: ", pageString.name
	console.log "Repeater field example created: ", repeater.name

if Posts.find().count() == 0
	post = {
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

	Posts.insert(post)

	console.log "Post example created: ", post.title