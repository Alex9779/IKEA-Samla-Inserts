@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM set resolution
SET res=64

SET /p boxsize="Enter box size (5, 11, 22) [5]: " || SET boxsize=5
SET /p cols="Columns [2]: " || SET cols=2
SET /p rows="Rows [3]: " || SET rows=3
SET /p layers="Layers [3]: " || SET layers=3
SET /p part="Part (false, halve_column, halve_row) [false]: " || SET part=false
SET /p wall="Wall thickness [0.75]: " || SET wall=0.75
SET /p bott="Bottom thickness [0.87]: " || SET bott=0.87
SET /p layermark="Layer marking (false, inside, outside) [inside]: " || SET layermark=inside
IF %layermark% NEQ false SET /p layermarkpos="Layer marking positions (15 = all corners) [15]: " || SET layermarkpos=15
IF %layermark% NEQ false SET /p layermarktype="Layer marking type (engrave, emboss) [engrave]: " || SET layermarktype=engrave
IF %layermark% NEQ false SET /p layermarkheight="Layer marking height [0.3]: " || SET layermarkheight=0.3

SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Layers=%layers%;Active_layer=%%L;Cell_columns=%cols%;Cell_rows=%rows%;Part=\"%part%\";Layer_marking=\"%layermark%\";Layer_marking_position=%layermarkpos%;Layer_marking_type=\"%layermarktype%\";Layer_marking_height=%layermarkheight%;Wall_thickness=%wall%;Bottom_thickness=%bott%;Resolution=%res%" IKEA_Samla_Inserts.scad
)
