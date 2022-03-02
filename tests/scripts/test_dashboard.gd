class_name TestDashboard
extends Control

# constants
const ICONS: Dictionary = {
	ERR_SKIP: preload("res://data/textures/icons/warning.png"),
	FAILED: preload("res://data/textures/icons/cross.png"),
	OK: preload("res://data/textures/icons/checkmark.png")
}


const ICONS_COLORS: Dictionary = {
	ERR_SKIP: Color(255, 255, 0),
	FAILED: Color(255, 0, 0),
	OK: Color(0, 255, 0)
}


# properties
onready var tests_list: ItemList = $TestsList
onready var runner: Runner = $Runner


# functions
func _ready():
	# run the test runner
	self.runner.execute()
	
	# read the report
	var report: Report = self.runner.report
	
	# populate tests list
	for test in report.tests:
		for result in report.tests[test]:
			# set label and icon
			var icon: StreamTexture = ICONS[result.status]
			var label: String = '%s: %s' % [test, result.test_case_name]
			if not result.message.empty():
				label += ': %s' % result.message
			
			# add the item
			self.tests_list.add_item(label, icon, false)
			
			# set icon color
			var icon_index: int = self.tests_list.get_item_count() - 1
			var icon_color: Color = ICONS_COLORS[result.status]
			self.tests_list.set_item_icon_modulate(icon_index, icon_color)
