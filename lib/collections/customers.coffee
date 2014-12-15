@validateCustomer = (customer) ->
	errors = {}

	customer.phoneNumber = customer.phoneNumber.replace(/[^0-9]/, '')

	unless customer.firstName.length && Match.test(customer.firstName, String)
		errors.firstName = "First name is required"

	unless customer.lastName.length && Match.test(customer.lastName, String)
		errors.lastName = "Last name is required"

	if !(customer.phoneNumber.length == 10)
		errors.phoneNumber = "Phone numbers must be 10 digits."
	else if !Match.test(customer.phoneNumber, String)
		errors.phoneNumber = "Invalid format"
	else if Customers.findOne({ phoneNumber: customer.phoneNumber })
		errors.phoneNumber = "Phone Number Taken"

	errors

@Customers = new Mongo.Collection "customers"