
dummy:
	@echo 'Please specify the exact rule to run ;)'

all:
	make win_all
	make web_all

win_all:
	make win_export
	make win_push
	make win_show

web_all:
	make web_export
	make web_push
	make web_show

win_export:
	rm -rf ./channels/win/
	mkdir -p ./channels/
	mkdir -p ./channels/win/
	cd ..; godot4 --headless --path . --export-release Win ./export/channels/win/hexagedon.exe

web_export:
	rm -rf ./channels/web/
	mkdir -p ./channels/
	mkdir -p ./channels/web/
	cd ..; godot4 --headless --path . --export-release Web ./export/channels/web/index.html

win_push:
	butler push ./channels/win/ kraasch/hexagedon:windows

web_push:
	butler push ./channels/web/ kraasch/hexagedon:html

web_show:
	xdg-open 'https://kraasch.itch.io/hexagedon'

