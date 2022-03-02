class_name Result
extends Object


# properties
var test_name: String
var test_case_name: String
var status: int
var message: String


# functions
func _init(_status: int = OK, _message: String = '') -> void:
	self.test_name = 'Global'
	self.test_case_name = 'Unspecified'
	self.status = _status
	self.message = _message
