
# Hexagedon Game

Play [hexagedon](https://kraasch.itch.io/hexagedon) on itch.io.

## Tasks

Current:

 - [ ] basic: make overlay menu global.
 - [ ] basic: add leave application button to overlay menu.
 - [ ] basic: fix sound in the debug and release version.
 - [ ] basic: implement basic AI behavior.
 - [ ] basic: implement basic map generator.
 - [ ] basic: implement about entry to main screen.
 - [ ] basic: add go back button to map generation screen.
 - [ ] basic: fix other errors in the debug and release version.
 - [ ] basic: fix web export.
 - [ ] basic (design): add proper icon to windows export.
 - [ ] basic: fix sound bug, music seems faster every second time the end screen loads.

Next:

 - [ ] advanced: adapt map generation screen to map generation options.
 - [ ] advanced: implement a redistribution which calculates max num of connected regions.
 - [ ] advanced: draw borders around field groups (ie good looking field group borders).
 - [ ] advanced: implement good UI design.
 - [ ] advanced: implement good map generation.
 - [ ] advanced: implement good splash screen shader (eg tron themed).
 - [ ] advanced: implement good in-game shaders (eg tron themed).
 - [ ] advanced: ERROR: Condition "!m" is true. Returning: 0 at: mesh_get_surface_count (servers/rendering/dummy/storage/mesh_storage.h:110)
 - [ ] advanced: set UV map for hexagon meshes.
 - [ ] advanced: finalize predefined camera perspectives.

Later:

 - [ ] basic: remove all in-code TODOs, tasks and notes.
 - [ ] polish: UI design.
 - [ ] polish: all in-game shaders.
 - [ ] polish: intro and outro shaders.
 - [ ] polish: soundtrack.
 - [ ] polish: sound design.
 - [ ] polish: game AI.
 - [ ] polish: map generation.
 - [ ] polish: make settings persistent over multiple game starts.
 - [ ] maybe: implement multi-player offline.
 - [ ] maybe: implement multi-player online.
 - [ ] maybe: implement more AI behavior.
 - [ ] maybe: implement in-game menu.
 - [ ] maybe: export game for mobile.
 - [ ] maybe: implement a hex map on a sphere.

Done:

 - [X] basic: implement session review screen.
 - [X] basic: implement basic redistribution.
 - [X] basic: update color of tiles after attack.
 - [X] basic: add game object.
 - [X] basic: click on second field group executes attack.
 - [X] basic: implement in-game settings menu.
 - [X] basic: do basic sound design.
 - [X] basic: create basic soundtrack.
 - [X] basic: implement free camera movement.
 - [X] basic: implement end-of-game screen.
 - [X] basic: implement splash screen.
 - [X] basic: implement start menu.
 - [X] basic: implement map generator menu.
 - [X] basic: implement basic HUD.
 - [X] basic: ERROR: Error opening file 'res://icon.svg'. at: load_image (core/io/image_loader.cpp:90)
 - [X] basic: implement click behavior (click on field activates respective field group).
 - [X] basic: implement highlighting of active field group.
 - [X] basic: a field group has several fields.
 - [X] basic: every field is in exactly one field group.
 - [X] basic: extract map generation and use a 2D array as the interface (filed with a number of the field group it belongs to).

## Resources

To do:

 - [X] None.

Other remarkable resources:

 * A great interactive page on hexagons, more than I would ever want to read about hexagons, [Hexagonal Grids by Red Blob Games](https://www.redblobgames.com/grids/hexagons/).
 * A sound effect tool: [Chiptone by SFBGames](https://sfbgames.itch.io/chiptone).
 * Another SFXR web implementation in JavaScript: [JSFXR](https://sfxr.me/).
 * Another SFXR web implementation in Godot: [Godot SFXR](https://github.com/tomeyro/godot-sfxr).
 * How to wrap a sphere with hexagons: [short article by gamelogic.co.za](http://gamelogic.co.za/grids/features/examples-that-ship-with-grids/tiling-a-sphere-with-hexes/).

Documentation:

 - [X] https://docs.godotengine.org/en/stable/classes/class_arraymesh.html
 - [X] https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/arraymesh.html
 - [X] https://docs.godotengine.org/en/stable/tutorials/shaders/your_first_shader/your_first_3d_shader.html#uniforms
 - [X] https://docs.godotengine.org/en/stable/tutorials/rendering/viewports.html
 - [X] https://docs.godotengine.org/en/stable/classes/class_subviewport.html#class-subviewport

Other:

 - [X] [How to make 3D Hexagonal maps in Godot NAD LABS](https://www.youtube.com/watch?v=mTvaSnzGRyw).
 - [X] [How to Make a 3D Hexagon Grid in Godot (Tutorial) by jmbiv](https://www.youtube.com/watch?v=3Lt2TfP8WEw).
  - [X] https://github.com/josephmbustamante/Godot-3D-Hex-Grid-Tutorial/blob/master/HexGrid.gd
 - [X] [Basics of MESH GENERATION in Godot 4 0 by Chevifier](https://www.youtube.com/watch?v=8wy_dH9RLI4).
 - [X] [Free Camera Tutorial Godot by Apocalyptic Phospho](https://www.youtube.com/watch?v=QitqbSHEYas).

