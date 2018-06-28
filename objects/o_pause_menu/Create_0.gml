draw_set_font(fnt_text);

global.pause		= true;
global.view_width	= camera_get_view_width(view_camera[0]);
global.view_height	= camera_get_view_height(view_camera[0]);

global.key_revert	= ord("X");
global.key_enter	= vk_enter;
global.key_left		= vk_left;
global.key_right	= vk_right;
global.key_up		= vk_up;
global.key_down		= vk_down;

display_set_gui_size(global.view_width, global.view_height);

enum menu_page {
	main,
	settings,
	audio,
	difficulty,
	graphics, 
	controls,
	height
}

enum element_type {
	script_runner,
	page_transfer,
	slider,
	shift,
	toggle,
	input
}

//CREATE MENU PAGES
ds_menu_main = create_menu_page(
	["RESUME",		element_type.script_runner,	resume_game], 
	["SETTINGS",	element_type.page_transfer,	menu_page.settings],
	["EXIT",		element_type.script_runner,	exit_game]
);

ds_settings = create_menu_page(
	["AUDIO",		element_type.page_transfer,	menu_page.audio],
	["DIFFICULTY",	element_type.page_transfer,	menu_page.difficulty], 
	["GRAPHICS",	element_type.page_transfer,	menu_page.graphics], 
	["CONTROLS",	element_type.page_transfer,	menu_page.controls], 
	["BACK",		element_type.page_transfer,	menu_page.main],
);

ds_menu_audio = create_menu_page(
	["MASTER",		element_type.slider,			change_volume,			1,		[0,1]],
	["SOUNDS",		element_type.slider,			change_volume,			1,		[0,1]],
	["MUSIC",		element_type.slider,			change_volume,			1,		[0,1]],
	["BACK",		element_type.page_transfer,	menu_page.settings],
);

ds_menu_difficulty = create_menu_page(
	["AI",		element_type.shift,			change_difficulty,		0,		["HARMLESS", "NORMIE", "HARDCORE"]],
	["BACK",		element_type.page_transfer,	menu_page.settings],
);

ds_menu_graphics = create_menu_page(
	["RESOLUTION",	element_type.shift,			change_resolution,		0,		["384 x 216", "768 x 432", "1152 x 648", "1536 x 874", "1920 x 1080"]],
	["WINDOW MODE",	element_type.toggle,			change_window_mode,		1,		["FULLSCREEN", "WINDOWED"]], 
	["BACK",		element_type.page_transfer,	menu_page.settings],
);

ds_menu_controls = create_menu_page(
	["UP",			element_type.input,			"key_up",				vk_up],
	["LEFT",		element_type.input,			"key_left",				vk_left],
	["RIGHT",		element_type.input,			"key_right",			vk_right],
	["DOWN",		element_type.input,			"key_down",				vk_down],
	["PUNCH",		element_type.input,			"key_punch",			ord("V")],
	["KICK",		element_type.input,			"key_kick",				ord("C")],
	
	["BACK",		element_type.page_transfer,	menu_page.settings],
);

page = 0;
menu_pages = [ds_menu_main, ds_settings, ds_menu_audio, ds_menu_difficulty, ds_menu_graphics, ds_menu_controls]

var i = 0, array_len = array_length_1d(menu_pages);
repeat(array_len){
	menu_option[i] = 0;
	i++;
}

inputting = false;