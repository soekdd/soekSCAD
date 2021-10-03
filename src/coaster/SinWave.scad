include <../lib/myMeshLib.scad>
linesCountX = 10;
linesCountY = 10;
meshBarWidth = 5.5;
meshBarHeight = 2.5;
width = 100;
height = 100;
xAmplitude = -5;
xOffset = 90;
yAmplitude = 5;
yOffset = 90;
waveHeight = 1.8;
borderBarWidth = 5;
borderBarHeight = meshBarHeight + 2 * waveHeight;
resolution = 12;
wickerShape = 0;// [0:elipse, 1:bar, 2:rhombus, -1:no border]
borderShape = 1;// [0:elipse, 1:bar, 2:rhombus, -1:no border]
debug = 0;// [0:off, 1:on]

distX = width / linesCountX;
distY = height / linesCountY;
pMasterWave = [for(x = [0:linesCountX -1]) [ x * distX, xAmplitude*sin(xOffset+x*360/(linesCountX-1)),0]];

a2DMesh =  [for(y = [0:linesCountY-1]) [               // avg mesh of vertical and horizontal mesh points
                for(x = [0:linesCountX-1]) [pMasterWave[x][0]+yAmplitude*sin(yOffset+y*360/(linesCountY-1)),pMasterWave[x][1]+y*distY,pMasterWave[x][2]] ]];
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