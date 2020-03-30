@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM set resolution
SET res=120

SET /p boxsize="Enter box size (5, 11, 22): "
SET /p cols="Columns: "
SET /p rows="Rows: "
SET /p layers="Layers: "
SET /p wall="Wall thickness: "
SET /p bott="Bottom thickness: "
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%cols%x%rows%_%wall%x%bott%_%%L-%layers%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o !filename! -D "Box_Size=\"%boxsize%\";Active_Layer=%%L;Layers=%layers%;Cell_Columns=%cols%;Cell_Rows=%rows%;Resolution=%res%;Wall_Thickness=%wall%;Bottom_Thickness=%bott%;Halve=\"false\";Test=\"false\"" IKEA_Samla_Inserts.scad
)
