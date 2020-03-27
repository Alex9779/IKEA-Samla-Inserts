@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM set resolution
SET res=120

REM REM 3x3 4 layers
SET boxsize=22
SET cols=3
SET rows=3
SET layers=4
SET wall=0.88
SET bott=0.87
SET halve=column
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%cols%x%rows%_%%L-%layers%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o !filename! -D "Box_Size=\"%boxsize%\";Active_Layer=%%L;Layers=%layers%;Cell_Columns=%cols%;Cell_Rows=%rows%;Resolution=%res%;Wall_Thickness=%wall%;Bottom_Thickness=%bott%;Halve=\"%halve%\"" IKEA_Samla_Inserts.scad
)