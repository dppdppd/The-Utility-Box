include <the_utility_box_lib.scad>;

lid_type = "one-piece" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]

lid_patterned = false;

lid_pattern_radius = 5.0;

make_box = true;
make_lid = true;

interior_width = 100.0;
interior_depth = 100.0;
interior_height = 50.0;
lid_interior_height = 20.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = false;
rubber_band_holes = false;

band_hook_width = 10;

slit_height = 14;

MakeAll();
