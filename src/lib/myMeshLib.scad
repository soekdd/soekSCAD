include <../../lib/dotSCAD/src/path_extrude.scad>;
//include <../../lib/bioinfscripts/path_extrude.scad>;
include <../../lib/dotSCAD/src/bezier_curve.scad>;
include <../../lib/dotSCAD/src/curve.scad>;

module showDot(v,c) {
    color(c)
        translate(v)
            cylinder(h=1,d=1,center=true,$fn = resolution);
};
module showDots(meshLine,c) {
    translate([0,0,borderBarHeight/2])
        for(v = meshLine) {
            showDot(v,c);
        }
};
module borderOfMesh(mesh,pBorder,resolution){
    nY = len(mesh[0]) - 1;
    nX = len(mesh) - 1;
    stepSmooth = 1/(resolution*2);
/*    pBorder0 = curve(stepSmooth,[mesh[0][0],for (m=mesh[0]) m,mesh[0][nY]]);
    pBorder1 = curve(stepSmooth,[mesh[0][nY],for (m=mesh) m[nY],mesh[nX][nY]]);
    pBorder2 = curve(stepSmooth,[mesh[nX][0],for (m=mesh[nX]) m,mesh[nX][nY]]);
    pBorder3 = curve(stepSmooth,[mesh[0][0],for (m=mesh) m[0],mesh[nX][0]]);*/
    pBorder0 = curve(stepSmooth,[mesh[0][0]+(mesh[0][0]-mesh[0][1]),for (m=mesh[0]) m,mesh[0][nY]+(mesh[0][nY]-mesh[0][nY-1])]);
    pBorder1 = curve(stepSmooth,[mesh[0][nY]+(mesh[0][nY]-mesh[1][nY]),for (m=mesh) m[nY],mesh[nX][nY]+(mesh[nX][nY]-mesh[nX-1][nY])]);
    pBorder2 = curve(stepSmooth,[mesh[nX][0]+(mesh[nX][0]-mesh[nX][1]),for (m=mesh[nX]) m,mesh[nX][nY]+(mesh[nX][nY]-mesh[nX][nY-1])]);
    pBorder3 = curve(stepSmooth,[mesh[0][0]+(mesh[0][0]-mesh[1][0]),for (m=mesh) m[0],mesh[nX][0]+(mesh[nX][0]-mesh[nX-1][0])]);
    /*test = [for (m=pBorder2) [m[0],m[1]]];
    polygon(test);*/
    borders = [pBorder0,pBorder1,pBorder2,pBorder3];
    union() {                                       // creates borders
                                                    // creates 4 corners
        for (vCorner = [mesh[0][0],mesh[nX][0],mesh[0][nY],mesh[nX][nY]])
            translate(vCorner)                       // move the corners to its places
                rotate_extrude($fn=resolution*2)    // rotate_extrude expects only polygons with x>0 (x axis is rotation axis)
                    intersection() {                // cut the negative parts
                        polygon(points = [[-5,5],[0,5],[0,-5],[-5,-5]]); // create a big polygon with x<0
                        polygon(points = pBorder); // the border polygon 
                    }
                                                    // creates the border curves
        for(x = [0:3]) {
            //echo(pBorder);
            //echo(borders[x]);
            path_extrude(pBorder, borders[x],method = "EULER_ANGLE");
        }
    }
}
module wickerOfMesh(mesh,pWicker,fWaveHeight,resolution) {
    nY = len(mesh[0]) - 1;
    nX = len(mesh) - 1;
    stepSmooth = 1/(resolution);
    meshH = [for(x = [0:nX]) [mesh[x][0]+(mesh[0][0]-mesh[0][1]),mesh[x][0],
        for(y = [1:nY-1]) [mesh[x][y][0],mesh[x][y][1],(((x+y)%2)*2-1)*fWaveHeight], mesh[x][nY], mesh[x][nY]+(mesh[0][nY]-mesh[0][nY-1])]];        
    meshV = [for(y = [0:nY]) [mesh[0][y],mesh[0][y],
        for(x = [1:nX-1]) [mesh[x][y][0],mesh[x][y][1],(((x+y+1)%2)*2-1)*fWaveHeight],
        mesh[nX][y], mesh[nX][y]]];
    pWickerH = [for(x = [0:nX]) curve(stepSmooth,meshH[x])];
    pWickerV = [for(y = [0:nY]) curve(stepSmooth,meshV[y])];
    for(x = [1:nX-1]) {
        path_extrude(pWicker, pWickerH[x], method = "EULER_ANGLE");
    }
    for(y = [1:nY-1]) {
        path_extrude(pWicker, pWickerV[y], method = "EULER_ANGLE");
    }
}

function myShapes(width,height,resolution) = 
    [circlePath(width,height,resolution*2),
    quadPath(width,height),
    [[0,height/2],[width/2,0],[0,-height/2],[-width/2,0]]
    ];

function reverse(list) = 
    [for(i = [len(list)-1:-1:0]) list[i]];
function quadPath(width,height) = 
    [[-width/2,height/2],[width/2,height/2],[width/2,-height/2],[-width/2,-height/2]];    
function circlePath(radiusX,radiusY, fn) = 
    [for(i = [0 :  360 / fn: 360 - 360 / fn])  
        [radiusX * cos(i)/2, radiusY * sin(i)/2]];  
function avgRel(v1,v2,rel) = 
    [v1[0]*rel+v2[0]*(1-rel),v1[1]*rel+v2[1]*(1-rel),v1[2]*rel+v2[2]*(1-rel)];
function avg(v1,v2) = 
    [(v1[0]+v2[0])/2,(v1[1]+v2[1])/2,(v1[2]+v2[2])/2];

function calculateMesh(vLeftTop,vRightTop,vRightBottom,vLeftBottom,linesCountX,linesCountY,vDiff,resolution,ft=1,fb=1,fl=1,fr=1,fc=1) =     
    let (stepMeshY = 1/(linesCountY-1),
        stepMeshX = 1/(linesCountX-1),
        stepHelper = 1/2,
        stepSmooth = 1/(resolution*2),
        aHelperTop =                           // get center point of top line 
            bezier_curve(stepHelper, [vLeftTop,avg(vLeftTop,vRightTop)+vDiff*ft,vRightTop]),
        pMeshTop =                              // get path of top line
            bezier_curve(stepMeshX, [vLeftTop,avg(vLeftTop,vRightTop)+vDiff*ft,vRightTop]),
        aHelperBottom =                         // get center point of bottom line 
            bezier_curve(stepHelper, [vLeftBottom,avg(vLeftBottom,vRightBottom)+vDiff*fb,vRightBottom]),
        pMeshBottom =                           // get path of bottom line 
            bezier_curve(stepMeshX, [vLeftBottom,avg(vLeftBottom,vRightBottom)+vDiff*fb,vRightBottom]),   
        aHelperLeft =                           // get center point of left line
            bezier_curve(stepHelper, [vLeftTop,avg(vLeftTop,vLeftBottom)+vDiff*fl,vLeftBottom]),
        pMeshLeft =                             // get path of left line 
            bezier_curve(stepMeshY, [vLeftTop,avg(vLeftTop,vLeftBottom)+vDiff*fl,vLeftBottom]),
        aHelperRight =                          // get center point of right line
            bezier_curve(stepHelper, [vRightTop,avg(vRightTop,vRightBottom)+vDiff*fr,vRightBottom]),
        pMeshRight =                            // get path of right line 
            bezier_curve(stepMeshY, [vRightTop,avg(vRightTop,vRightBottom)+vDiff*fr,vRightBottom]),
        vCenter =                               // center point 
            avg(avg(vLeftTop,vLeftBottom),avg(vRightTop,vRightBottom))+vDiff*fc,
        pCenterMeshHorizontal =                 // get path of horizontal center line
            bezier_curve(stepMeshX,[aHelperLeft[1],vCenter,aHelperRight[1]]),
        pCenterMeshVertical =                   // get path of vertical center line
            bezier_curve(stepMeshY,[aHelperTop[1],vCenter,aHelperBottom[1]]),
        apMeshHLines = [for(y = [0:linesCountY-1])// array of horizontal pathes
            bezier_curve(stepMeshX,[pMeshLeft[y],pCenterMeshVertical[y],pMeshRight[y]])],
        apMeshVLines = [for(x = [0:linesCountX-1])// array of vertical pathes
            bezier_curve(stepMeshY,[pMeshTop[x],pCenterMeshHorizontal[x],pMeshBottom[x]])])
    [for(x = [0:linesCountX-1]) [               // avg mesh of vertical and horizontal mesh points
        for(y = [0:linesCountY-1]) avg(apMeshHLines[y][x],apMeshVLines[x][y]) ]];
