
/// @description  Draw grid (for testing)
/// @param for testing

draw_set_colour(c_white);
draw_set_alpha(0.1);

for(i=0; i < grid_width; i++) {
    draw_line(sb_cell_size*i,0,sb_cell_size*i,room_height);
}

for(i=0; i < grid_height; i++) {
    draw_line(0,sb_cell_size*i,room_width,sb_cell_size*i);
}

for(i=0; i < grid_width; i++) {
    for(j=0; j < grid_height; j++) {
        if(sb_grid_count[#i,j] > 0) {
            draw_text((i*sb_cell_size)+16,(j*sb_cell_size)+16,string_hash_to_newline(string(sb_grid_count[#i,j])));
        }
    }
}

draw_set_alpha(1); //reset since it was causing strangeness
