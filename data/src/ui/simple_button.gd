extends Button

func _on_pressed():
	SfxQueueManager.queue_effect(SfxQueueManager.BUTTON_CLICK)
