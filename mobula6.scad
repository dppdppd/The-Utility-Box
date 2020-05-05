include <the_utility_box_lib.scad>;

lid_type = "snap-on" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]
lid_feature = "rubber-band-windows" ; // [ "none", "window", "pattern", "dxf", "rubber-band-windows" ]

make_box = true;
make_lid = true;

interior_width = 83.0;
interior_depth = 83.0;
interior_height = 18.0;
lid_interior_height = 40.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

box_rubber_band_hooks = true;
lid_rubber_band_hooks = true;

box_rubber_band_windows = true;

band_hook_width = 9;

MakeAll();