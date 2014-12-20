checkLogin = () ->
	if ! Meteor.userId() then Router.go 'login' else @next()

Router.onBeforeAction checkLogin, { 
	except: ['home', 'login', 'page', 'page-type', 'post']
}

Router.configure
	layoutTemplate: 'Main'
	loadingTemplate: 'Loading'
	notFoundTemplate: 'NotFound'
	waitOn: ->
		Meteor.subscribe 'pages'

Router.map ->

# ---- PUBLIC ROUTES ---- #

	@route 'Home',
		path: '/'
		name: 'home'

	@route 'Login',
		path: '/login'
		name: 'login'

# ---- ADMIN ROUTES ---- #
	
	@route 'Dashboard',
		path: 'admin'
		name: 'dashboard'
		layoutTemplate: 'Admin'

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
			data = Pages.findOne(url: @params.url)
		waitOn: ->
			Meteor.subscribe 'pages'
			Meteor.subscribe 'posts'
		action: ->
			if @ready()
				if @data() then @render() else Router.go 'home'

	@route 'Post',
		path: '/:type/:url'
		name: 'post'
		data: ->
			Posts.findOne(type: @params.type, url: @params.url)
		waitOn: ->
			Meteor.subscribe 'posts'
		action: ->
			if @ready()
				if @data()
					# this is used with the fixture data
					if @data().type == 'example'
						@render('Example')
					else
						@render()

				else
					Router.go 'home'