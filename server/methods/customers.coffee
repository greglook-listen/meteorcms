Meteor.methods
	
	createCustomer: (customer) -> # customer = { firstName, lastName, phoneNumber }
		
		# validate data and other stuff
		result = parseCustomer(customer)

		if result.validated
			Customers.insert(
				{
					firstName: customer.firstName
					lastName: customer.lastName
					phoneNumber: customer.phoneNumber
					createdAt: new Date()
					updatedAt: new Date()
					owner: Meteor.userId()
				}
			)

			result.success = true
			result.message = "Successfully created customer"

		return result
	
	updateCustomer: (customer) -> # customer = { id, firstName, lastName, phoneNumber }
		
		# validate data and other stuff
		result = parseCustomer(customer)

		if result.validated
			Customers.update(
				{ _id: customer.id }
				{
					$set: {
						firstName: customer.firstName
						lastName: customer.lastName
						phoneNumber: customer.phoneNumber
						updatedAt: new Date()
					}
				}
			)

			result.success = true
			result.message = "Successfully updated customer"

		return result

	deleteCustomer: (id) ->
		if !Meteor.userId()
			return {
				success: false
				message: "not-authorized"
			}
		
		Customers.remove(id)



# this handles all the validation stuff

# validate logged in user
# validate data

@parseCustomer = (customer) ->
	result = {}
	result.success = false
	result.validated = false

	if !Meteor.userId()
		result.message = "not-authorized"
		return result
		
	errors = validateCustomer(customer)
	
	if (errors.firstName || errors.lastName || errors.phoneNumber)
		result.message = "Validation Error"
		return result

	result.validated = true

	return result