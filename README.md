
# Hexagedon Game

## Tasks

Basic:

 - [ ] essential tasks.
   - [ ] implement highlighting of active field group.
   - [ ] click on second field group executes attack.
   - [ ] implement click behavior (click on field activates respective field group).
   - [ ] draw borders around field groups.
   - [ ] every field is in exactly one field group.
   - [ ] a field group has several fields.
   - [ ] implement basic map generation.
 - [ ] write basic game
   - [ ] implement predefined camera perspectives.
   - [ ] implement free camera movement.
   - [ ] set UV map for hexagon meshes.
   - [ ] implement basic AI behavior.
 - [ ] implement user interface.
   - [ ] implement end-of-game screen.
   - [ ] implement splash screen.
   - [ ] implement start menu.
   - [ ] implement in-game menu.
   - [ ] implement map generator menu.
   - [ ] implement basic HUD.
 - [ ] make some fixes.
   - [ ] ERROR: Condition "!m" is true. Returning: 0 at: mesh_get_surface_count (servers/rendering/dummy/storage/mesh_storage.h:110)
   - [ ] ERROR: Error opening file 'res://icon.svg'. at: load_image (core/io/image_loader.cpp:90)

Extra tasks:

 - [ ] implement good map generation.
 - [ ] implement good splash screen shader (eg tron themed).
 - [ ] implement good in-game shaders (eg. tron themed).
 - [ ] implement multi-player.
 - [ ] implement more AI behavior.

Done:

 - [X] extract map generation and use a 2D array as the interface (filed with a number of the field group it belongs to).

## Resources

To do:

 - [ ] [My 1st Video + Quick way to make a Custom Hexagon Grid in Godot 3.x - Tutorial by Aarimous](https://www.youtube.com/watch?v=hmDavGzy1Hw)

Remarkable resources:

 - [X] A great interactive page on hexagons, more than I would ever want to read about hexagons, [Hexagonal Grids by Red Blob Games](https://www.redblobgames.com/grids/hexagons/).

Documentation:

 - [X] https://docs.godotengine.org/en/stable/classes/class_arraymesh.html
 - [X] https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/arraymesh.html
 - [X] https://docs.godotengine.org/en/stable/tutorials/shaders/your_first_shader/your_first_3d_shader.html#uniforms

Other:

 - [X] [How to make 3D Hexagonal maps in Godot NAD LABS](https://www.youtube.com/watch?v=mTvaSnzGRyw)
 - [X] [How to Make a 3D Hexagon Grid in Godot (Tutorial) by jmbiv](https://www.youtube.com/watch?v=3Lt2TfP8WEw).
  - [X] https://github.com/josephmbustamante/Godot-3D-Hex-Grid-Tutorial/blob/master/HexGrid.gd
 - [X] [Basics of MESH GENERATION in Godot 4 0 by Chevifier](https://www.youtube.com/watch?v=8wy_dH9RLI4).

