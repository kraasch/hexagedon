@tool
extends Node

# Never changing globals.
const HEX_RATIO : float = cos(deg_to_rad(30))
const EDGE_SIZE          : float = 1.0

# Change these values to alter the graphics.
var MAX_STACK_HEIGHT   : int = 0
var MAX_NUM_OF_PARTIES : int = 6
var MAX_GRID_SIZE      : int = 10
var CUBE_SIZE          : float = 0.15
