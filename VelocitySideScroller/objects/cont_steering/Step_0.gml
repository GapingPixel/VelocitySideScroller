/// @description  Make average XY locations

// Scan count grid as nothing necessary for empty cells
for(i=0; i < grid_width; i++) { //Go along the grid
    for(j=0; j < grid_height; j++) { //Go down the grid
        if(sb_grid_count[#i,j] > 0) { //If there is something in the grid
            //Divide Total X and Y values by the number of entities
            //Finds average XY location of all entities in a given cell
            sb_grid_center_x[#i,j] /= sb_grid_count[#i,j];
            sb_grid_center_y[#i,j] /= sb_grid_count[#i,j];
            
                            //Draw Grid (duplicated from draw event). Just used for testing
                            draw_set_colour(c_white);
                            draw_set_halign(fa_left);
                            draw_set_valign(fa_top);
                            draw_set_font(-1);
                            for(i=0; i < grid_width; i++) {
                                for(j=0; j < grid_height; j++) {
                                    //if(sb_grid_count[#i,j] > 0) {
                                        draw_text((i*sb_cell_size)+16,(j*sb_cell_size)+16,string_hash_to_newline(string(sb_grid_count[#i,j])));
                                    //}
                                }
                            }
                            //End of grid draw testing, can be removed for anything final.
        }
    }
}

