extends Node

# TODO: make the display (HEX_GRID etc) ask the MatchOrchestrator if user can 
# click/hover on tiles (ie block highlight if player is not active).

# TODO: make AttackManager ask MatchOrchestrator is player is active, before
# allowing to execute the attack.

var group_grid : Array = []
var group_data : Dictionary = {}
var group_num  : int = -1

# player id 1-N (one-indexed) of player who is currently active.
var active_player = -1

# player id 1-N (one indexed) of player who is human.
var human_player_id = -1
# TODO: in future have an Array of players and if they are HUMAN/COMPUTER.
#  - or maybe even NETWORKED, for network players.
#  - for COMPUTER players, hold a value here representing the DIFFICULTY category, used in the ComputerPlayer class.

# TODO: implement.
func match_continues():
	return true

# TODO: implement; ask ComputerPlayer.
func active_player_has_attack():
	return true

# TODO: implement.
func let_active_player_attack():
	if active_player != human_player_id:
		pass # TODO: ask computer for turn.
	else:
		pass # TODO: wait for human input.

func next_active_player():
	# increment active player
	var actual_id = active_player - 1 # make zero-indexed.
	var new_id = actual_id + 1 % group_num
	active_player = new_id + 1 # make one-indexed.

func main_game_loop():
	while match_continues():
		while active_player_has_attack():
			let_active_player_attack()
		next_active_player()

func start_new_match():
	group_grid = MapGenerator.group_grid
	group_data = MapGenerator.group_data
	group_num  = MapGenerator.groups_num

	# TODO: pick active player with random value.
	active_player = 1
	human_player_id = 1

	AttackManager.start_new_match() # TODO: make this AttackManager single source of truth instead.

	# TODO: start main_game_loop.
	# main_game_loop()
