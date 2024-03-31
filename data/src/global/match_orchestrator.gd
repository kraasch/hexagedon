extends Node

var rng = RandomNumberGenerator.new()

# TODO: make the display (HEX_GRID etc) ask the MatchOrchestrator if user can 
# click/hover on tiles (ie block highlight if player is not active).

# TODO: make AttackManager ask MatchOrchestrator is player is active, before
# allowing to execute the attack.

var group_grid      : Array      = []
var group_data      : Dictionary = {}
var num_of_players  : int        = -1

const PLAYER_TYPE_LOCAL    : int = 0
const PLAYER_TYPE_REMOTE   : int = 1
const PLAYER_TYPE_COMPUTER : int = 2

# player id 1-N (one indexed) of active player.
var active_player_index : int   = -1
var player_types        : Array = []

# TODO: implement.
func continue_main_game_loop() -> void:
	if match_continues():
		if active_player_has_attack():
			pass
#			let_active_player_attack()
#		next_active_player()

func match_continues():
	return num_of_players != 1

# TODO: implement; ask for ComputerPlayers.
func active_player_has_attack():
	return MapGenerator.player_has_draw(active_player_index)

# TODO: implement.
func let_active_player_attack():
	if player_types[active_player_index] == PLAYER_TYPE_LOCAL:
		pass # TODO: ask computer for turn.
	else:
		pass # TODO: wait for human input.

func next_active_player():
	# increment active player index.
	active_player_index = (active_player_index + 1) % num_of_players

func start_new_match():
	# get game grid data.
	group_grid     = MapGenerator.group_grid
	group_data     = MapGenerator.group_data
	num_of_players = MapGenerator.number_of_players()

	# setup new match based on game grid data.
	for i in range(num_of_players):
		player_types.push_back(PLAYER_TYPE_LOCAL)
	active_player_index = rng.randi_range(0, num_of_players - 1)

	# start the initial setup of the AttackManager.
	AttackManager.start_new_match() # TODO: make this AttackManager single source of truth instead.

	# start the main game loop.
	continue_main_game_loop()
