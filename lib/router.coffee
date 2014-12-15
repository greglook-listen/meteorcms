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

	@route 'Users',
		path: 'admin/users'
		name: 'users'
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

	@route 'AdminPost',
		path: 'admin/page/:type/:id'
		name: 'admin-post'
		layoutTemplate: 'Admin'
		data: ->
			Posts.findOne(type: @params.type, id: @params._id)
		waitOn: ->
			Meteor.subscribe 'posts'

# ---- PUBLIC ROUTES ---- #

	@route 'PageType',
		path: '/:url'
		name: 'page-type'
		data: ->
			Pages.findOne(url: @params.url)
		waitOn: ->
			Meteor.subscribe 'pages'
			Meteor.subscribe 'posts'

	@route 'Post',
		path: '/:type/:url'
		name: 'post'
		data: ->
			Posts.findOne(type: @params.type, url: @params.url)
		waitOn: ->
			Meteor.subscribe 'posts'