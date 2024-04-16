
dummy:
	@echo 'Please specify the exact rule to run ;)'

##################################################
# all.
##################################################

all:
	make lin_debug
	#make lin_release
	#make win_release
	#make web_release

##################################################
# full rules.
##################################################

lin_debug:
	make lin_debug_export

lin_release:
	make lin_release_export
	make lin_release_push

win_release:
	make win_release_export
	make win_release_push

web_release:
	make web_release_export
	make web_release_push
	make web_release_show

##################################################
# export.
##################################################

lin_debug_export:
	rm -rf ./channels/lin_debug/
	mkdir -p ./channels/
	mkdir -p ./channels/lin_debug/
	cd ..; godot4 --headless --path . --export-debug Lin ./export/channels/lin_debug/hexagedon.x86_64

lin_release_export:
	rm -rf ./channels/lin/
	mkdir -p ./channels/
	mkdir -p ./channels/lin/
	cd ..; godot4 --headless --path . --export-release Lin ./export/channels/lin/hexagedon.x86_64

win_release_export:
	rm -rf ./channels/win/
	mkdir -p ./channels/
	mkdir -p ./channels/win/
	cd ..; godot4 --headless --path . --export-release Win ./export/channels/win/hexagedon.exe

web_release_export:
	rm -rf ./channels/web/
	mkdir -p ./channels/
	mkdir -p ./channels/web/
	cd ..; godot4 --headless --path . --export-release Web ./export/channels/web/index.html

##################################################
# push.
##################################################

lin_release_push:
	butler push ./channels/lin/ kraasch/hexagedon:linux

win_release_push:
	butler push ./channels/win/ kraasch/hexagedon:windows

web_release_push:
	butler push ./channels/web/ kraasch/hexagedon:html

##################################################
# show.
##################################################

web_release_show:
	xdg-open 'https://kraasch.itch.io/hexagedon'

