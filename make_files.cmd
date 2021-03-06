@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM set resolution
SET res=120

SET /p boxsize="Enter box size (5, 11, 22): "
SET /p cols="Columns: "
SET /p rows="Rows: "
SET /p layers="Layers: "
SET /p part="Part (false, halve_column, halve_row): "
SET /p wall="Wall thickness: "
SET /p bott="Bottom thickness: "
SET /p layermark="Layer marking (false, inside, outside): "
SET layermarkpos=15
SET layermarktype=engrave
SET layermarkheight=0.3
IF %layermark% NEQ false SET /p layermarkpos="Layer marking positions (15 = all corners): "
IF %layermark% NEQ false SET /p layermarktype="Layer marking type (engrave, emboss): "
IF %layermark% NEQ false SET /p layermarkheight="Layer marking height: "
SET dirname=IKEA_Samla_Inserts_%boxsize%l\%layers%_Layers\%cols%x%rows%
MKDIR %dirname%
FOR /L %%L IN (1,1,%layers%) DO (
SET filename=IKEA_Samla_Inserts_%boxsize%l_%%L-%layers%_%cols%x%rows%_%wall%x%bott%.stl
ECHO Generating '!filename!'
"C:\Program Files\OpenSCAD\openscad.com" -o %dirname%\!filename! -D "Box_Size=\"%boxsize%\";Active_Layer=%%L;Layers=%layers%;Cell_Columns=%cols%;Cell_Rows=%rows%;Resolution=%res%;Wall_Thickness=%wall%;Bottom_Thickness=%bott%;Part=\"%part%\";Layer_Marking=\"%layermark%\";Layer_Marking_Position=%layermarkpos%;Layer_Marking_Type=\"%layermarktype%\";Layer_Marking_Height=%layermarkheight%;Test=\"false\"" IKEA_Samla_Inserts.scad
)
