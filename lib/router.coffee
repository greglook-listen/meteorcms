checkLogin = () ->
	if ! Meteor.userId() then Router.go 'login' else @next()

Router.onBeforeAction checkLogin, { 
	except: ['home', 'login', 'page', 'page-type', 'post']
}

checkDeveloper = () ->
	if ! Meteor.user().profile.developer then Router.go 'dashboard' else @next()

Router.onBeforeAction checkDeveloper, { 
	only: ['admin-fields']
}

Router.configure
	layoutTemplate: 'Main'
	loadingTemplate: 'Loading'
	notFoundTemplate: 'NotFound'
	waitOn: ->
		Meteor.subscribe 'pages'
		Meteor.subscribe 'posts'

Router.map ->

# ---- PUBLIC ROUTES ---- #

	@route 'Home',
		path: '/'
		name: 'home'
		data: ->
			data = Pages.findOne(home: true)
		waitOn: ->
			Meteor.subscribe 'pages'
		action: ->
			if @ready()
				if @data() then @render() else Router.go 'NotFound'

	@route 'Login',
		path: '/login'
		name: 'login'

	@route 'Contact',
		path: '/contact-us'
		name: 'contact'

# ---- ADMIN ROUTES ---- #
	
	@route 'Dashboard',
		path: 'admin'
		name: 'dashboard'
		layoutTemplate: 'Admin'
		waitOn: ->
			Meteor.subscribe 'pages'
			Meteor.subscribe 'posts'
			Meteor.subscribe 'users'
			Meteor.subscribe 'fields'

	@route 'Register',
		path: 'admin/register'
		name: 'register'
		layoutTemplate: 'Admin'
		waitOn: ->
			Meteor.subscribe 'users'

	@route 'Customers',
		path: 'admin/customers'
		name: 'customers'
		layoutTemplate: 'Admin'
		waitOn: ->
			Meteor.subscribe 'customers'

	@route 'Customer',
		path: 'admin/customer/:_id'
		name: 'customer'
		layoutTemplate: 'Admin'
		data: ->
			Customers.findOne(_id: @params._id)
		waitOn: ->
			Meteor.subscribe 'customers'
		action: ->
			if @ready()
				if @data() then @render() else Router.go 'dashboard'

	@route 'AdminFields',
		path: 'admin/fields'
		name: 'admin-fields'
		layoutTemplate: 'Admin'
		waitOn: ->
			Meteor.subscribe 'fields'
			Meteor.subscribe 'pages'

	@route 'AdminPage',
		path: 'admin/page'
		name: 'admin-page'
		layoutTemplate: 'Admin'
		waitOn: ->
			Meteor.subscribe 'pages'

	@route 'AdminPageType',
		path: 'admin/page/:_id'
		name: 'admin-page-type'
		layoutTemplate: 'Admin'
		data: ->
			Pages.findOne(_id: @params._id)
			
		waitOn: ->
			Meteor.subscribe 'pages'
			Meteor.subscribe 'posts'
			Meteor.subscribe 'fields'
		action: ->
			if @ready()
				if @data() then @render() else Router.go 'dashboard'

	@route 'AdminPost',
		path: 'admin/page/:type/:_id'
		name: 'admin-post'
		layoutTemplate: 'Admin'
		data: ->
			Posts.findOne(_id: @params._id, type: @params.type)
		waitOn: ->
			Meteor.subscribe 'posts'
			Meteor.subscribe 'fields'
		action: ->
			if @ready()
				if @data() then @render() else Router.go 'dashboard'

# ---- PUBLIC ROUTES ---- #

	@route 'PageType',
		path: '/:url'
		name: 'page-type'
		data: ->
			if Meteor.userId()
				Pages.findOne(url: @params.url)
			else
				Pages.findOne(url: @params.url, activated: true)
		waitOn: ->
			Meteor.subscribe 'pages'
			Meteor.subscribe 'posts'
		action: ->
			if @ready()
				if @data()
					# this is used with the fixture data
					if @data().url == 'services'
						@render('PageServices')
					else
						@render()

				else
					Router.go 'home'

	@route 'Post',
		path: '/:type/:url'
		name: 'post'
		data: ->
			if Meteor.userId()
				Posts.findOne(type: @params.type, url: @params.url)
			else
				Posts.findOne(type: @params.type, url: @params.url, activated: true)
		waitOn: ->
			Meteor.subscribe 'posts'
		action: ->
			if @ready()
				if @data()
					# this is used with the fixture data
					if @data().type == 'example'
						@render('PostExample')
					else
						@render()

				else
					Router.go 'home'