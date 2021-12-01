extends Popup

var defaultText


func show_Rules():
	show()
	defaultText = $DisplayLabel.text

func close():
	hide()
	$DisplayLabel.text = defaultText



func show_PointsRules():
	$DisplayLabel.text = "Points descriptions"


func show_ScrumpleRules():
	$DisplayLabel.text = "Scrumple descriptions"
	
func show_TurnsRules():
	$DisplayLabel.text = "Turns descriptions"
	
func show_ToolsRules():
	$DisplayLabel.text = "Tools descriptions"			
		
