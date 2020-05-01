include <the_utility_box_lib.scad>;

hinge_type = "snap-on" ;// ["none", "one-piece", "snap-on"]
front_feature = "slit" ;// [ "none", "slit", "notch"]

make_box = true;
make_lid = true;

interior_width = 30.0;
interior_depth = 60.0;
interior_height = 40.0;
lid_interior_height = 20.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = true;
rubber_band_holes = true;

band_hook_width = 20;

slit_height = 5;

debug_closed_percent = 0;

MakeAll();
