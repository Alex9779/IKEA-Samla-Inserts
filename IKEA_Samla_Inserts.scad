// Box size
Box_Size = "5"; // [5:5 liters,11:11 liters,22:22 liters]

// Layer to generate (boxes get wider to the top so)
Active_Layer = 1; // [1:10]

// Inserts per box (one insert is a layer)
Layers = 3; // [1:10]

// Wall thickness
Wall_Thickness = 0.8;

// Bottom thickness
Bottom_Thickness = 0.8;

// Amount of cells in larger box dimension
Cell_Columns = 2; // [1:10]

// Amount of cells in smaller box dimension
Cell_Rows = 2; // [1:10]

// Additional spacing between box and insert
Addtional_Spacing = 1;

// Halve (just print half a layer)
Halve = "false"; // ["false":false, "column":column, "row":row]

// Resolution used to render curved surfaces (experiment with low resolutions, and render the final results with higher resolution settings)
Resolution = 30; // [30:Low (12 degrees), 60:Medium (6 degrees), 120:High (3 degrees)]

/* [Hidden] */
// 5 liters box
5_width = 240; // overall inner width of the box
5_depth = 155; // overall inner depth of the box
5_height = 115; // overall inner height of the box
5_scale_width = 1.075; // factor how much bigger the box gets in width [inner width at top] / [inner width at bottom]
5_scale_depth = 1.115; // factor how much bigger the box gets in depth [inner depth at top] / [inner depth at bottom]
5_width_handle = 33; // width of the handle
5_depth_handle = 90; // depth of the handle
5_width_cutout = 5_width-(5_depth-5_depth_handle); //width of the cutout
5_depth_cutout = 5; // depth of the cutout
5_scale_handle = 0.86; // factor how much smaller the handle gets [handle width at top] / [handle width at bottom]
5_scale_cutout = 0.92; // factor how much smaller the cutout gets [cutout width at top] / [cutout width at bottom]
5_handle_cutout_height = 92; // needed to calculate if we need handle and cutout, low layers on top don't need them
5_diameter = 20; // diameter of the rounded box corners

// 11 liters box
11_width = 347;
11_depth = 235;
11_height = 115;
11_scale_width = 1.075;
11_scale_depth = 1.115;
11_width_handle = 33;
11_depth_handle = 102;
11_width_cutout = 11_width-(11_depth-11_depth_handle);
11_depth_cutout = 5;
11_scale_handle = 0.86;
11_scale_cutout = 0.92;    
11_handle_cutout_height = 92;
11_diameter = 20;

// 22 liters box
22_width = 347;
22_depth = 235;
22_height = 230;
22_scale_width = 1.075;
22_scale_depth = 1.115;
22_width_handle = 33;
22_depth_handle = 102;
22_width_cutout = 22_width-(22_depth-22_depth_handle);
22_depth_cutout = 5;
22_scale_handle = 0.86;
22_scale_cutout = 0.92;    
22_handle_cutout_height = 207;
22_diameter = 20;


module Samla_Base(width, depth, height, diameter) {
    hull() {
        if (Halve == "false") {
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([-(width/2-diameter), depth/2-diameter]) circle(diameter);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Halve == "column") {
            translate([0-Addtional_Spacing/2, -(depth/2-diameter)-diameter]) square(diameter, false);
            translate([0-Addtional_Spacing/2, depth/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Halve == "row") {
            translate([-(width/2-diameter), 0-Addtional_Spacing/2]) square(diameter, false);
            translate([-(width/2-diameter), depth/2-diameter]) circle(diameter);
            translate([width/2-diameter, 0-Addtional_Spacing/2]) square(diameter, false);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
    }
}

module Samla_HandleAndCutout(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, offset) {
    if ((height/Layers)*(Active_Layer-1)<handle_cutout_height) {
        linear_extrude(height=height, scale=[scale_cutout, scale_depth]) {
            offset(Addtional_Spacing-offset) translate([0, depth/2]) square([width_cutout, depth_cutout], true);
        }
        linear_extrude(height=height, scale=[scale_cutout, scale_depth]) {
            offset(Addtional_Spacing-offset) translate([0, -depth/2]) square([width_cutout, depth_cutout], true);
        }
        linear_extrude(height=height, scale=[scale_width, scale_handle]) {
            offset(Addtional_Spacing-offset)
            hull() {
                translate([-((width-width_handle)/2+diameter/2), -(depth_handle/2-diameter/2)]) circle(diameter/2);
                translate([-((width-width_handle)/2+diameter/2), depth_handle/2-diameter/2]) circle(diameter/2);
                translate([-((width-width_handle)/2+diameter), 0]) square([diameter, depth_handle], true);
            }
        }
        linear_extrude(height=height, scale=[scale_width, scale_handle]) {
            offset(Addtional_Spacing-offset)
            hull() {
                translate([(width-width_handle)/2+diameter/2, -(depth_handle/2-diameter/2)]) circle(diameter/2);
                translate([(width-width_handle)/2+diameter/2, depth_handle/2-diameter/2]) circle(diameter/2);
                translate([(width-width_handle)/2+diameter, 0]) square([diameter, depth_handle], true);
            }
        }
    }
}

module Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, offset) {
    difference() {
        linear_extrude(height=height, scale = [scale_width, scale_depth]) {
            offset(-Addtional_Spacing+offset) Samla_Base(width, depth, height, diameter);
        }
        Samla_HandleAndCutout(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, offset);
    }
}

module Grid(width, depth, height, columns, rows, wall_thickness, scale_width, scale_depth) {
    if (Halve == "false" || Halve == "row") {
        for (i=[-(columns/2-1):1:columns/2-1]) {
            translate([i*(width/columns+2*wall_thickness), 0, height/2])
                cube([wall_thickness, depth*scale_depth, height], true);
        }
    }
    else if (Halve == "column") {
        for (i=[0:1:columns-1]) {
            translate([i*(width/2/columns+2*wall_thickness), 0, height/2])
                cube([wall_thickness, depth*scale_depth, height], true);
        }
    }

    if (Halve == "false" || Halve == "column") {
        for (i=[-(rows/2-1):1:rows/2-1]) {
            translate([0, i*(depth/rows+2*wall_thickness), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_width, height], true);
        }
    }
    else if (Halve == "row") {
        for (i=[0:1:rows-1]) {
            translate([0, i*(depth/2/rows+2*wall_thickness), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_width, height], true);
        }
    }
}

module Create_Samla_Insert(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, $fn) {
    translate([0, 0, -(height/Layers)*(Active_Layer-1)]) {
        intersection() {
            union() {
                // generate grid in inner box shape
                if (Cell_Columns>1 || Cell_Rows>1) {
                    intersection() {
                        Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, 0);
                        Grid(width, depth, height, Cell_Columns, Cell_Rows, Wall_Thickness, scale_width, scale_depth);
                    }
                }
                // generate surrounding wall
                difference() {
                    Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, 0);
                    Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, -Wall_Thickness);
                }
                // generate bottom
                intersection() {
                    Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, 0);
                    translate([0, 0, (Bottom_Thickness/2)+(height/Layers)*(Active_Layer-1)]) cube([width*scale_width, depth*scale_depth, Bottom_Thickness], true);
                }
            }
            // remove everything not needed for current layer
            translate([0, 0, (height/Layers/2)+(height/Layers)*(Active_Layer-1)]) cube([width*scale_width, depth*scale_depth, height/Layers], true);
        }
    }
}

if (Active_Layer <= Layers) {
    
    if (Box_Size == "5")
    {
        width = 5_width;
        depth = 5_depth;
        height = 5_height;
        scale_width = 5_scale_width;
        scale_depth = 5_scale_depth;
        width_handle = 5_width_handle;
        depth_handle = 5_depth_handle;
        width_cutout = 5_width_cutout;
        depth_cutout = 5_depth_cutout;
        scale_handle = 5_scale_handle;
        scale_cutout = 5_scale_cutout;
        handle_cutout_height = 5_handle_cutout_height;
        diameter = 5_diameter;

        Create_Samla_Insert(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, Resolution);
    }
    else if (Box_Size == "11")
    {
        width = 11_width;
        depth = 11_depth;
        height = 11_height;
        scale_width = 11_scale_width;
        scale_depth = 11_scale_depth;
        width_handle = 11_width_handle;
        depth_handle = 11_depth_handle;
        width_cutout = 11_width_cutout;
        depth_cutout = 11_depth_cutout;
        scale_handle = 11_scale_handle;
        scale_cutout = 11_scale_cutout;
        handle_cutout_height = 11_handle_cutout_height;
        diameter = 11_diameter;

        Create_Samla_Insert(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, Resolution);
    }
    else if (Box_Size == "22")
    {
        width = 22_width;
        depth = 22_depth;
        height = 22_height;
        scale_width = 22_scale_width;
        scale_depth = 22_scale_depth;
        width_handle = 22_width_handle;
        depth_handle = 22_depth_handle;
        width_cutout = 22_width_cutout;
        depth_cutout = 22_depth_cutout;
        scale_handle = 22_scale_handle;
        scale_cutout = 22_scale_cutout;
        handle_cutout_height = 11_handle_cutout_height;
        diameter = 11_diameter;

        Create_Samla_Insert(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, Resolution);
    }
}