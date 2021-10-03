include <../lib/myMeshLib.scad>
linesCountY = 10;
linesCountX = 10;
meshBarWidth = 5.5;
meshBarHeight = 2.5;
waveHeight = 1.8;
borderBarWidth = 5;
borderBarHeight = meshBarHeight + 2 * waveHeight;
resolution = 12;
leftTop = [0,0,0];
rightTop = [100,0,0];
leftBottom = [0,-100,0];
rightBottom = [100,-100,0];
diff = [20,20,0];
factorTop = 1; // [-2,-1.5,-1,-0.5,0,0.5,1,1.5,2]
factorBottom = 1; // [-2,-1.5,-1,-0.5,0,0.5,1,1.5,2]
factorLeft = 1; // [-2,-1.5,-1,-0.5,0,0.5,1,1.5,2]
factorRight = 1;// [-2,-1.5,-1,-0.5,0,0.5,1,1.5,2]
factorCenter = 1;// [-2,-1.5,-1,-0.5,0,0.5,1,1.5,2]
wickerShape = 0;// [0:elipse, 1:bar, 2:rhombus, -1:no border]
borderShape = 1;// [0:elipse, 1:bar, 2:rhombus, -1:no border]
debug = 0;// [0:off, 1:on]
    
a2DMesh = calculateMesh(leftTop,rightTop,rightBottom,leftBottom,linesCountX,linesCountY,diff,resolution,factorTop,factorBottom,factorLeft,factorRight,factorCenter);

if (borderShape>-1) {
    pBorder = myShapes(borderBarWidth,borderBarHeight,resolution)[borderShape];
	borderOfMesh(a2DMesh,pBorder,resolution);
}
if (wickerShape>-1) {
    pWicker = myShapes(meshBarWidth,meshBarHeight,resolution)[wickerShape];
    wickerOfMesh(a2DMesh,pWicker,waveHeight,resolution);
}
if (debug==1) {                                 // debug
    for(x = [0:linesCountX-1]) {
        showDots(a2DMesh[x],"white");
    }
}