/// @desc draw_set_text (color,font,halign,valign)
/// @arg color
/// @arg font
/// @arg halign
/// @arg valign
function draw_set_text( _color, _font, _haling, _valign) {

	// Allows one line setup of major text drawing vars
	// Requiring all four prevents silly coders from forgetting one
	// And therefore creating a dumb dependency on other event calls.
	// (Then wondering why their text changes later in development.)

	draw_set_color(_color);
	draw_set_font(_font);
	draw_set_halign(_haling);
	draw_set_valign(_valign);


}
