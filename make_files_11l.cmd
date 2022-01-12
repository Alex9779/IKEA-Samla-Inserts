@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM set resolution
SET res=64

REM REM 2x2 2 layers
SET boxsize=11
SET cols=2
SET rows=2
SET layers=2
SET wall=0.75
SET bott=0.87
SET part=halve_column
SET layermark=inside
SET layermarkpos=15
SET layermarktype=engrave
SET layermarkheight=0.3
SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Layers=%layers%;Active_layer=%%L;Cell_columns=%cols%;Cell_rows=%rows%;Part=\"%part%\";Layer_marking=\"%layermark%\";Layer_marking_position=%layermarkpos%;Layer_marking_type=\"%layermarktype%\";Layer_marking_height=%layermarkheight%;Wall_thickness=%wall%;Bottom_thickness=%bott%;Resolution=%res%" IKEA_Samla_Inserts.scad
)

REM REM 2x2 3 layers
SET boxsize=11
SET cols=2
SET rows=2
SET layers=3
SET wall=0.75
SET bott=0.87
SET part=halve_column
SET layermark=inside
SET layermarkpos=15
SET layermarktype=engrave
SET layermarkheight=0.3
SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Layers=%layers%;Active_layer=%%L;Cell_columns=%cols%;Cell_rows=%rows%;Part=\"%part%\";Layer_marking=\"%layermark%\";Layer_marking_position=%layermarkpos%;Layer_marking_type=\"%layermarktype%\";Layer_marking_height=%layermarkheight%;Wall_thickness=%wall%;Bottom_thickness=%bott%;Resolution=%res%" IKEA_Samla_Inserts.scad
)

REM REM 3x3 3 layers
SET boxsize=11
SET cols=3
SET rows=3
SET layers=3
SET wall=0.75
SET bott=0.87
SET part=halve_column
SET layermark=inside
SET layermarkpos=15
SET layermarktype=engrave
SET layermarkheight=0.3
SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Layers=%layers%;Active_layer=%%L;Cell_columns=%cols%;Cell_rows=%rows%;Part=\"%part%\";Layer_marking=\"%layermark%\";Layer_marking_position=%layermarkpos%;Layer_marking_type=\"%layermarktype%\";Layer_marking_height=%layermarkheight%;Wall_thickness=%wall%;Bottom_thickness=%bott%;Resolution=%res%" IKEA_Samla_Inserts.scad
)

REM REM 2x2 4 layers
SET boxsize=11
SET cols=2
SET rows=2
SET layers=4
SET wall=0.75
SET bott=0.87
SET part=halve_column
SET layermark=inside
SET layermarkpos=15
SET layermarktype=engrave
SET layermarkheight=0.3
SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Layers=%layers%;Active_layer=%%L;Cell_columns=%cols%;Cell_rows=%rows%;Part=\"%part%\";Layer_marking=\"%layermark%\";Layer_marking_position=%layermarkpos%;Layer_marking_type=\"%layermarktype%\";Layer_marking_height=%layermarkheight%;Wall_thickness=%wall%;Bottom_thickness=%bott%;Resolution=%res%" IKEA_Samla_Inserts.scad

REM REM 3x3 4 layers
SET boxsize=11
SET cols=3
SET rows=3
SET layers=4
SET wall=0.75
SET bott=0.87
SET part=halve_column
SET layermark=inside
SET layermarkpos=15
SET layermarktype=engrave
SET layermarkheight=0.3
SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Layers=%layers%;Active_layer=%%L;Cell_columns=%cols%;Cell_rows=%rows%;Part=\"%part%\";Layer_marking=\"%layermark%\";Layer_marking_position=%layermarkpos%;Layer_marking_type=\"%layermarktype%\";Layer_marking_height=%layermarkheight%;Wall_thickness=%wall%;Bottom_thickness=%bott%;Resolution=%res%" IKEA_Samla_Inserts.scad
)