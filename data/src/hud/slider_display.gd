extends VBoxContainer

@export var val : float = -1.0

func _ready():
	%Slider.value_changed.connect(self.slider_updated)
	slider_updated(null)

@warning_ignore("unused_parameter")
func slider_updated(dummy):
	var value : float = %Slider.value
	val = value
	%Num.text = str(value)

func set_data(new_title : String, min_val : int, max_val : int, default : int):
	%Slider.min_value = min_val
	%Slider.max_value = max_val
	%Slider.value = default
	%Label.text = new_title
