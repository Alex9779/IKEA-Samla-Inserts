@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

SET res=120

REM REM 2x2 3 layers
SET cols=2
SET rows=2
SET layers=3
SET wall=0.8
SET bott=0.8
FOR /L %%L IN (1,1,%layers%) DO (
ECHO Generating 'IKEA_Samla_11l_Inserts_%cols%x%rows%_%%L-%layers%.stl'
"C:\Program Files\OpenSCAD\openscad.com" -o IKEA_Samla_11l_Inserts_%cols%x%rows%_%%L-%layers%.stl -D "Active_Layer=%%L;Layers=%layers%;Cell_Columns=%cols%;Cell_Rows=%rows%;Resolution=%res%;Wall_Thickness=%wall%;Bottom_Thickness=%bott%;" IKEA_Samla_11l_Inserts.scad
)

REM REM 3x3 4 layers
SET cols=3
SET rows=3
SET layers=4
SET wall=0.8
SET bott=0.8
FOR /L %%L IN (1,1,%layers%) DO (
ECHO Generating 'IKEA_Samla_11l_Inserts_%cols%x%rows%_%%L-%layers%.stl'
"C:\Program Files\OpenSCAD\openscad.com" -o IKEA_Samla_11l_Inserts_%cols%x%rows%_%%L-%layers%.stl -D "Active_Layer=%%L;Layers=%layers%;Cell_Columns=%cols%;Cell_Rows=%rows%;Resolution=%res%;Wall_Thickness=%wall%;Bottom_Thickness=%bott%;" IKEA_Samla_11l_Inserts.scad
)