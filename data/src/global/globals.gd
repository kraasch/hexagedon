@tool
extends Node

# Never changing globals.
const HEX_RATIO        : float = cos(deg_to_rad(30))
const EDGE_SIZE        : float = 1.0
const STACK_SPLIT_GAP  : float = 0.01
const HEX_TILE_GAP     : float = 0.005

# Change these values to alter the graphics.
var MAX_STACK_HEIGHT   : int = 8
var NUM_OF_PARTIES     : int = 6
var GRID_SIZE          : int = 4
var CUBE_SIZE          : float = 0.3
