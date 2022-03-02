class_name TestMap
extends TestBase


# constants
const TEST_MAP_PATH = 'res://tests/data/test_map'
const TEST_MAP_ROWS: int = 6
const TEST_MAP_COLS: int = 8
const TEST_MAP = [
	[1, 0, 0, 1, 0, 0, 1, 1],
	[0, 1, 0, 0, 1, 1, 1, 0],
	[0, 1, 1, 0, 0, 0, 0, 1],
	[0, 1, 0, 1, 0, 1, 0, 1],
	[0, 1, 0, 1, 1, 0, 1, 1],
	[1, 0, 1, 0, 0, 1, 0, 0]
]


# functions
func test_load() -> Result:
	# create test map
	var map: Map = Map.new()
	
	# run load function
	var filename: String = '%s.tres' % TEST_MAP_PATH
	map.load(filename)
	
	if map.rows != TEST_MAP_ROWS:
		var msg: String = 'TestMap.test_load(): Expected rows to be %s, but received %s' % [TEST_MAP_ROWS, map.rows]
		return Result.new(FAILED, msg)
		
	if map.columns != TEST_MAP_COLS:
		var msg: String = 'TestMap.test_load(): Expected columns to be %s, but received %s' % [TEST_MAP_COLS, map.columns]
		return Result.new(FAILED, msg)
	
	# ensure loaded map cells match the expected map's cells
	for y in range(map.rows):
		for x in range(map.columns):
			var cell_value: int = map.get_cell(x, y)
			var expected_value: int = TEST_MAP[y][x]
			
			if cell_value != expected_value:
				var msg: String = 'TestMap.test_load(): Expected cell(%s, %s) to be %s, but received %s' % [x, y, expected_value, cell_value]
				return Result.new(FAILED, msg)
	
	# test succeeded
	return Result.new()


func test_save() -> Result:
	# create the test map
	var map: Map = Map.new()
	map.rows = TEST_MAP_ROWS
	map.columns = TEST_MAP_COLS
	
	for y in range(TEST_MAP_ROWS):
		for x in range(TEST_MAP_COLS):
			var cell_value = TEST_MAP[y][x]
			map.set_cell(x, y, cell_value)
	
	# get the temp file name
	var dir: Directory = Directory.new()
	var now = OS.get_datetime()
	var filename: String = '%s_%s-%s-%s_%s%s%s.tres' % [TEST_MAP_PATH, now.month, now.day, now.year, now.hour, now.minute, now.second]
	
	# ensure temp file doesn't already exist
	if dir.file_exists(filename):
		var msg: String = 'TestMap.test_save(): test map file \'%s\' already exists, delete it and rerun tests!' % TEST_MAP_PATH
		return Result.new(FAILED, msg)
	
	# run save function
	map.save(filename)
	
	# ensure map file exists
	if not dir.file_exists(filename):
		var msg: String = 'TestMap.test_save(): test map file \'%s\' was not saved!' % filename
		return Result.new(FAILED, msg)
	
	# delete temp file
	dir.remove(filename) # warning-ignore:return_value_discarded
	
	# test succeeded
	return Result.new()
