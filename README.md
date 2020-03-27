# IKEA-Samla-Inserts
OpenSCAD script to generate inserts for IKEA Samla boxes

## Features
- inserts for 5, 11 and 22 liters boxes
- adjustable grid
- adjustable bottom thickness and wall thickness
- splittable insert layers

## WARNING!!! WIP!!!
This is still work-in-progress! Pull requests welcome!

I printed 5 liters inserts for about three boxes with various layer settings and the 5 liters settings are
pretty much nailed and spot on.

But 11 and 22 liters settings are not! I am testing 11 liters inserts at the very moment and also found that I need
a correction for the cutout width which I added in a recent commit (-3).

I think I will have to change the scaling for 11 and 22 liters too at least a little bit, it seems the upper inserts are
getting a little too wide.

## Usage
- Get and install [OpenSCAD](https://www.openscad.org/).
- Load the script and adjust the values, generate all the STL you need for one box.
- Print! :P

## Tips
The initial values for bottom and wall thickness are base on my settings for a 0.4mm nozzle with a 0.3mm layer height.

I use 0.44mm as the extrusion width of my nozzle with Colorfabb's PLA Economy.
I do 3 bottom layers.
My first layer is set to 90% so 0.3 * 0.9 + 2 * 0.3 = 0.87.

That's where the values come from.

I have the best printing results with these setting because that way I get two perimater lines for the outer walls
and the grid walls which works bets.

I also tried using a 0.8mm nozzle with just one line for the walls. Layer adhesion was pretty good with litterally no cooling
(10% fan speed) but I had issues with the moving paths and retractions leading to non-touching walls so I can't recommend this.
