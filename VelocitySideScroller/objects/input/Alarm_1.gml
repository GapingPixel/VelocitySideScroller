/// @description Stick Pressed
// You can write your code in this editor
// reset pressed and released states
for (var i=0; i<num_controllers; i++)
{
    stick_left_pressed[i] = false;
    stick_right_pressed[i] = false;
    stick_up_pressed[i] = false;
    stick_down_pressed[i] = false;

    stick_left_released[i] = false;
    stick_right_released[i] = false;
    stick_up_released[i] = false;
    stick_down_released[i] = false;
}