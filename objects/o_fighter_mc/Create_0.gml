/// @description Constructor & Initial Stats

// stats (so far)
fitr_hp = 100;
fitr_stammag = 50;
fitr_jmp = 40;
fitr_wght = 50;
fitr_accl = 2;
fitr_jmp_accl = 8;
fitr_dccl = 2;
fitr_dash = 50;

// movement
vel = [0, 0];
x_max_vel = 6;
y_max_vel = 6;

// state for finite state machine (FSM)
state = "normal";

// mini FSM for jumping
jumping = false;
falling = true;
// y_o set every time fighter collides in y-direction; in apply_movement()
y_o = y;
// for double-jump or air-dash; 0: none, 1: double-jump, 2: air-dash
air_ability = 2;
ability_used = false;

// input booleans
// single-pressed inputs (for  attacks & combos)
fitr_punch = false;
fitr_kick = false;
fitr_down = false;
fitr_up = false;
fitr_right = false;
fitr_left = false;
// held-down inputs (for movement)
fitr_down_held = false;
fitr_up_held = false;
fitr_right_held = false;
fitr_left_held = false;

