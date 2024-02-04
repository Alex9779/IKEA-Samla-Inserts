Box_size = "5"; // ["5":5 liters,"11":11 liters,"22":22 liters]

// Inserts per box (one insert is a layer)
Layers = 3; // [1:10]

// Layer to generate (boxes get wider to the top so), 0 to generate all layers at once.
Active_layer = 1; // [0:10] 

// Amount of cells in larger box dimension
Cell_columns = 2; // [1:10]

// Amount of cells in smaller box dimension
Cell_rows = 2; // [1:10]

/* [Layer marking] */
Layer_marking = "false"; // ["false":false, "inside":inside, "outside":outside]

Layer_marking_positions = 15; // [0:none, 1:ul, 2:ur, 3:ul+ur, 4:ll, 5:ul+ll, 6:ur+ll, 7:ul+ur+ll, 8:lr, 9:ul+lr, 10:ur+lr, 11:ul+ur+lr, 12:ll+lr, 13:ul+ll+lr, 14:ur+ll+lr, 15:ul+ur+ll+lr]

Layer_marking_type = "engrave"; // ["engrave":engrave, "emboss":emboss]

Layer_marking_height = 0.3;

Custom_layer_mark = "";

/* [Fillets] */
// Fillets at the bottom of cells
Fillets = "false"; // ["false":false, "x":x, "y":y]

// Fillet radius
Fillet_radius = 10;

/* [Advanced settings] */
// Set what should be generated
Generation = "complete"; // ["complete":complete, "gridbottom":grid + bottom, "grid":grid, "tray":open tray with sides]

// Combines active layer with N layers above
Combine_layers = 0; // [0:10]

// Inner wall thickness is for the grid. Adjust to your nozzle extrusion width.
Inner_wall_thickness = 0.75;

// Outer wall thickness is for the outside. Adjust to your nozzle extrusion width.
Outer_wall_thickness = 1.3;

// Adjust to your first layer height and layer height
Bottom_thickness = 0.87;

// Thickness of the top layer in tray mode
Top_thickness = 0.87;

// Additional spacing between box and insert
Additional_spacing = 1;

// Just print part of a layer, halve or quarter
Part = "false"; // ["false":false, "halve_column":halve by column, "halve_row":halve by row, "quarter":quarter]

// Full are easier to print (no support needed), partial cutouts let the top layer rest on the handle-cutouts
Top_layer_cutouts = "full"; // ["full": full, "partial": partial]

/* [Hidden] */
Test = "false";
Test_offset = 5;

// 5 liters box
// VALUES WIP!!! MAY STILL CHANGE AFTER SOME PRINTS!!!
5_width = 240; // overall inner width of the box
5_depth = 154; // overall inner depth of the box
5_height = 118; // overall inner height of the box
5_scale_width = 1.07; // factor how much bigger the box gets in width [inner width at top] / [inner width at bottom]
5_scale_depth = 1.11; // factor how much bigger the box gets in depth [inner depth at top] / [inner depth at bottom]
5_width_handle = 17; // width of the handle
5_depth_handle = 92; // depth of the handle
5_width_cutout = 5_width-(5_depth-5_depth_handle); //width of the cutout
5_depth_cutout = 2.5; // depth of the cutout
5_scale_handle = 0.85; // factor how much smaller the handle gets [handle width at top] / [handle width at bottom]
5_scale_cutout = 0.90; // factor how much smaller the cutout gets [cutout width at top] / [cutout width at bottom]
5_handle_cutout_height = 93; // needed to calculate if we need handle and cutout, low layers on top don't need them
5_diameter = 18; // diameter of the rounded box corners
5_diameter2 = 12; // diameter of the handle corners

// 11 liters box
// VALUES WIP!!! MAY STILL CHANGE AFTER SOME PRINTS!!!
11_width = 347;
11_depth = 234;
11_height = 118;
11_scale_width = 1.055;
11_scale_depth = 1.09;
11_width_handle = 17;
11_depth_handle = 103;
11_width_cutout = 11_width-(11_depth-11_depth_handle)-12;
11_depth_cutout = 2.5;
11_scale_handle = 0.85;
11_scale_cutout = 0.90;
11_handle_cutout_height = 90;
11_diameter = 18;
11_diameter2 = 12;

// 22 liters box
// VALUES WIP!!! MAY STILL CHANGE AFTER SOME PRINTS!!!
22_width = 328;
22_depth = 218;
22_height = 256;
22_scale_width = 1.125;
22_scale_depth = 1.135;
22_width_handle = 17;
22_depth_handle = 123;
22_width_cutout = 22_width-(22_depth-22_depth_handle)-10;
22_depth_cutout = 2.5;
22_scale_handle = 0.74;
22_scale_cutout = 0.86;
22_handle_cutout_height = 230;
22_diameter = 18;
22_diameter2 = 12;

Resolution = $preview ? 32 : 64;

module Samla_Base(layer, width, depth, height, diameter, width_cutout, scale_cutout, $fn = Resolution) {
    hull() {
        if (Part == "false") {
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([-(width/2-diameter), depth/2-diameter]) circle(diameter);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Part == "halve_column") {
            translate([0-Additional_spacing/2, -(depth/2-diameter)-diameter]) square(diameter, false);
            translate([0-Additional_spacing/2, depth/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Part == "halve_row") {
            translate([-(width/2-diameter)-diameter, Additional_spacing/2-diameter]) square(diameter, false);
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, Additional_spacing/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
        }
        else if (Part == "quarter") {
            translate([0-Additional_spacing/2, -(depth/2-diameter)-diameter]) square(diameter, false);
            translate([0-Additional_spacing/2, Additional_spacing/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, Additional_spacing/2-diameter]) circle(diameter);
        }
    }
}

module Samla_HandleAndCutout(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset, $fn = Resolution) {
    if ((height/Layers)*(layer-1)<handle_cutout_height) {
        // cutout
        linear_extrude(height=height, scale=[scale_cutout, scale_depth]) {
            offset(Additional_spacing-offset, $fn = Resolution/4) translate([0, depth/2]) square([width_cutout, depth_cutout*2], true);
        }
        linear_extrude(height=height, scale=[scale_cutout, scale_depth]) {
            offset(Additional_spacing-offset, $fn = Resolution/4) translate([0, -depth/2]) square([width_cutout, depth_cutout*2], true);
        }
        // handle
        linear_extrude(height=height, scale=[scale_width, scale_handle]) {
            offset(delta=Additional_spacing-offset)
            hull() {
                translate([-(width/2-width_handle+diameter2), -(depth_handle/2-diameter2)]) circle(diameter2);
                translate([-(width/2-width_handle+diameter2), depth_handle/2-diameter2]) circle(diameter2);
                translate([-(width/2-width_handle+diameter2+diameter2/2), 0]) square([diameter2, depth_handle], true);
            }
        }
        linear_extrude(height=height, scale=[scale_width, scale_handle]) {
            offset(delta=Additional_spacing-offset)
            hull() {
                translate([(width/2-width_handle+diameter2), -(depth_handle/2-diameter2)]) circle(diameter2);
                translate([(width/2-width_handle+diameter2), depth_handle/2-diameter2]) circle(diameter2);
                translate([(width/2-width_handle+diameter2+diameter2/2), 0]) square([diameter2, depth_handle], true);
            }
        }
    }
}

module Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset) {
    union() {
        difference() {
            linear_extrude(height=height, scale = [scale_width, scale_depth]) {
                offset(delta=-Additional_spacing+offset) Samla_Base(layer, width, depth, height, diameter, width_cutout, scale_cutout);
            }
            Samla_HandleAndCutout(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset);
        }
        if (Top_layer_cutouts == "partial") {
            intersection() {
                translate([0, 0, height-(height-handle_cutout_height)/2+(offset!=0?Bottom_thickness:0)]) cube([width*scale_width, depth*scale_depth, height-handle_cutout_height], true);
                linear_extrude(height=height, scale = [scale_width, scale_depth]) {
                        offset(delta=-Additional_spacing+offset) Samla_Base(layer, width, depth, height, diameter, width_cutout, scale_cutout);
                }
            }
        }
    }
}

module Grid(layer, width, depth, height, columns, rows, Wall_thickness, scale_width, scale_depth) {
    if (Part == "false" || Part == "halve_row") {

        for (i=[-(columns/2-1):1:columns/2-1]) {
            translate([i*((width-Wall_thickness-2*Additional_spacing)/columns), 0, height/2])
                cube([Wall_thickness, depth*scale_depth, height], true);
        }
    }
    else if (Part == "halve_column" || Part == "quarter") {
        for (i=[0:1:columns-1]) {
            translate([i*((width-Wall_thickness-2*Additional_spacing)/2/columns), 0, height/2])
                cube([Wall_thickness, depth*scale_depth, height], true);
        }
    }

    if (Part == "false" || Part == "halve_column") {
        for (i=[-(rows/2-1):1:rows/2-1]) {
            translate([0, i*((depth-Wall_thickness-2*Additional_spacing)/rows), height/2])
                rotate([0, 0, 90])
                cube([Wall_thickness, width*scale_width, height], true);
        }
    }
    else if (Part == "halve_row" || Part == "quarter") {
        for (i=[-rows+1:1:0]) {
            translate([0, i*((depth-Wall_thickness-2*Additional_spacing)/2/rows), height/2])
                rotate([0, 0, 90])
                cube([Wall_thickness, width*scale_width, height], true);
        }
    }
}

module Fillet(positionX, positionY, width, radius, rotZ = 0, $fn = Resolution){
	translate([positionX, positionY, radius/2]){
        rotate([0, 90, rotZ]) {
            difference(){                
                cube(size=[radius, radius, width], center = true);
                translate([-radius/2, -radius/2, 0]) {
                    cylinder(h = width, r = radius, center = true);
                }
            }
        }
	}
}

module Fillets(layer, width, depth, height, columns, rows, Wall_thickness, scale_width, scale_depth) {
    if (Fillets == "x") {
        translate([0, 0, height/Layers*(layer-1)+Bottom_thickness]) {
            for (i=[-rows/2+1:1:rows/2-1]) {
                if (i == -rows/2+1) {
                    Fillet(0, i*((depth-Wall_thickness-2*Additional_spacing)/rows)-Wall_thickness/2-Fillet_radius/2, width*scale_width, Fillet_radius, 0);
                    Fillet(0, i*((depth-Wall_thickness-2*Additional_spacing)/rows)+Wall_thickness/2+Fillet_radius/2, width*scale_width, Fillet_radius, 180);
                }
                else {
                    Fillet(0, i*((depth-Wall_thickness-2*Additional_spacing)/rows)+Wall_thickness/2+Fillet_radius/2, width*scale_width, Fillet_radius, 180);
                }
            }
        }
    }
    
    if (Fillets == "y") {
        translate([0, 0, height/Layers*(layer-1)+Bottom_thickness]) {
            for (i=[-columns/2+1:1:columns/2-1]) {
                if (i == -columns/2+1) {
                    Fillet(i*((width-Wall_thickness-2*Additional_spacing)/columns)-Wall_thickness/2-Fillet_radius/2, 0, width*scale_width, Fillet_radius, -90);
                    Fillet(i*((width-Wall_thickness-2*Additional_spacing)/columns)+Wall_thickness/2+Fillet_radius/2, 0, width*scale_width, Fillet_radius, 90);
                }
                else {
                    Fillet(i*((width-Wall_thickness-2*Additional_spacing)/columns)+Wall_thickness/2+Fillet_radius/2, 0, width*scale_width, Fillet_radius, 90);
                }
            }
        }
    }
}

module Layer_Marking_Text_Single(layer, width, depth, height, diameter, position)
{
    size = Layer_marking == "outside" ? 10 : Cell_columns >= 6 || Cell_rows >= 6 ? 10-(max(Cell_columns, Cell_rows)-3) : 10;
    width_offset = (Cell_columns >= 6 || Cell_rows >= 6) && Layer_marking != "outside" ? 22-(max(Cell_columns, Cell_rows)-4)-(layer/2-1)+(Cell_columns <= 4 && layer == 10 ? 5 : 0) : 24-(layer/2-1)+(Cell_columns <= 4 && layer == 10 ? 5 : 0);
    depth_offset = (Cell_columns >= 6 || Cell_rows >= 6) && Layer_marking != "outside" ? 16-(max(Cell_columns, Cell_rows)-4)-(layer/2-1) : 18-(layer/2-1);

    bottom_offset = Layer_marking == "inside" ? Bottom_thickness : 0;
    rotate_y = Layer_marking == "outside" ? 180 : 0;
    mark = Custom_layer_mark != "" ? Custom_layer_mark : str(layer, "-", Layers);

    if (position == 1) {
        translate([-width/2+width_offset, depth/2-depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 180]) linear_extrude(height=Layer_marking_height) text(text=mark, size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
    else if (position == 2) {
        translate([width/2-width_offset, depth/2-depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 180]) linear_extrude(height=Layer_marking_height) text(text=mark, size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
    else if (position == 4) {
        translate([-width/2+width_offset, -depth/2+depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 0]) linear_extrude(height=Layer_marking_height) text(text=mark, size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
    else if (position == 8) {
        translate([width/2-width_offset, -depth/2+depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 0]) linear_extrude(height=Layer_marking_height) text(text=mark, size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
}

module Layer_Marking_Text(layer, width, depth, height, diameter) {
    if (Layer_marking_positions == 1) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
    }
    else if (Layer_marking_positions == 2) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
    }
    else if (Layer_marking_positions == 3) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
    }
    else if (Layer_marking_positions == 4) {
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
    }
    else if (Layer_marking_positions == 5) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
    }
    else if (Layer_marking_positions == 6) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
    }
    else if (Layer_marking_positions == 7) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);

    }
    else if (Layer_marking_positions == 8) {
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 9) {

        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 10) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 11) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        Layer_Marking_Text_Single(width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 12) {
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 13) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 14) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_marking_positions == 15) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);

    }
}

module Layer_Marking(layer, width, depth, height, diameter) {
    if ((Layer_marking == "inside" || Layer_marking == "outside") && Layer_marking_positions != 0) {
        if (Layer_marking_type == "engrave") {
            difference() {
                children();
                if (Layer_marking == "inside") {
                    translate([0, 0, -Layer_marking_height]) Layer_Marking_Text(layer, width, depth, height, diameter);
                }
                else if (Layer_marking == "outside") {
                    translate([0, 0, +Layer_marking_height]) Layer_Marking_Text(layer, width, depth, height, diameter);
                }
            }
        }
        else if (Layer_marking_type == "emboss") {
            children();
            if (Layer_marking == "inside") {
                Layer_Marking_Text(layer, width, depth, height, diameter);
            }            
        }
    }
    else
    {
        children();
    }
}

module Samla_Insert(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, $fn) {
    translate([0, 0, -(height/Layers)*(layer-1)]) {
        intersection() {
            union() {
                if (Test == "false") {
                    // generate grid in inner box shape
                    if (Cell_columns>1 || Cell_rows>1) {
                        intersection() {
                            Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            Grid(layer, width, depth, height, Cell_columns, Cell_rows, Inner_wall_thickness, scale_width, scale_depth);
                        }
                    }
                    // generate bottom
                    if (Generation == "complete" || Generation == "gridbottom" || Generation == "tray") {
                        Layer_Marking(layer, width, depth, height, diameter) {
                            intersection() {
                                Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                                translate([0, 0, (Bottom_thickness/2)+(height/Layers)*(layer-1)]) cube([width*scale_width, depth*scale_depth, Bottom_thickness], true);
                            }
                        }
                    }
                    // generate surrounding wall
                    if (Generation == "complete") {
                        difference() {
                            Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, -Outer_wall_thickness);
                        }
                    }
                    // generate walls to the side
                    if (Generation == "tray") {
                        difference() {
                            union() {
                                // generate walls
                                difference() {
                                    Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                                    Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, -Outer_wall_thickness);
                                }
                                // generate top plate on top of the walls, so layers can stack
                                intersection() {
                                    Samla_Content(layer + 1, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                                    translate([0, 0, (Top_thickness/2)+(height/Layers)*(layer) - Top_thickness]) cube([width*scale_width, depth*scale_depth, Top_thickness], true);
                                }
                            }
                            // remove a cube from the middle, so it becomes a tray
                            translate([0, 0, (height/(Layers/(Combine_layers+1))/2)+(height/Layers)*(layer-1)]) cube([width * scale_width - 2 * (width_handle + diameter2), depth*scale_depth, height/(Layers/(Combine_layers+1))], true);
                        }
                    }
                    // generate walls to the side
                    if (Generation == "tray") {
                        difference() {
                            union() {
                                // generate walls
                                difference() {
                                    Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                                    Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, -Outer_wall_thickness);
                                }
                                // generate top plate on top of the walls, so layers can stack
                                intersection() {
                                    Samla_Content(layer + 1, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                                    translate([0, 0, (Top_thickness/2)+(height/Layers)*(layer) - Top_thickness]) cube([width*scale_width, depth*scale_depth, Top_thickness], true);
                                }
                            }
                            // remove a cube from the middle, so it becomes a tray
                            translate([0, 0, (height/(Layers/(Combine_layers+1))/2)+(height/Layers)*(layer-1)]) cube([width * scale_width - 2 * (width_handle + diameter2), depth*scale_depth, height/(Layers/(Combine_layers+1))], true);
                        }
                    }
                    // generate fillets
                    if (Fillets != "false") {
                        intersection() {
                            Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            Fillets(layer, width, depth, height, Cell_columns, Cell_rows, Inner_wall_thickness, scale_width, scale_depth);
                        }
                    }
                }
                else if (Test == "true") {
                    Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                }
            }
            if (Test == "false") {
                // remove everything not needed for current layer
                translate([0, 0, (height/(Layers/(Combine_layers+1))/2)+(height/Layers)*(layer-1)]) cube([width*scale_width, depth*scale_depth, height/(Layers/(Combine_layers+1))], true);
            }
            else if (Test == "true") {
                translate([width-width_handle-Additional_spacing-Test_offset, -depth*scale_depth/2-(depth_handle+Additional_spacing*2)*scale_handle/2+diameter2+Test_offset, height/2]) cube([width, depth*scale_depth, height], true);
                translate([(width*scale_width)/2+(width_cutout*scale_cutout)/2-Test_offset, -depth+depth_cutout+Additional_spacing+Test_offset, height/2]) cube([width*scale_width, depth, height], true);
            }
        }
    }
}

start_layer = Active_layer == 0 ? 1 : Active_layer;
end_layer = Active_layer == 0 ? Layers : Active_layer;

for ( layer = [ start_layer : end_layer ] )
{
    if (Box_size == "5")
    {
        translate( [ 0, ( layer - start_layer ) * 5_depth * 5_scale_depth, 0] )
            Samla_Insert(layer, 5_width, 5_depth, 5_height, 5_scale_width, 5_scale_depth, 5_width_handle, 5_depth_handle, 5_width_cutout, 5_depth_cutout, 5_scale_handle, 5_scale_cutout, 5_handle_cutout_height, 5_diameter, 5_diameter2);
    }
    else if (Box_size == "11")
    {
        translate( [ 0, ( layer - start_layer ) * 11_depth * 11_scale_depth, 0] )
            Samla_Insert(layer, 11_width, 11_depth, 11_height, 11_scale_width, 11_scale_depth, 11_width_handle, 11_depth_handle, 11_width_cutout, 11_depth_cutout, 11_scale_handle, 11_scale_cutout, 11_handle_cutout_height, 11_diameter, 11_diameter2);
    }
    else if (Box_size == "22")
    {
        translate( [ 0, ( layer - start_layer ) * 22_depth * 22_scale_depth, 0] )
            Samla_Insert(layer, 22_width, 22_depth, 22_height, 22_scale_width, 22_scale_depth, 22_width_handle, 22_depth_handle, 22_width_cutout, 22_depth_cutout, 22_scale_handle, 22_scale_cutout, 22_handle_cutout_height, 22_diameter, 22_diameter2);
    }
}
