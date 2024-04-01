extends Node

var rng = RandomNumberGenerator.new()

# TODO: make the display (HEX_GRID etc) ask the MatchOrchestrator if user can 
# click/hover on tiles (ie block highlight if player is not active).

# TODO: make AttackManager ask MatchOrchestrator is player is active, before
# allowing to execute the attack.

signal active_player_changed

var group_grid      : Array      = []
var group_data      : Dictionary = {}
var num_of_players  : int        = -1

const PLAYER_TYPE_LOCAL    : int = 0
const PLAYER_TYPE_COMPUTER : int = 1
const PLAYER_TYPE_REMOTE   : int = 2 # TODO: implement.

# player id 1-N (one indexed) of active player.
var active_player_index : int   = -1 # TODO: rename to NUM instead of INDEX.
var player_types        : Array = []

func current_player_is_local() -> bool:
	return player_has_type_one_of(active_player_index, [PLAYER_TYPE_LOCAL])

# TODO: implement later.
func load_gameover_screen():
	print('game is over') # TODO: remove later.
	pass

func player_has_type_one_of(index : int, types : Array) -> bool:
	var has_type : bool = false
	for i in range(len(types)):
		var type : int = types[i]
		if player_types[index] == type:
			has_type = true
			break
	return has_type

func handle_local_player() -> void:
		if not active_player_has_attack():
			pass
		else:
			pass # NOTE: let active player attack over GUI.
			# TODO: in future multiplayer start a countdown here, which limits human player time.

# TODO: implement later, use global class ComputerPlayer.
func handle_computer_player() -> void:
	pass

# TODO: implement.
func continue_main_game_loop() -> void:
	if match_continues():
		if current_player_is_local():
			handle_local_player()
		if player_has_type_one_of(active_player_index, [PLAYER_TYPE_COMPUTER]):
			handle_computer_player()
		else:
			pass
		# TODO: else case to handle remote player.
	else:
		load_gameover_screen()

func match_continues():
	return num_of_players != 1

# TODO: implement; ask for ComputerPlayers.
func active_player_has_attack():
	return MapGenerator.player_has_draw(active_player_index)

func next_active_player():
	print('############################')
	print('next player!')
	print('  before: ' + str(active_player_index))
	# increment active player index.
	active_player_index = (active_player_index + 1) % num_of_players
	active_player_changed.emit()
	print('  after: ' + str(active_player_index))

func start_new_match():
	# get game grid data.
	group_grid     = MapGenerator.group_grid
	group_data     = MapGenerator.group_data
	num_of_players = MapGenerator.number_of_players()

	# setup new match based on game grid data.
	for i in range(num_of_players):
		player_types.push_back(PLAYER_TYPE_LOCAL)
	active_player_index = rng.randi_range(0, num_of_players - 1)
	active_player_index = 1 # TODO: remove later.
	print('random start: ' + str(active_player_index))

	# start the initial setup of the AttackManager.
	AttackManager.start_new_match() # TODO: make this AttackManager single source of truth instead.

	# start the main game loop.
	continue_main_game_loop()
