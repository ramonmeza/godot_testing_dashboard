class_name TestExample
extends TestBase


# functions
func test_example_succeeded() -> Result:
	return Result.new()


func test_example_failed() -> Result:
	return Result.new(FAILED, 'Failed example')


func test_example_skipped() -> Result:
	return Result.new(ERR_SKIP, 'Skipped example')
