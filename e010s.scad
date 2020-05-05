include <the_utility_box_lib.scad>;

lid_type = "snap-on" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]
lid_feature = "window" ; // [ "none", "window", "pattern", "dxf" ]

make_box = true;
make_lid = true;

interior_width = 86.0;
interior_depth = 86.0;
interior_height = 25.0;
lid_interior_height = 42.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

box_rubber_band_hooks = true;
box_rubber_band_windows = true;

slit_height = 14;

lid_window_size = 20.0;

lid_pattern_radius = 5.0;
lid_pattern_n1 = 100;
lid_pattern_n2 = 100;
lid_pattern_row_offset = 50;
lid_pattern_col_offset = 100;
lid_pattern_shape_thickness = 0.75;

MakeAll();