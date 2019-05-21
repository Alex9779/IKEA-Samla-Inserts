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

module Samla_Base(width, depth, height, diameter, width_handle) {
    hull() {
        if (Halve == "false") {
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([-(width/2-diameter), depth/2-diameter]) circle(diameter);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Halve == "column") {
            translate([0, -(depth/2-diameter)-diameter]) square(diameter, false);
            translate([0, depth/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Halve == "row") {
            translate([-(width/2-diameter), 0]) square(diameter, false);
            translate([-(width/2-diameter), depth/2-diameter]) circle(diameter);
            translate([width/2-diameter, 0]) square(diameter, false);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
    }
}

module Grid(width, depth, height, columns, rows, wall_thickness, scale_w, scale_d) {
    if (Halve == "false" || Halve == "row") {
        for (i=[-(columns/2-1):1:columns/2-1]) {
            translate([i*(width/columns+2*wall_thickness), 0, height/2])
                cube([wall_thickness, depth*scale_d, height], true);
        }
    }
    else if (Halve == "column") {
        for (i=[0:1:columns-1]) {
            translate([i*(width/2/columns+2*wall_thickness), 0, height/2])
                cube([wall_thickness, depth*scale_d, height], true);
        }
    }

    if (Halve == "false" || Halve == "column") {
        for (i=[-(rows/2-1):1:rows/2-1]) {
            translate([0, i*(depth/rows+2*wall_thickness), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_w, height], true);
        }
    }
    else if (Halve == "row") {
        for (i=[0:1:rows-1]) {
            translate([0, i*(depth/2/rows+2*wall_thickness), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_w, height], true);
        }
    }
}

module Samla_HandleAndCutout(width, depth, height, diameter, width_handle, scale_w, scale_d, offset) {
    wi1 = width-33;
    di1 = depth-5;
    hi1 = height-23;
    sw1 = 0.92;
    sd1 = 0.86;

    if ((height/Layers)*(Active_Layer-1)<hi1) {
        linear_extrude(height=height, scale=[sw1, scale_d]) {
            offset(Addtional_Spacing-offset) translate([0, depth/2]) square([width-(depth-width_handle), depth-di1], true);
        }
        linear_extrude(height=height, scale=[sw1, scale_d]) {
            offset(Addtional_Spacing-offset) translate([0, -depth/2]) square([width-(depth-width_handle), depth-di1], true);
        }
        linear_extrude(height=height, scale=[scale_w, sd1]) {
            offset(Addtional_Spacing-offset)
            hull() {
                translate([-(wi1/2+diameter/2), -(width_handle/2-diameter/2)]) circle(diameter/2);
                translate([-(wi1/2+diameter/2), width_handle/2-diameter/2]) circle(diameter/2);
                translate([-(wi1/2+diameter), 0]) square([diameter, width_handle], true);
            }
        }
        linear_extrude(height=height, scale=[scale_w, sd1]) {
            offset(Addtional_Spacing-offset)
            hull() {
                translate([wi1/2+diameter/2, -(width_handle/2-diameter/2)]) circle(diameter/2);
                translate([wi1/2+diameter/2, width_handle/2-diameter/2]) circle(diameter/2);
                translate([wi1/2+diameter, 0]) square([diameter, width_handle], true);
            }
        }
    }
}

module Samla_Content(width, depth, height, diameter, width_handle, scale_w, scale_d, offset) {
    difference() {
        linear_extrude(height=height, scale = [scale_w, scale_d]) {
            offset(-Addtional_Spacing+offset) Samla_Base(width, depth, height, diameter, width_handle);
        }
        Samla_HandleAndCutout(width, depth, height, diameter, width_handle, scale_w, scale_d, offset);
    }
}

module Create_Samla_Insert($fn) {

    // 5 liters box dimensions
    width = 240;
    depth = 155;
    width_handle = 90;
    diameter = 20;
    height = 115;
    scale_w = 1.075;
    scale_d = 1.115;

    translate([0, 0, -(height/Layers)*(Active_Layer-1)]) {
        intersection() {
            union() {
                // generate grid in inner box shape
                if (Cell_Columns>1 || Cell_Rows>1) {
                    intersection() {
                        Samla_Content(width, depth, height, diameter, width_handle, scale_w, scale_d, 0);
                        Grid(width, depth, height, Cell_Columns, Cell_Rows, Wall_Thickness, scale_w, scale_d);
                    }
                }
                // generate surrounding wall
                difference() {

                    Samla_Content(width, depth, height, diameter, width_handle, scale_w, scale_d, 0);
                    Samla_Content(width, depth, height, diameter, width_handle, scale_w, scale_d, -Wall_Thickness);
                }
                // generate bottom
                intersection() {
                    Samla_Content(width, depth, height, diameter, width_handle, scale_w, scale_d, 0);
                    translate([0, 0, (Bottom_Thickness/2)+(height/Layers)*(Active_Layer-1)]) cube([width*scale_w, depth*scale_d, Bottom_Thickness], true);
                }
            }
            // remove everything not needed for current layer
            translate([0, 0, (height/Layers/2)+(height/Layers)*(Active_Layer-1)]) cube([width*scale_w, depth*scale_d, height/Layers], true);
        }
    }
}

if (Active_Layer <= Layers) {
    Create_Samla_Insert(Resolution);
}