include <the_utility_box_lib.scad>;

lid_type = "snap-on" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]

make_box = true;
make_lid = true;

interior_width = 83.0;
interior_depth = 83.0;
interior_height = 20.0;
lid_interior_height = 36.0;

wall_thickness = 1.5;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = true;
rubber_band_holes = true;

slit_height = 14;

 = 0;

MakeAll();