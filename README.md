# IKEA-Samla-Inserts
OpenSCAD script to generate inserts for IKEA Samla boxes

## Features
- inserts for 5, 11 and 22 liters boxes
- adjustable grid
- adjustable bottom thickness and wall thickness
- splittable insert layers

## WARNING!!! WIP!!!
This is still work-in-progress! Pull requests welcome!

I did a lot of test prints and now the 5 liters seems to be really good.

11 liters are also find, maybe a little more fine tuning needed.

I still didn't print a 22 liters insert or a whole set for a box so just a test print which looks promising.

## Usage
- Get and install [OpenSCAD](https://www.openscad.org/).
- Load the script and adjust the values, generate all the STL you need for one box.
- Print! :P

## Tips
The initial values for bottom and wall thickness are base on my settings for a 0.4mm nozzle with a 0.3mm layer height.

I do 3 bottom layers.
My first layer is set to 90% so 0.3 * 0.9 + 2 * 0.3 = 0.87.

That's where the values come from.

I have the best printing results with these setting because that way I get two perimeter lines for the outer walls
and the grid walls.

I also tried using a 0.8mm nozzle with just one line for the walls. Layer adhesion was pretty good with litterally no cooling
(10% fan speed) but I had issues with the moving paths and retractions leading to non-touching walls so I can't recommend this.

I am still playing with the print settings to get a nice bottom finish and good wall adhesion. Still I think two perimeters for a wall are better than printing just one wall line.

Maybe get a simple small hollow box to test your settings, but be aware, very long straight extrusions may behave a little different than a short one...