@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

REM set resultion
SET res=120

REM REM 3x3 4 layers
SET boxsize=22
SET cols=3
SET rows=3
SET layers=4
SET wall=0.84
SET bott=0.57
FOR /L %%L IN (1,1,%layers%) DO (
ECHO Generating 'IKEA_Samla_Inserts_%cols%x%rows%_%%L-%layers%.stl'
"C:\Program Files\OpenSCAD\openscad.com" -o IKEA_Samla_Inserts_%cols%x%rows%_%%L-%layers%.stl -D "Box_Size=\"%boxsize%\";Active_Layer=%%L;Layers=%layers%;Cell_Columns=%cols%;Cell_Rows=%rows%;Resolution=%res%;Wall_Thickness=%wall%;Bottom_Thickness=%bott%;" IKEA_Samla_Inserts.scad
)