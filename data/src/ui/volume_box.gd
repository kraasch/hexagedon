extends HBoxContainer

var bus_name : String = ''

func initialize(_bus_name : String, _text : String) -> void:
	bus_name = _bus_name
	%Label.text = _text
	read_initial_volume()
	%Slider.value_changed.connect(on_slider_changed)

func read_initial_volume() -> void:
	var initial_volume : float = AudioManager.get_volume(bus_name)
	%Slider.value = initial_volume

func on_slider_changed(value : float):
	if bus_name != '':
		AudioManager.set_volume(bus_name, value)
