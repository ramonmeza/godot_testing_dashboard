class_name Map
extends TileMap


# properties
var rows: int
var columns: int


# functions
func load(path: String):
	# ensure the path exists
	var dir: Directory = Directory.new()
	if not dir.file_exists(path):
		push_error('Map.load(): file \'%s\' does not exist!' % path)
	
	# load the resource
	var file = load(path)
	
	self.rows = file.rows
	self.columns = file.columns
	
	# load tiles
	self.clear()
	for row in range(self.rows):
		for col in range(self.columns):
			var cell_value = file.cells[row][col]
			self.set_cell(col, row, cell_value)


func save(path: String):
	var data = MapResource.new()
	
	# save tiles
	var cells: Array = []
	for row in range(self.rows):
		cells.append([])
		for col in range(self.columns):
			cells[row].append(self.get_cell(col, row))
	data.cells = cells
	
	# save the data
	ResourceSaver.save(path, data) # warning-ignore:return_value_discarded
