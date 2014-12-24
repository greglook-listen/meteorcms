# Meteor.startup: ->
	# code to run on server at startup

# use this to create an initial user to login; developer: true shows additional things in admin like revisions and fields
if Users.find().count() == 0
	user = {
		email: 'beans@fake.com'
		password: 'abcde123'
		profile: {
			developer: true
		}
	}

	Accounts.createUser(user)

	console.log "User created: ", user

# don't delete this unless you don't want your app's homepage to work
if Pages.find().count() == 0
	home = {
		type: 'This is the title of the home page'
		url: 'home'
		content: '<p>Bacon ipsum dolor amet bresaola frankfurter sirloin pork chop cow, corned beef spare ribs filet mignon drumstick brisket t-bone leberkas tail kevin bacon. Tenderloin pork turducken beef rump andouille. Shank sirloin turducken landjaeger filet mignon, picanha rump prosciutto drumstick t-bone fatback pastrami pork loin pork belly. Ribeye tri-tip bacon tenderloin, t-bone kevin landjaeger. Doner venison cow ham hock beef jowl, ham short ribs tail. Corned beef biltong prosciutto, cow ground round doner shank beef filet mignon tail bacon pork chop short ribs kielbasa.</p><p>Porchetta drumstick spare ribs cow tongue corned beef, sausage tail ham hock ground round. Landjaeger turducken pork, porchetta frankfurter corned beef venison biltong brisket pastrami swine. Chuck pancetta filet mignon bacon pork. Tongue bresaola jowl porchetta hamburger andouille fatback. Doner ham ribeye rump salami pig jowl sausage picanha tenderloin andouille cow sirloin. Ribeye tenderloin hamburger boudin ham. Filet mignon andouille biltong meatball spare ribs.</p><p>Chicken turkey pork belly porchetta venison, tail andouille sausage ribeye bresaola. Pork loin bresaola cow, beef pancetta sirloin beef ribs ground round hamburger biltong sausage pastrami rump short ribs. Pork prosciutto picanha cow. Kielbasa short ribs capicola, pancetta brisket strip steak prosciutto beef ribs jerky. Ball tip shankle doner, jerky frankfurter flank chuck rump sirloin short loin venison picanha filet mignon meatloaf. Prosciutto ground round alcatra, tail bresaola tri-tip salami tenderloin pork chop biltong kevin jowl sirloin.</p>'
		activated: true
		fields: {
			examplefieldforhome: {
				type: 'String'
				value: 'Example Field Content For Home'
			}
		}
		createdAt: new Date()
		updatedAt: new Date()
		deletedAt: null
		author: null
		home: true
	}

	Pages.insert(home)

	console.log "Home page created: ", home.type