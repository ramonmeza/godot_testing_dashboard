class_name Runner
extends Node


# constants
const TEST_PREFIX: String = 'test_'


# properties
onready var tests: Array = get_children()
var report: Report


# functions
func _init():
	self.report = Report.new()


func execute() -> void:
	# remove previous report
	self.report.clear()
	
	# for each test (child node)
	for test in self.tests:
		
		# add the test
		self.report.add_test(test.name)
		
		# for each test case (functions prefixed with test_)
		for test_case in test.get_method_list():
			if test_case.name.begins_with(TEST_PREFIX):
				# run the test function
				var result: Result = test.call(test_case.name)
				result.test_name = test.name
				result.test_case_name = test_case.name
				
				# add the result to the report
				self.report.add_result(result)
