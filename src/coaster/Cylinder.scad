include <../lib/myMeshLib.scad>
linesCountY = 14;
linesCountX = 20;
cylinderRadius = 50;
cylinderHeight = 150;
meshBarWidth = 5.5;
meshBarHeight = 2.5;
waveHeight = 1.8;
borderBarWidth = 5;
borderBarHeight = meshBarHeight + 2 * waveHeight;
resolution = 12;
wickerShape = 0;// [0:elipse, 1:bar, 2:rhombus, -1:no border]
borderShape = 1;// [0:elipse, 1:bar, 2:rhombus, -1:no border]

    
rotate([90,0,0])
    if (wickerShape>-1) {
    pWicker = myShapes(meshBarWidth,meshBarHeight,resolution)[wickerShape];
    union(){
    rotate([0,360*4/linesCountX,0])
        wickerCylinder(linesCountX,linesCountY,cylinderRadius,cylinderHeight,pWicker,waveHeight,resolution);
    wickerCylinder(linesCountX,linesCountY,cylinderRadius,cylinderHeight,pWicker,waveHeight,resolution);
    }
}

if (borderShape>-1) {
    pBorder = myShapes(borderBarWidth,borderBarHeight,resolution)[borderShape];
    pCircle = [for(alpha = [0:360]) [sin(alpha)*cylinderRadius,cos(alpha)*cylinderRadius]];
	path_extrude(pBorder, pCircle, method = "EULER_ANGLE");
    translate([0,0,cylinderHeight])
        path_extrude(pBorder, pCircle, method = "EULER_ANGLE");
}
