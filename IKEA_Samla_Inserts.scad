// Box size
Box_Size = "5"; // ["5":5 liters,"11":11 liters,"22":22 liters]

// Layer to generate (boxes get wider to the top so)
Active_Layer = 1; // [1:10]

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

// Halve (just print half a layer)
Halve = "row"; // ["false":false, "column":column, "row":row]

// Layer marking
Layer_Marking = "false"; // ["false":false, "true":true]

// Layer marking position(s)
Layer_Marking_Positions = 0; // [0:none, 1:ul, 2:ur, 3:ul+ur, 4:ll, 5:ul+ll, 6:ur+ll, 7:ul+ur+ll, 8:lr, 9:ul+lr, 10:ur+lr, 11:ul+ur+lr, 12:ll+lr, 13:ul+ll+lr, 14:ur+ll+lr, 15:ul+ur+ll+lr]

// Layer marking type
Layer_Marking_Type = "engrave"; // ["engrave":engrave, "emboss":emboss]

// Layer marking height
Layer_Marking_Height = 0.3;

// Layer marking size
Layer_Marking_Size = 7;

// Resolution used to render curved surfaces (experiment with low resolutions, and render the final results with higher resolution settings)
Resolution = 30; // [30:Low (12 degrees), 60:Medium (6 degrees), 120:High (3 degrees)]

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
22_height = 257;
22_scale_width = 1.115;
22_scale_depth = 1.115;
22_width_handle = 17;
22_depth_handle = 123;
22_width_cutout = 22_width-(22_depth-22_depth_handle)-10;
22_depth_cutout = 2.5;
22_scale_handle = 0.78;
22_scale_cutout = 0.86;
22_handle_cutout_height = 207;
22_diameter = 18;
22_diameter2 = 12;

module Samla_Base(width, depth, height, diameter, width_cutout, scale_cutout) {
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
            translate([-(width/2-diameter)-diameter, Addtional_Spacing/2-diameter]) square(diameter, false);
            translate([-(width/2-diameter), -(depth/2-diameter)]) circle(diameter);
            translate([width/2-diameter, Addtional_Spacing/2-diameter]) square(diameter, false);
            translate([width/2-diameter, -(depth/2-diameter)]) circle(diameter);
        }
    }
}

module Samla_HandleAndCutout(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset) {
    if ((height/Layers)*(Active_Layer-1)<handle_cutout_height) {
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

module Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset) {
    difference() {
        linear_extrude(height=height, scale = [scale_width, scale_depth]) {
            offset(delta=-Addtional_Spacing+offset) Samla_Base(width, depth, height, diameter, width_cutout, scale_cutout);
        }
        Samla_HandleAndCutout(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, offset);
    }

}

module Grid(width, depth, height, columns, rows, wall_thickness, scale_width, scale_depth) {
    if (Halve == "false" || Halve == "row") {
        for (i=[-(columns/2-1):1:columns/2-1]) { 
            translate([i*((width-wall_thickness-2*Addtional_Spacing)/columns), 0, height/2])
                cube([wall_thickness, depth*scale_depth, height], true);
        }
    }
    else if (Halve == "column") {
        for (i=[0:1:columns-1]) {
            translate([i*((width-wall_thickness-2*Addtional_Spacing)/2/columns), 0, height/2])
                cube([wall_thickness, depth*scale_depth, height], true);
        }
    }

    if (Halve == "false" || Halve == "column") {
        for (i=[-(rows/2-1):1:rows/2-1]) {
            translate([0, i*((depth-wall_thickness-2*Addtional_Spacing)/rows), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_width, height], true);
        }
    }
    else if (Halve == "row") {
        for (i=[0:1:rows-1]) {
            translate([0, i*((depth-wall_thickness-2*Addtional_Spacing)/2/rows), height/2])
                rotate([0, 0, 90])
                cube([wall_thickness, width*scale_width, height], true);
        }
    }
}

module Layer_Marking_Text_Single(width, depth, diameter, position)
{
    width_offset = diameter/2+Layer_Marking_Size+(log(Layer_Marking_Size <= 10 ? 10 : Layer_Marking_Size)-1)*25;
    depth_offset = diameter/2+Layer_Marking_Size-(log(Layer_Marking_Size <= 10 ? 10 : Layer_Marking_Size)-1)*30;
    if (position == 1) {
        translate([-width/2+width_offset, depth/2-depth_offset, Bottom_Thickness]) linear_extrude(height=Layer_Marking_Height) text(text=str(Active_Layer, "/", Layers), size=Layer_Marking_Size, halign="center", valign="center");
    }
    else if (position == 2) {
        translate([width/2-width_offset, depth/2-depth_offset, Bottom_Thickness]) linear_extrude(height=Layer_Marking_Height) text(text=str(Active_Layer, "/", Layers), size=Layer_Marking_Size, halign="center", valign="center");
    }
    else if (position == 4) {
        translate([-width/2+width_offset, -depth/2+depth_offset, Bottom_Thickness]) linear_extrude(height=Layer_Marking_Height) text(text=str(Active_Layer, "/", Layers), size=Layer_Marking_Size, halign="center", valign="center");
    }
    else if (position == 8) {
        translate([width/2-width_offset, -depth/2+depth_offset, Bottom_Thickness]) linear_extrude(height=Layer_Marking_Height) text(text=str(Active_Layer, "/", Layers), size=Layer_Marking_Size, halign="center", valign="center");
    }
}

module Layer_Marking_Text(width, depth, diameter) {
     
    if (Layer_Marking_Positions == 1) {
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
    }
    else if (Layer_Marking_Positions == 2) {
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
    }
    else if (Layer_Marking_Positions == 3) {
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
    }
    else if (Layer_Marking_Positions == 4) {        
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
    }
    else if (Layer_Marking_Positions == 5) {        
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
    }
    else if (Layer_Marking_Positions == 6) {        
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
        Layer_Marking_Text_Single(width, depth, diameter, 4);
    }
    else if (Layer_Marking_Positions == 7) {        
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        Layer_Marking_Text_Single(width, depth, diameter, 2);
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
    }
    else if (Layer_Marking_Positions == 8) {        
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 9) {        
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 10) {        
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 11) {                
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 12) {        
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 13) {        
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 14) {        
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
    else if (Layer_Marking_Positions == 15) {        
        if (Halve == "false") Layer_Marking_Text_Single(width, depth, diameter, 1);
        if (Halve != "row") Layer_Marking_Text_Single(width, depth, diameter, 2);
        if (Halve != "column") Layer_Marking_Text_Single(width, depth, diameter, 4);
        Layer_Marking_Text_Single(width, depth, diameter, 8);
    }
}

module Layer_Marking(width, depth, diameter) {
    if (Layer_Marking == "true" && Layer_Marking_Positions != 0) {
        if (Layer_Marking_Type == "engrave") {
            difference() {
                children();
                translate([0, 0, -Layer_Marking_Height]) Layer_Marking_Text(width, depth, diameter);
            }
        }
        else if (Layer_Marking_Type == "emboss") {
            children();
            #Layer_Marking_Text(width, depth, diameter);
        }
    }
    else
    {
        children();
    }
}

module Create_Samla_Insert(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, $fn) {
    translate([0, 0, -(height/Layers)*(Active_Layer-1)]) {
        intersection() {
            union() {
                if (Test == "false") {
                    // generate grid in inner box shape
                    if (Cell_Columns>1 || Cell_Rows>1) {
                        intersection() {
                            Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            Grid(width, depth, height, Cell_Columns, Cell_Rows, Wall_Thickness, scale_width, scale_depth);
                        }
                    }
                    // generate bottom
                    Layer_Marking(width, depth, diameter) {
                        intersection() {
                            Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                            translate([0, 0, (Bottom_Thickness/2)+(height/Layers)*(Active_Layer-1)]) cube([width*scale_width, depth*scale_depth, Bottom_Thickness], true);
                        }
                    }
                    // generate surrounding wall
                    difference() {
                        Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                        Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, -Wall_Thickness);
                    }
                }
                else if (Test == "true") {
                    Samla_Content(width, depth, height, scale_width, scale_depth, width_handle, depth_handle, width_cutout, depth_cutout, scale_handle, scale_cutout, handle_cutout_height, diameter, diameter2, 0);
                }
            }
            if (Test == "false") {
                // remove everything not needed for current layer
                translate([0, 0, (height/Layers/2)+(height/Layers)*(Active_Layer-1)]) cube([width*scale_width, depth*scale_depth, height/Layers], true);
            }
            else if (Test == "true") {
                translate([width-width_handle-Addtional_Spacing-Test_Offset, -depth*scale_depth/2-(depth_handle+Addtional_Spacing*2)*scale_handle/2+diameter2+Test_Offset, height/2]) cube([width, depth*scale_depth, height], true);
                translate([(width*scale_width)/2+(width_cutout*scale_cutout)/2-Test_Offset, -depth+depth_cutout+Addtional_Spacing+Test_Offset, height/2]) cube([width*scale_width, depth, height], true);
            }
        }
    }
}

if (Active_Layer <= Layers) {
    if (Box_Size == "5")
    {
        Create_Samla_Insert(5_width, 5_depth, 5_height, 5_scale_width, 5_scale_depth, 5_width_handle, 5_depth_handle, 5_width_cutout, 5_depth_cutout, 5_scale_handle, 5_scale_cutout, 5_handle_cutout_height, 5_diameter, 5_diameter2, Resolution);
    }
    else if (Box_Size == "11")
    {
        Create_Samla_Insert(11_width, 11_depth, 11_height, 11_scale_width, 11_scale_depth, 11_width_handle, 11_depth_handle, 11_width_cutout, 11_depth_cutout, 11_scale_handle, 11_scale_cutout, 11_handle_cutout_height, 11_diameter, 11_diameter2, Resolution);
    }
    else if (Box_Size == "22")
    {
        Create_Samla_Insert(22_width, 22_depth, 22_height, 22_scale_width, 22_scale_depth, 22_width_handle, 22_depth_handle, 22_width_cutout, 22_depth_cutout, 22_scale_handle, 22_scale_cutout, 22_handle_cutout_height, 22_diameter, 22_diameter2, Resolution);
    }
}