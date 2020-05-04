include <the_utility_box_lib.scad>;

lid_type = "one-piece" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]

make_box = true;
make_lid = true;

interior_width = 115.0;
interior_depth = 115.0;
interior_height = 37.0;
lid_interior_height = 37.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = true;
rubber_band_holes = true;

slit_height = 14;

MakeAll();