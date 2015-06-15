# This files creates fixture data on initial load

# To not have the fixture data (run the following inside project root):

# meteor mongo
# use meteor
# db.pages.remove()
# db.posts.remove()
# db.fields.remove()

# Delete this file or it will create the fixture data again

# if Pages.find().count() == 1
# 	page = {
# 		type: 'This is an example page'
# 		url: 'example'
# 		content: '<p>Bacon ipsum dolor amet bresaola frankfurter sirloin pork chop cow, corned beef spare ribs filet mignon drumstick brisket t-bone leberkas tail kevin bacon. Tenderloin pork turducken beef rump andouille. Shank sirloin turducken landjaeger filet mignon, picanha rump prosciutto drumstick t-bone fatback pastrami pork loin pork belly. Ribeye tri-tip bacon tenderloin, t-bone kevin landjaeger. Doner venison cow ham hock beef jowl, ham short ribs tail. Corned beef biltong prosciutto, cow ground round doner shank beef filet mignon tail bacon pork chop short ribs kielbasa.</p><p>Porchetta drumstick spare ribs cow tongue corned beef, sausage tail ham hock ground round. Landjaeger turducken pork, porchetta frankfurter corned beef venison biltong brisket pastrami swine. Chuck pancetta filet mignon bacon pork. Tongue bresaola jowl porchetta hamburger andouille fatback. Doner ham ribeye rump salami pig jowl sausage picanha tenderloin andouille cow sirloin. Ribeye tenderloin hamburger boudin ham. Filet mignon andouille biltong meatball spare ribs.</p><p>Chicken turkey pork belly porchetta venison, tail andouille sausage ribeye bresaola. Pork loin bresaola cow, beef pancetta sirloin beef ribs ground round hamburger biltong sausage pastrami rump short ribs. Pork prosciutto picanha cow. Kielbasa short ribs capicola, pancetta brisket strip steak prosciutto beef ribs jerky. Ball tip shankle doner, jerky frankfurter flank chuck rump sirloin short loin venison picanha filet mignon meatloaf. Prosciutto ground round alcatra, tail bresaola tri-tip salami tenderloin pork chop biltong kevin jowl sirloin.</p>'
# 		activated: true
# 		fields: {
# 			examplefieldforpage: {
# 				type: 'String'
# 				value: 'Example Field Content For Page'
# 			}
# 		}
# 		createdAt: new Date()
# 		updatedAt: new Date()
# 		deletedAt: null
# 		author: null
# 	}

# 	Pages.insert(page)

# 	console.log "Page example created: ", page.type

# if Fields.find().count() == 0
# 	homeString = {
# 		name: 'Example Field For Home'
# 		type: 'String'
# 		pageType: 'home'
# 		slug: 'examplefieldforhome'
# 		location: 'page'
# 		createdAt: new Date()
# 		updatedAt: new Date()
# 		deletedAt: null
# 		author: null
# 	}

# 	Fields.insert(homeString)

# 	string = {
# 		name: 'Example Field'
# 		type: 'String'
# 		pageType: 'example'
# 		slug: 'examplefield'
# 		location: 'post'
# 		createdAt: new Date()
# 		updatedAt: new Date()
# 		deletedAt: null
# 		author: null
# 	}

# 	Fields.insert(string)

# 	pageString = {
# 		name: 'Example Field For Page'
# 		type: 'String'
# 		pageType: 'example'
# 		slug: 'examplefieldforpage'
# 		location: 'page'
# 		createdAt: new Date()
# 		updatedAt: new Date()
# 		deletedAt: null
# 		author: null
# 	}

# 	Fields.insert(pageString)

# 	repeater = {
# 		name: 'Example Repeater'
# 		type: 'Repeater'
# 		pageType: 'example'
# 		slug: 'examplerepeater'
# 		location: 'post'
# 		createdAt: new Date()
# 		updatedAt: new Date()
# 		deletedAt: null
# 		author: null
# 	}

# 	Fields.insert(repeater)

# 	console.log "String field example created: ", string.name
# 	console.log "String field for page example created: ", pageString.name
# 	console.log "Repeater field example created: ", repeater.name

# if Posts.find().count() == 0
# 	post = {
# 		title: 'This is an example post'
# 		content: '<p>Bacon ipsum dolor amet bresaola frankfurter sirloin pork chop cow, corned beef spare ribs filet mignon drumstick brisket t-bone leberkas tail kevin bacon. Tenderloin pork turducken beef rump andouille. Shank sirloin turducken landjaeger filet mignon, picanha rump prosciutto drumstick t-bone fatback pastrami pork loin pork belly. Ribeye tri-tip bacon tenderloin, t-bone kevin landjaeger. Doner venison cow ham hock beef jowl, ham short ribs tail. Corned beef biltong prosciutto, cow ground round doner shank beef filet mignon tail bacon pork chop short ribs kielbasa.</p><p>Porchetta drumstick spare ribs cow tongue corned beef, sausage tail ham hock ground round. Landjaeger turducken pork, porchetta frankfurter corned beef venison biltong brisket pastrami swine. Chuck pancetta filet mignon bacon pork. Tongue bresaola jowl porchetta hamburger andouille fatback. Doner ham ribeye rump salami pig jowl sausage picanha tenderloin andouille cow sirloin. Ribeye tenderloin hamburger boudin ham. Filet mignon andouille biltong meatball spare ribs.</p><p>Chicken turkey pork belly porchetta venison, tail andouille sausage ribeye bresaola. Pork loin bresaola cow, beef pancetta sirloin beef ribs ground round hamburger biltong sausage pastrami rump short ribs. Pork prosciutto picanha cow. Kielbasa short ribs capicola, pancetta brisket strip steak prosciutto beef ribs jerky. Ball tip shankle doner, jerky frankfurter flank chuck rump sirloin short loin venison picanha filet mignon meatloaf. Prosciutto ground round alcatra, tail bresaola tri-tip salami tenderloin pork chop biltong kevin jowl sirloin.</p>'
# 		type: 'example'
# 		url: 'example-post'
# 		activated: true
# 		fields: {
# 			examplefield: {
# 				type: 'String'
# 				value: 'Example Field Content'
# 			}
# 			examplerepeater: {
# 				type: 'Repeater'
# 				value: [
# 					{
# 						value: 'Repeater Field 1'
# 					}
# 					{
# 						value: 'Repeater Field 2'
# 					}
# 				]
# 			}
# 		}
# 		createdAt: new Date()
# 		updatedAt: new Date()
# 		deletedAt: null
# 		author: null
# 	}

# 	Posts.insert(post)

# 	console.log "Post example created: ", post.title