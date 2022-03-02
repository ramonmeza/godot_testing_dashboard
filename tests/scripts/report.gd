class_name Report
extends Object


# properties
var status: int
var tests: Dictionary  # Dictionary[String, Array[Result]]


# functions
func _init() -> void:
	self.clear()


func clear() -> void:
	self.status = ERR_SKIP
	self.tests = {}


func add_test(name: String) -> void:
	if not self.tests.has(name):
		self.tests[name] = []
	else:
		push_error('Report.add_test() failed: test name \'%s\' already exists!' % name)


func add_result(result: Result) -> void:
	if self.tests.has(result.test_name):
		self.tests[result.test_name].append(result)
	else:
		push_error('Report.add_step() failed: test name \'%s\' does not exist!' % result.test_name)
