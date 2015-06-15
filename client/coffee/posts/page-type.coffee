Template.PageType.helpers
	posts: ->
		Posts.find(
			{
				type: @url
				activated: true
				deletedAt: null
			}
			{
				sort: { createdAt: -1 }
			}
		)

# 	banana: ->
# 		beans = Template.instance().beans.get()
# 		barn = Template.instance().barn.get()
# 		beans + ' ' + barn
		
# Template.PageType.events
# 	'click .fart': (event, template) ->
# 		template.beans.set 'green'

Template.PageExample.helpers
	posts: ->
		Posts.find(
			{
				type: @url
				activated: true
				deletedAt: null
			}
			{
				sort: { createdAt: -1 }
			}
		)

# Template.PageType.created = () ->
# 	@beans = new ReactiveVar
# 	@beans.set 'yellow'
# 	@barn = new ReactiveVar
# 	@barn.set 'blue'