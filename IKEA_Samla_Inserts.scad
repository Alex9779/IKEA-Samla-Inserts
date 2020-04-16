// Box size
Box_Size = "5"; // ["5":5 liters,"11":11 liters,"22":22 liters]

// Layer to generate (boxes get wider to the top so), 0 to generate all layers at once.
Active_Layer = 0; // [0:10] 

// Inserts per box (one insert is a layer)
Layers = 3; // [1:10]

// Wall thickness (adjust to your nozzle extrusion width)
Wall_Thickness = 0.75;

// Bottom thickness (adjust to you layer height)
Bottom_Thickness = 0.87;

// Amount of cells in larger box dimension
Cell_Columns = 2; // [1:10]

// Amount of cells in smaller box dimension
Cell_Rows = 2; // [1:10]

// Additional spacing between box and insert
Addtional_Spacing = 1;

// Part (just print part of a layer, halve or quarter)
Part = "false"; // ["false":false, "halve_column":halve by column, "halve_row":halve by row, "quarter":quarter]

/* [Layer marking] */
// Layer marking
Layer_Marking = "false"; // ["false":false, "inside":inside, "outside":outside]

// Layer marking position(s)
Layer_Marking_Positions = 15; // [0:none, 1:ul, 2:ur, 3:ul+ur, 4:ll, 5:ul+ll, 6:ur+ll, 7:ul+ur+ll, 8:lr, 9:ul+lr, 10:ur+lr, 11:ul+ur+lr, 12:ll+lr, 13:ul+ll+lr, 14:ur+ll+lr, 15:ul+ur+ll+lr]

// Layer marking type
Layer_Marking_Type = "engrave"; // ["engrave":engrave, "emboss":emboss]

// Layer marking height
Layer_Marking_Height = 0.3;

/* [Hidden] */
Test = "false";
Test_Offset = 5;

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
22_handle_cutout_height = 207;
22_diameter = 18;
22_diameter2 = 12;

Resolution = $preview ? 30 : 120;

module Samla_Base(layer, width, depth, height, diameter, width_cutout, scale_cutout) {
    hull() {
        if (Part == "false") {
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([-(width/2-diameter), depth/2-diameter]) circle(diameter);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Part == "halve_column") {
            translate([0-Addtional_Spacing/2, -(depth/2-diameter)-diameter]) square(diameter, false);
            translate([0-Addtional_Spacing/2, depth/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, depth/2-diameter]) circle(diameter);
        }
        else if (Part == "halve_row") {
            translate([-(width/2-diameter)-diameter, Addtional_Spacing/2-diameter]) square(diameter, false);
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, Addtional_Spacing/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
        }
        else if (Part == "quarter") {
            translate([0-Addtional_Spacing/2, -(depth/2-diameter)-diameter]) square(diameter, false);
            translate([0-Addtional_Spacing/2, Addtional_Spacing/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, Addtional_Spacing/2-diameter]) circle(diameter);
        }
    }
}

module Samla_HandleAndCutout(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset) {
    if ((height/Layers)*(layer-1)<handle_cutout_height) {
        // cutout
        linear_extrude(height=height, scale=[scale_cutout, scale_depth]) {
            offset(Addtional_Spacing-offset) translate([0, depth/2]) square([width_cutout, depth_cutout*2], true);
        }
        linear_extrude(height=height, scale=[scale_cutout, scale_depth]) {
            offset(Addtional_Spacing-offset) translate([0, -depth/2]) square([width_cutout, depth_cutout*2], true);
        }
        // handle
        linear_extrude(height=height, scale=[scale_width, scale_handle]) {
            offset(delta=Addtional_Spacing-offset)
            hull() {
                translate([-(width/2-width_handle+diameter2), -(depth_handle/2-diameter2)]) circle(diameter2);
                translate([-(width/2-width_handle+diameter2), depth_handle/2-diameter2]) circle(diameter2);
                translate([-(width/2-width_handle+diameter2+diameter2/2), 0]) square([diameter2, depth_handle], true);
            }
        }
        linear_extrude(height=height, scale=[scale_width, scale_handle]) {
            offset(delta=Addtional_Spacing-offset)
            hull() {
                translate([(width/2-width_handle+diameter2), -(depth_handle/2-diameter2)]) circle(diameter2);
                translate([(width/2-width_handle+diameter2), depth_handle/2-diameter2]) circle(diameter2);
                translate([(width/2-width_handle+diameter2+diameter2/2), 0]) square([diameter2, depth_handle], true);
            }
        }
    }
}

module Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset) {
    difference() {
        linear_extrude(height=height, scale = [scale_width, scale_depth]) {
            offset(delta=-Addtional_Spacing+offset) Samla_Base(layer, width, depth, height, diameter, width_cutout, scale_cutout);
        }
        Samla_HandleAndCutout(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset);
    }

}


module Grid(layer, width, depth, height, columns, rows, wall_thickness, scale_width, scale_depth) {
    if (Part == "false" || Part == "halve_row") {

        for (i=[-(columns/2-1):1:columns/2-1]) {
            translate([i*((width-wall_thickness-2*Addtional_Spacing)/columns), 0, height/2])
                cube([wall_thickness, depth*scale_depth, height], true);
        }
    }
    else if (Part == "halve_column" || Part == "quarter") {
        for (i=[0:1:columns-1]) {
            translate([i*((width-wall_thickness-2*Addtional_Spacing)/2/columns), 0, height/2])
                cube([wall_thickness, depth*scale_depth, height], true);
        }
    }

    if (Part == "false" || Part == "halve_column") {
        for (i=[-(rows/2-1):1:rows/2-1]) {
            translate([0, i*((depth-wall_thickness-2*Addtional_Spacing)/rows), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_width, height], true);
        }
    }
    else if (Part == "halve_row" || Part == "quarter") {
        for (i=[-rows+1:1:0]) {
            translate([0, i*((depth-wall_thickness-2*Addtional_Spacing)/2/rows), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_width, height], true);
        }
    }
}

module Layer_Marking_Text_Single(layer, width, depth, height, diameter, position)
{
    size = Cell_Columns >= 6 || Cell_Rows >= 6 ? 10-(max(Cell_Columns, Cell_Rows)-3) : 10;
    width_offset = Cell_Columns >= 6 || Cell_Rows >= 6 ? 22-(max(Cell_Columns, Cell_Rows)-4)-(layer/2-1)+(Cell_Columns <= 4 && layer == 10 ? 5 : 0) : 24-(layer/2-1)+(Cell_Columns <= 4 && layer == 10 ? 5 : 0);
    depth_offset = Cell_Columns >= 6 || Cell_Rows >= 6 ? 16-(max(Cell_Columns, Cell_Rows)-4)-(layer/2-1) : 18-(layer/2-1);

    bottom_offset = Layer_Marking == "inside" ? Bottom_Thickness : 0;
    rotate_y = Layer_Marking == "outside" ? 180 : 0;

    if (position == 1) {
        translate([-width/2+width_offset, depth/2-depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 180]) linear_extrude(height=Layer_Marking_Height) text(text=str(layer, "-", Layers), size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
    else if (position == 2) {
        translate([width/2-width_offset, depth/2-depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 180]) linear_extrude(height=Layer_Marking_Height) text(text=str(layer, "-", Layers), size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
    else if (position == 4) {
        translate([-width/2+width_offset, -depth/2+depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 0]) linear_extrude(height=Layer_Marking_Height) text(text=str(layer, "-", Layers), size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
    else if (position == 8) {
        translate([width/2-width_offset, -depth/2+depth_offset, bottom_offset+(height/Layers)*(layer-1)]) rotate([0, rotate_y, 0]) linear_extrude(height=Layer_Marking_Height) text(text=str(layer, "-", Layers), size=size, font="Lucida Console:style=Regular", halign="center", valign="center", spacing=1.2);
    }
}

module Layer_Marking_Text(layer, width, depth, height, diameter) {
    if (Layer_Marking_Positions == 1) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
    }
    else if (Layer_Marking_Positions == 2) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
    }
    else if (Layer_Marking_Positions == 3) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
    }
    else if (Layer_Marking_Positions == 4) {
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
    }
    else if (Layer_Marking_Positions == 5) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
    }
    else if (Layer_Marking_Positions == 6) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
    }
    else if (Layer_Marking_Positions == 7) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);

    }
    else if (Layer_Marking_Positions == 8) {
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 9) {

        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 10) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 11) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        Layer_Marking_Text_Single(width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 12) {
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 13) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 14) {
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);
    }
    else if (Layer_Marking_Positions == 15) {
        if (Part == "false") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 1);
        if (Part != "halve_row") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 2);
        if (Part != "halve_column") Layer_Marking_Text_Single(layer, width, depth, height, diameter, 4);
        Layer_Marking_Text_Single(layer, width, depth, height, diameter, 8);

    }
}

module Layer_Marking(layer, width, depth, height, diameter) {
    if ((Layer_Marking == "inside" || Layer_Marking == "outside") && Layer_Marking_Positions != 0) {
        if (Layer_Marking_Type == "engrave") {
            difference() {
                children();
                if (Layer_Marking == "inside") {
                    translate([0, 0, -Layer_Marking_Height]) Layer_Marking_Text(layer, width, depth, height, diameter);
                }
                else if (Layer_Marking == "outside") {
                    translate([0, 0, +Layer_Marking_Height]) Layer_Marking_Text(layer, width, depth, height, diameter);
                }
            }
        }
        else if (Layer_Marking_Type == "emboss") {
            children();
            if (Layer_Marking == "inside") {
                Layer_Marking_Text(layer, width, depth, height, diameter);
            }            
        }
    }
    else
    {
        children();
    }
}

module Create_Samla_Insert(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, $fn) {
    translate([0, 0, -(height/Layers)*(layer-1)]) {
        intersection() {
            union() {
                if (Test == "false") {
                    // generate grid in inner box shape
                    if (Cell_Columns>1 || Cell_Rows>1) {
                        intersection() {
                            Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            Grid(layer, width, depth, height, Cell_Columns, Cell_Rows, Wall_Thickness, scale_width, scale_depth);
                        }
                    }
                    // generate bottom
                    Layer_Marking(layer, width, depth, height, diameter) {
                        intersection() {
                            Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            translate([0, 0, (Bottom_Thickness/2)+(height/Layers)*(layer-1)]) cube([width*scale_width, depth*scale_depth, Bottom_Thickness], true);
                        }
                    }
                    // generate surrounding wall
                    difference() {
                        Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                        Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, -Wall_Thickness);
                    }
                }
                else if (Test == "true") {
                    Samla_Content(layer, width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                }
            }
            if (Test == "false") {
                // remove everything not needed for current layer
                translate([0, 0, (height/Layers/2)+(height/Layers)*(layer-1)]) cube([width*scale_width, depth*scale_depth, height/Layers], true);
            }
            else if (Test == "true") {
                translate([width-width_handle-Addtional_Spacing-Test_Offset, -depth*scale_depth/2-(depth_handle+Addtional_Spacing*2)*scale_handle/2+diameter2+Test_Offset, height/2]) cube([width, depth*scale_depth, height], true);
                translate([(width*scale_width)/2+(width_cutout*scale_cutout)/2-Test_Offset, -depth+depth_cutout+Addtional_Spacing+Test_Offset, height/2]) cube([width*scale_width, depth, height], true);
            }
        }
    }
}

start_layer = Active_Layer == 0 ? 1 : Active_Layer;
end_layer = Active_Layer == 0 ? Layers : Active_Layer;

for ( layer = [ start_layer : end_layer ] )
{
    if (Box_Size == "5")
    {
        translate( [ 0, layer * 5_depth * 5_scale_depth,0] )
            Create_Samla_Insert(layer, 5_width, 5_depth, 5_height, 5_scale_width, 5_scale_depth, 5_width_handle, 5_depth_handle, 5_width_cutout, 5_depth_cutout, 5_scale_handle, 5_scale_cutout, 5_handle_cutout_height, 5_diameter, 5_diameter2, Resolution);
    }
    else if (Box_Size == "11")
    {
        translate( [ 0, layer * 11_depth * 11_scale_depth,0] )
            Create_Samla_Insert(layer, 11_width, 11_depth, 11_height, 11_scale_width, 11_scale_depth, 11_width_handle, 11_depth_handle, 11_width_cutout, 11_depth_cutout, 11_scale_handle, 11_scale_cutout, 11_handle_cutout_height, 11_diameter, 11_diameter2, Resolution);
    }
    else if (Box_Size == "22")
    {
        translate( [ 0, layer * 22_depth * 22_scale_depth, 0,0] )
            Create_Samla_Insert(layer, 22_width, 22_depth, 22_height, 22_scale_width, 22_scale_depth, 22_width_handle, 22_depth_handle, 22_width_cutout, 22_depth_cutout, 22_scale_handle, 22_scale_cutout, 22_handle_cutout_height, 22_diameter, 22_diameter2, Resolution);
    }
}
