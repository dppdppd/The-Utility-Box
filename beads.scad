include <the_utility_box_lib.scad>;

lid_type = "none" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]


make_box = true;
make_lid = true;

interior_width = 64.0;
interior_depth = 64.0;
interior_height = 20.0;
lid_interior_height = 3.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = 1;
rubber_band_holes = 1;

band_hook_width = 10;

slit_height = 14;

debug_closed_percent = 0;

MakeAll();
