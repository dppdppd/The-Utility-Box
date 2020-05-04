VERSION = "1.00";
COPYRIGHT_INFO = "\tThe Utility Box\n\thttps://github.com/IdoMagal/The-Utility-Box\n\n\tCopyright 2020 Ido Magal\n\tCreative Commons - Attribution - Non-Commercial - Share Alike.\n\thttps://creativecommons.org/licenses/by-nc-sa/4.0/legalcode";

///////////

lid_type = "snap-on" ;// ["none", "one-piece", "snap-on", "fit-under"]
front_feature = "notch" ;// [ "none", "slit", "notch"]

make_box = true;
make_lid = true;

interior_width = 97.0;
interior_depth = 112.0;
interior_height = 20.0;
lid_interior_height = 20.0;

wall_thickness = 2;

lip_height = 3.0;

tolerance = 0.1;

logo_front = false;
logo_top = false;
logo_path = "";
logo_scale = 0.8;

num_detents_per_side = 2;

rubber_band_hooks = true;
rubber_band_holes = true;

band_hook_width = 9;

slit_height = 14;

debug_closed_percent = 0;

////////////////////////////////////////////////////////////////////

$fn = $preview ? 12 : 100;
$fs = $preview ? 2 : 12;

box_depth = interior_depth + 2 * wall_thickness;
box_width = interior_width + 2 * wall_thickness;
box_height = interior_height + wall_thickness; 
lid_height = lid_interior_height + wall_thickness;

hinge_outer = 5.0;
finger_size = 7;

hinge_inner_tolerance = .4;
hinge_finger_tolerance = .3;
hinge_inner = hinge_outer/2;

flap_height = 5;
flap_width = 10;

finger_length = hinge_outer * .8; // 1.65

box_x = -box_width - finger_length;

// as a fraction of wall thickness
lip_thickness_fraction = 0.5; 

notch_width = interior_depth/2.0;
notch_height = 2.0;
notch_depth = wall_thickness/2.0;

debug_xray = false;
debug_xray_depth = 10;

band_hook_depth = wall_thickness * 2;
band_hook_height = wall_thickness;
band_hook_gap = 1;
band_hook_stem_delta = 2;

band_hole_spacing = band_hook_width/3;
band_hole_size = (band_hook_width - band_hole_spacing) / 2;

num_band_hooks_x = floor( interior_width / ( band_hook_width * 2 ));
num_band_hooks_y = floor( interior_depth / ( band_hook_width * 2 ));
num_band_hooks_z = floor( interior_height / ( band_hook_width * 2 ));
num_band_hooks_z_lid = floor( lid_interior_height / ( band_hook_width * 2 ));

slit_lid_portion = min( lid_interior_height, slit_height);
slit_box_portion = slit_height - slit_lid_portion;

lip_thickness = wall_thickness - ( wall_thickness * lip_thickness_fraction );
lip_thickness_inv = wall_thickness - lip_thickness;
lip_radius = lip_height;

angle = debug_closed_percent > 0 ? debug_closed_percent/100*(-180) : 0;

free_lid = lid_type != "snap-on" && lid_type != "one-piece";

vec_box_center = [ box_width/2, box_depth/2, 0];

////////////////////////////////////////////////
////////////////////////////////////////////////

module MakeAll()
{
    echo( str( "\n\n\n", COPYRIGHT_INFO, "\n\n\tVersion ", VERSION, "\n\n" ));

    if ( make_box )
        MoveToBoxPosition()
            XRay()
                MakeBox();

    if ( box_height != lid_height && lid_type == "one-piece" )
    {
        echo("<font color='red'>This will need base layer supports because the top and bottom are different
        heights and you have a hinge.</font>");
    }

    if ( make_lid )
        PreviewRotate()
            NoHingeTranslate()
                MoveToLidPosition()
                    XRay()
                        MakeLid();
}

module RotateAboutPoint(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}

module XRay()
{
    if ( debug_xray )
    {
        intersection()
        {
            translate([-500,0,-500])
                cube([1000, debug_xray_depth ,1000]);

            children();
        }
    }
    else 
        children();
}

module PreviewRotate()
{
    if ( $preview && angle != 0 ) 
    {
        RotateAboutPoint( [ 0, angle, 0 ], 0, [ 0, 0, box_height ] ) 
            children();
    }
    else
        children();
}

module NoHingeTranslate()
{
    if ( lid_type != "one-piece" && angle == 0 )
        translate([hinge_outer + 1, 0, lid_height - box_height ]) 
            children();
    else
        children();
}

module MoveToLidPosition()
{
    translate([finger_length, -box_depth/2, box_height - lid_height]) 
        children();
}

module MoveToBoxPosition()
{
    translate([box_x, -box_depth/2, 0]) 
        children();

}

module HingeDetent()
{
    resize( [ hinge_outer / 2, hinge_outer / 2, hinge_outer / 2 ])
        sphere( r = 1);
}

module SnapDetent( smaller = false )
{
    lip_detent_radius = lip_thickness - ( smaller ? tolerance : 0 ) ;

    translate( [ 0, -0.2, 0])
        sphere( r = lip_detent_radius );
    
}

module MakeBandHooks( h = 0, lid = false )
{
    module shape( )
    {
        cube( [ band_hook_width, band_hook_depth, band_hook_height]);
    }

    module BandHookNegative()
    {
       translate( [ -band_hook_width/2, 0, band_hook_height/2])
            difference()
            {
                translate( [-band_hook_gap, 0, -wall_thickness])
                    resize([ band_hook_width + 2*band_hook_gap, 0, band_hook_height + wall_thickness])
                       shape();

                translate( [0,-2*band_hook_gap,0])
                {
                    translate( [0, 0, -band_hook_gap])
                        shape();

                    translate( [ band_hook_stem_delta, 0, band_hook_height - band_hook_gap])
                        resize([ band_hook_width - 2*band_hook_stem_delta, 0, band_hook_gap])
                            shape();
                }
            }
    }

    margin_x = interior_width / ( num_band_hooks_x * band_hook_width) / 2;
    margin_y = interior_depth / ( num_band_hooks_y * band_hook_width) / 2;

    for  (i = [ 0: num_band_hooks_x - 1 ]) 
    {
        dist = interior_width * 1/(num_band_hooks_x);
        translate([ (i + 1) * dist - dist/2 + margin_x,  0 , h ])
            BandHookNegative();

        mirror( [0,1,0] )
            translate([ (i + 1) * dist - dist/2 + margin_x, -box_depth , h ])
                BandHookNegative();

    }

    for  (i = [ 0: num_band_hooks_y - 1 ]) 
    {
        dist = interior_depth / num_band_hooks_y;

        translate([ 0, (i + 1) * dist - dist/2 + margin_y, h ])
            rotate( -90)
            BandHookNegative();


            if ( lid && front_feature == "slit" )
            {
                mirror( [1,0,0] )
                    translate([ -box_width, (i + 1) * dist - dist/2 + margin_y, h ])
                        rotate( 180 )
                            rotate( -90, [0,1,0] )
                                rotate( -90 )
                                    BandHookNegative();
            }   
            else
            {
                mirror( [1,0,0] )
                    translate([ -box_width, (i + 1) * dist - dist/2 + margin_y, h ])
                        rotate( -90 )
                            BandHookNegative();
            }

            // this is an ugly hack but it connects the severed hook back to the lid.
  
                       

    }   
}

module MakeBandHoles( lid = false )
{
    module BandHoleNegative()
    {
       module MakeSmallHoles()
       {
           gap_between_holes = band_hook_width - 2*band_hole_size;
           translate( [ 0, 0, 0 ])
           {
             translate( [ 0, 0, 0 ])
                cube( [ band_hole_size, band_hole_size, band_hole_size], center = false);

            translate( [ gap_between_holes + band_hole_size, 0, 0 ])
                cube( [ band_hole_size, band_hole_size, band_hole_size], center = false);

            translate( [ 0, gap_between_holes + band_hole_size, 0 ])
                cube( [ band_hole_size, band_hole_size, band_hole_size], center = false);

            translate( [ gap_between_holes + band_hole_size, gap_between_holes + band_hole_size, 0 ])
                cube( [ band_hole_size, band_hole_size, band_hole_size], center = false);
                
           }
       }       

        translate( [ -band_hook_width/2, -band_hook_width/2, 0])
            MakeSmallHoles();

//        translate( [ -band_hook_width/2, -band_hook_width/2, band_hook_width * 2/3])
//            MakeSmallHoles();
        
    }

    nz = lid ? num_band_hooks_z_lid : num_band_hooks_z;
    h = lid ? lid_interior_height : interior_height;

    margin_x = interior_width / ( num_band_hooks_x * band_hook_width) / 2;
    margin_y = interior_depth / ( num_band_hooks_y * band_hook_width) / 2;
    margin_z = h / ( nz * band_hook_width) / 2;

    distx = interior_width / num_band_hooks_x;
    disty = interior_depth / num_band_hooks_y;
    distz = h / nz;

    module Grid( x, y )
    {
        if ( x > 0 && y > 0 )
            for  (i = [ 0: 1 : x - 1 ]) 
                for  (j = [ 0: 1: y - 1 ]) 
                {
                    translate([ (i + 1) * distx - distx/2 + margin_x,  (j + 1) * disty - disty/2 + margin_y, 0 ])
                            rotate( (i + j) * 90 )
                                BandHoleNegative();
                }
    }


    resize( [ 0, 0, lid ? lid_height : box_height] )
        Grid( num_band_hooks_x, num_band_hooks_y );

    // front
    resize( [ 0, box_depth, 0])
        translate( [ 0, band_hole_size,0])
            RotateAboutPoint( 90, [1,0,0], [ box_width/2, 0, 0 ])
                Grid( num_band_hooks_x, nz );

    // side
    resize( [ box_width, 0, 0])
        translate( [ band_hole_size, 0,0])
            RotateAboutPoint( -90, [0,1,0], [ 0, finger_length, 0 ])
                Grid( nz, num_band_hooks_y);

}

module MakeDetents( lid = false )
{
    module OneSideOfDetents( i )
    {
        module PlaceDetent( i )
        {
            translate([ box_width * i/( num_detents_per_side + 1 ),   -( - wall_thickness + lip_thickness ), 0 ]) 
                SnapDetent( lid );

                echo( i );
        }

        PlaceDetent( i );

        MirrorAboutPoint( [ 0, 1, 0], vec_box_center )
            PlaceDetent( i );
    }

    for ( i = [ 1: num_detents_per_side ])
    {
        OneSideOfDetents( i );

        if ( free_lid )
            RotateAboutPoint( 90, [0, 0, 1], vec_box_center)
                OneSideOfDetents( i );
    }
    

}  

module MakeBox() 
{
	union() 
    {
		// main box and cutout
		difference() 
        {

            union()
            {
                // main box
                    cube([ box_width, box_depth, box_height ]);

                if ( free_lid )
                {
                    // lip
                  translate( [ wall_thickness - notch_depth + tolerance, notch_depth + tolerance, lip_height])
                        cube( [ box_width - ( notch_depth + tolerance ) * 2, box_depth - ( notch_depth + tolerance ) * 2,box_height ]);
                }
                else
                {
                    // curved lip
                    translate( [ wall_thickness - notch_depth + tolerance, notch_depth + tolerance, lip_height])
                        hull()
                        {
                            vec3 = [ box_width - ( notch_depth + tolerance ) * 2, box_depth - ( notch_depth + tolerance ) * 2,box_height ];
                            h = vec3[1];
                            rotation_vec = [1,0,0];
                            radius = lip_radius;

                            translate( [ radius, 0, radius ])
                                rotate( -90, rotation_vec)
                                    cylinder(r=radius, h=h, center = false);

                            translate( [ vec3[0] - radius, 0, radius ])
                                rotate( -90, rotation_vec)
                                    cylinder(r=radius, h=h, center = false);

                            translate( [ radius, 0, vec3[2] - radius ])
                                rotate( -90, rotation_vec)
                                    cylinder(r=radius, h=h, center = false);

                            translate( [ vec3[0] - radius, 0,vec3[2] - radius ])
                                rotate( -90, rotation_vec)
                                    cylinder(r=radius, h=h, center = false);                
                        }
                }

            }

            // main cavity
            translate([ wall_thickness, wall_thickness, wall_thickness]) 
                cube([  interior_width, 
                        interior_depth, 
                        interior_height + lip_height + 5 ]);
			
            if ( front_feature == "notch" )
            {
			            // notch
                translate([0, box_depth/2 -notch_width/2, box_height - notch_height]) 
                    cube([notch_depth, notch_width, notch_height]);

                // if no hinge, make a notch on other side as well
                if ( free_lid )
                {
                    translate([ box_width - notch_depth, box_depth/2 -notch_width/2, box_height - notch_height]) 
                        cube([notch_depth, notch_width, notch_height]);

                RotateAboutPoint( 90, [0, 0, 1], vec_box_center )
                {
                    translate([0, box_depth/2 -notch_width/2, box_height - notch_height]) 
                        cube([notch_depth, notch_width, notch_height]);

                    translate([ box_width - notch_depth, box_depth/2 -notch_width/2, box_height - notch_height]) 
                        cube([notch_depth, notch_width, notch_height]);
                }

                }
            }	
            else if ( front_feature == "slit" )
            {
                translate([0, wall_thickness, box_height - slit_box_portion]) 
                    cube([  wall_thickness, interior_depth, slit_box_portion + lip_height]);
            }	

            if ( logo_front )
            {
                logo_z = front_feature == "slit" ? box_height - slit_height : box_height;

                logo_size = logo_scale * min( box_depth, logo_z - ( rubber_band_hooks ? band_hook_height : 0 ) );

                logo_thickness = min( lip_thickness, 0.3 );
                //logo
      #          translate([ logo_thickness, box_depth/2 ,logo_z / 2])
                    rotate([90,0,0])
                        resize( [ logo_thickness,logo_size, logo_size] )
                            rotate([0,-90,0])
                            {
                                linear_extrude( height = 1, center = false)
                                    import( logo_path );
                            }
            }

            translate( [ 0, 0, box_height + lip_height/2])
                MakeDetents( lid = false );

            // band hooks
            if ( rubber_band_hooks )
            {;
                MakeBandHooks();  

                if ( rubber_band_holes )       
                    MakeBandHoles();
            }

            // this carves out the edges
            if ( lid_type == "fit-under" )
            {
                difference()
                {
                    // outer, main-box part
                    cube([ box_width, box_depth, lid_height + 2*tolerance + lip_thickness_inv ]);

                    //inner
                    translate( [ lip_thickness_inv + tolerance, lip_thickness_inv + tolerance, 0])
                        cube([ interior_width + 2*lip_thickness - 2*tolerance, interior_depth + 2*lip_thickness - 2*tolerance, lid_height + 2*tolerance + lip_thickness_inv ]);
                }

            }

		}

            // this adds back the angle that allows to print without supports
            if ( lid_type == "fit-under" )
            {
                difference()
                {
                    hull()
                    {
                        translate( [ 0, 0, lid_height + 2*tolerance + lip_thickness_inv ])
                            cube([ box_width, box_depth, 1 ]);

                        translate( [ 0, 0, lid_height])
                            translate( [ lip_thickness + tolerance, lip_thickness + tolerance, 0])
                                cube([ interior_width + 2*lip_thickness - 2*tolerance, interior_depth + 2*lip_thickness - 2*tolerance, lid_height+ 2*tolerance ]);
                    }

                    // main cavity
                    translate([ wall_thickness, wall_thickness, wall_thickness]) 
                        cube([  interior_width, 
                                interior_depth, 
                                interior_height + lip_height + 5 ]);
                        }
            }

        if ( lid_type == "snap-on" )
        {
            translate( [ box_width + finger_length, 0,0])
                difference() 
                {
                    hull() 
                    {
                        translate([ 0, 0, box_height ]) 
                            rotate([ -90, 0, 0 ]) 
                                cylinder(r = hinge_outer/2, h = box_depth);

                        translate([ -finger_length, 0, box_height - hinge_outer ])
                            cube([ .1, box_depth, hinge_outer- 1]);

                    }

                    translate([ -finger_length, finger_size ,0]) 
                        cube([ finger_length * 2, box_depth - 2 * finger_size, box_height * 2]);

                    // detent holes
                    translate([0, -( - finger_size + tolerance ), box_height ]) 
                        HingeDetent();
                        
                    translate([0, box_depth - finger_size + tolerance, box_height ]) 
                        HingeDetent(); 
                }

        }
        else if ( lid_type == "one-piece" )
        {
            translate( [ box_width + finger_length,0,0])
            {
                difference() 
                {
                    hull() 
                    {
                        translate([0,0,box_height]) 
                            rotate([-90,0,0]) 
                                cylinder(r = hinge_outer/2, h = box_depth);

                        translate([-finger_length, 0,box_height - hinge_outer ])
                            cube([.1,box_depth,hinge_outer- 1]);

                    }

                    // finger cutouts
                    for  (i = [ finger_size: finger_size*2: box_depth]) 
                    {
                        translate([-finger_length,i - ( finger_size/2 ) - ( hinge_finger_tolerance/2 ), 0]) 
                            cube([ finger_length*2, finger_size + hinge_finger_tolerance, box_height*2 ]);
                    }
                }

                // center rod
                translate([0, 0, box_height]) 
                    rotate([-90,0,0]) 
                        cylinder(r = hinge_inner /2, h = box_depth);  
            }
        }
	}
}

module MakeLidHinge( )
{
    if ( lid_type == "snap-on" )
    {
        difference() 
        {
            hull() 
            {
                translate([0, finger_size, lid_height ]) 
                {
                    rotate([-90,0,0]) 
                        cylinder(r = hinge_outer/2, h = box_depth - 2 * ( finger_size + tolerance ));
                }

                translate([ finger_length, finger_size + tolerance, lid_height - hinge_outer - 0])
                    cube([.1, box_depth - 2 * ( finger_size + tolerance ), hinge_outer - .5]);
            }

            translate([-finger_length, 2 * finger_size ,0]) 
                cube([finger_length * 2, box_depth - 4 * finger_size, lid_height * 2]);

        }

        // detents
        translate([0, finger_size, lid_height ]) 
            HingeDetent();

        translate([0, box_depth - finger_size, lid_height ]) 
            HingeDetent();  

    }
    else if ( lid_type == "one-piece" )
    {
        difference() 
        {
          hull() 
            {
                translate([0, 0, lid_height ]) 
                {
                    rotate([-90,0,0]) 
                        cylinder(r = hinge_outer/2, h = box_depth);
                }

                translate([0, 0,lid_height]) 
                    rotate([-90,0,0]) 
                        cylinder(r = hinge_outer/2, h = box_depth);

                translate([finger_length, 0,lid_height - hinge_outer ])
                    cube([.1, box_depth, hinge_outer- 1]);
            }
            // finger cutouts
            for  (i = [0: finger_size*2: box_depth+ finger_size]) 
            {
                translate([-finger_length + 0.1,i - (finger_size/2) - (hinge_finger_tolerance/2),0]) 
                    cube([finger_length*2, finger_size + hinge_finger_tolerance, lid_height*2]);
            }

            // center cutout
            translate([0, 0, lid_height]) 
                rotate([-90,0,0]) 
                    cylinder(r = hinge_inner /2 + hinge_inner_tolerance, h = box_depth);
        }
    }
}
	
module MakeLid() 
{
    difference() 
    {
        // main box
        cube([box_width,box_depth,lid_height - tolerance]);
        
        translate([ wall_thickness, wall_thickness, wall_thickness]) 
            union()
            {
                //main cavity
                
               cube([  interior_width, interior_depth, lid_height]);

                // lip 
                translate( [ -lip_thickness, -lip_thickness, lid_height - lip_height - wall_thickness])
                    cube( [ interior_width + notch_depth * 2 , interior_depth + notch_depth * 2 , lip_height]);
            }

        if ( front_feature == "slit")
        {
            translate( [ box_width - wall_thickness, wall_thickness, lid_interior_height - slit_lid_portion + wall_thickness])
                cube([  wall_thickness, box_depth - 2*wall_thickness, slit_lid_portion]);
        }

        if ( logo_top )
        {
            logo_thickness = min( lip_thickness, 0.1 );
            logo_size = logo_scale * min( box_depth, box_width );

            translate([ box_width/2, box_depth/2 , logo_thickness])
                resize( [ logo_size, logo_size, logo_thickness] )
                    rotate([180,0,-90])
                    {
                        linear_extrude(height = 1, center = false, $fn=100)
                            import( logo_path );
                    }
        }    

        // band hooks
        if ( rubber_band_hooks )
        {
            MakeBandHooks( lid = true );  

            if ( rubber_band_holes )       
                MakeBandHoles( lid = true );
        }
    }

    translate( [ 0, 0, lid_height - lip_height/2 ])
        MakeDetents( lid = true )

    if ( lid_type != "none" )
    {
        translate( [-finger_length,0,0])
            MakeLidHinge();
    }

}

module MirrorAboutPoint( v, pt) 
{
    translate(pt)
        mirror( v )
            translate(-pt)
                children();   
}