class_name Map
extends TileMap


# properties
export var rows: int
export var columns: int


# functions
func load(path: String):
	# ensure the path exists
	var dir: Directory = Directory.new()
	if not dir.file_exists(path):
		push_error('Map.load(): file \'%s\' does not exist!' % path)
	
	self.clear()
	
	# load the resource
	var data = load(path)
	
	self.rows = data.rows
	self.columns = data.columns
	
	# load tiles
	for y in range(self.rows):
		for x in range(self.columns):
			self.set_cell(x, y, data.cells[y][x])


func save(path: String):
	# save the resource
	var data = MapResource.new()
	
	data.rows = self.rows
	data.columns = self.columns
	
	# save tiles
	var cells: Array = []
	for y in range(self.rows):
		cells.append([])
		for x in range(self.columns):
			cells[y].append(self.get_cell(x, y))
	data.cells = cells
	
	# save the data
	ResourceSaver.save(path, data) # warning-ignore:return_value_discarded
