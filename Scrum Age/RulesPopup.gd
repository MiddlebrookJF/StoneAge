extends Popup

var defaultText


func show_Rules():
	show()
	defaultText = $DisplayLabel.text

func close():
	hide()
	$DisplayLabel.text = defaultText



func show_PointsRules():
	$DisplayLabel.text = "Points\n" + "To earn points, you must place your team members, \n" + "or meeples, in the grid slots of each area to earn \n" + "a random number of points for that area. \n" + "Once you have earned enough points from the \n" + "previous areas, you may place meepls in new areas. \n" + "Once you have earned enough testing points, \n" + "you may spend them to collect Story Points."
