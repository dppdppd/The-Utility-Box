include <the_utility_box_lib.scad>;

lid_type = "snap-on" ;// ["none", "one-piece", "snap-on"]
front_feature = "slit" ;// [ "none", "slit", "notch"]

make_box = true;
make_lid = true;

interior_width = 18.0;
interior_depth = 33.0;
interior_height = 60.0;
lid_interior_height = 5.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

rubber_band_hooks = true;
rubber_band_holes = false;

slit_height = 14;

 = 0;

MakeAll();
