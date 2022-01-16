extends Node


# Initiialize Global variables

var level = 1
var first_level = true
var final_level = false
var hp = 100
var score = 0
var highscore = 0
var level_ended = false
var new_highscore = false

var player_position = Vector2.ZERO

var game_paused = false

var item_shoot_faster_acquired = false
var item_health_acquired = false

var boss_level = false
var boss1_hp = 300
var boss1_hp_visible = false
var boss1_super_mode = false
var boss_dead = false
var boss_explosion_finished = false

var boss_music_playing = false
var new_music_started = true

var in_main_menu = true
var level1_complete = false
var level2_complete = false
var level3_complete = false
var highscore_loaded = false

var ui_button_selected = false
