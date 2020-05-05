include <the_utility_box_lib.scad>;

lid_type = "one-piece" ;// ["none", "one-piece", "snap-on"]
front_feature = "notch" ;// [ "none", "slit", "notch"]
lid_feature = "dxf" ; // [ "none", "window", "pattern", "dxf", "rubber-band-windows" ]

make_box = true;
make_lid = true;

interior_width = 50.0;
interior_depth = 50.0;
interior_height = 20.0;
lid_interior_height = 20.0;

box_rubber_band_hooks = true;
lid_rubber_band_hooks = true;

box_rubber_band_windows = true;

////////////////// additional parameters

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

band_hook_width = 10;

slit_height = 14;

lid_window_size = 20.0;

lid_pattern_radius = 5.0;
lid_pattern_n1 = 8;
lid_pattern_n2 = 8;
lid_pattern_angle = 22.5;
lid_pattern_row_offset = 20;
lid_pattern_col_offset = 90;
lid_pattern_shape_thickness = 0.5;

dxf_path = "dxf/logo.dxf";
dxf_scale = 0.8;
dxf_depth = 0.5;

///////////////////

MakeAll();

/*
for screenshots

$vpr = [ 48.10, 0.00, 315.00 ];
$vpt = [ -18.11, 10.79, 64.81 ];
$vpd = 615.01;

 rotate( 180 )
     MakeAll( 0 );

translate( [50, 90,0] )
    rotate( 0 )
        MakeAll( 95 );
*/