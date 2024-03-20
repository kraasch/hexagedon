extends VBoxContainer

@export var val : float = -1.0

func _ready():
	%Slider.value_changed.connect(self.slider_updated)
	slider_updated(null)

func slider_updated(dummy):
	var value : float = %Slider.value
	val = value
	%Num.text = str(value)

func set_data(new_title : String, min : int, max : int, default : int):
	%Slider.min_value = min
	%Slider.max_value = max
	%Slider.value = default
	%Label.text = new_title
