include <the_utility_box_lib.scad>;

lid_type = "snap-on" ;// ["none", "one-piece", "snap-on"]
front_feature = "slit" ;// [ "none", "slit", "notch"]
lid_feature = "text" ; // [ "none", "window", "pattern", "dxf", "rubber-band-windows", "text" ]

make_box = true;
make_lid = true;

interior_width = 13.0;
interior_depth = 28.0;
interior_height = 54.0;
lid_interior_height = 14.0;

wall_thickness = 1.5;

lip_height = 3.0;

tolerance = 0.1;

box_rubber_band_hooks = true;
lid_rubber_band_hooks = true;

box_rubber_band_windows = false;

slit_height = 14;

band_hook_width = 6;

////////////////// additional parameters

lid_window_size = 20.0;

lid_pattern_radius = 5.0;
lid_pattern_n1 = 100;
lid_pattern_n2 = 100;
lid_pattern_angle = 30;
lid_pattern_row_offset = 50;
lid_pattern_col_offset = 100;
lid_pattern_shape_thickness = 0.75;

dxf_path = "dxf/logo.dxf";
dxf_scale = 0.8;
dxf_depth = 0.5;

label_text = "LiHV 300";
label_font = "Avenir Next:style=Bold";
label_size = 0;
label_spacing = 1;
label_width_percent = 70;
label_thickness = 0.7;



MakeAll();