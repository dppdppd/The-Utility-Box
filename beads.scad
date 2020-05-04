include <the_utility_box_lib.scad>;

lid_type = "none" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]
lid_patterned = false;

make_box = true;
make_lid = true;

interior_width = 64.0;
interior_depth = 64.0;
interior_height = 20.0;
lid_interior_height = 4.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = 0;
rubber_band_holes = 0;

band_hook_width = 10;

slit_height = 14;

lid_pattern_radius = 5.0;
lid_pattern_n1 = 100;
lid_pattern_n2 = 100;
lid_pattern_row_offset = 50;
lid_pattern_col_offset = 100;
lid_pattern_shape_thickness = 0.75;

MakeAll();
