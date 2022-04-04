include <front.scad>
include <../../lib/dotSCAD/src/path_extrude.scad>;
include <../../lib/dotSCAD/src/bezier_curve.scad>;
include <../../lib/dotSCAD/src/curve.scad>;
include <../leaves/maple.scad>
include <../leaves/simple.scad>
treeDebug = 0;
leafScale = 2;
resolution = 30; 
stepSmooth = 1/(resolution*2);
truncHeight = 4;
truncMinWidth = 8; // 4
function truncShape(truncWidth)=
    [   
      [truncWidth/2,0],
      [-truncWidth/2,0],
      [-truncWidth*0.3,truncHeight*0.8],
      [0,truncHeight],
      [truncWidth*0.3,truncHeight*0.8]
    ];

module branch(pBranch,width,index,leaves=1){ 
    union() {
        pShape = truncShape(width+truncMinWidth);
        if (leaves != 2)
            translate([0,0,-0.1])
                path_extrude(pShape, pBranch, method = "EULER_ANGLE");
        branchAngle = atan2(pBranch[2][1]-pBranch[1][1],
                                   pBranch[2][0]-pBranch[1][0]);
        angle = index == 0 ? branchAngle - 90
            : (-90 + 65 * ( index % 2 ==0 ? -1 : 1 ) + branchAngle);
        bow = index == 0 ? 0
            : ( ( index % 2 > 0 ? 1 : -1 ) * floor( index / 2 ) );
                              //3
        if (width<25 && index % 5 ==0) {
            if (treeDebug  == 1) color([0,1,0]) translate([pBranch[2][0],pBranch[2][1]]) cylinder(5,5,5);
            if (leaves != 0 && leaves != 3) {
                    mapleLeaf(pBranch[2][0],
                          pBranch[2][1],
                          angle,
                          pBranch[2][0]*5000+pBranch[2][1],bow,leafScale);
            } else if (leaves == 3) {
                    simpleLeaf(pBranch[2][0],
                          pBranch[2][1],
                          angle,
                          pBranch[2][0]*5000+pBranch[2][1],bow,leafScale);
            }
        }
    }
}

function getBranchType(w,b) = 
    ((w>=b[0])?0:((w>=b[1])?1:((w>=b[2])?2:3)));
function inc(a,b)=a+1;

module tree(aBezier,num,leaves=1){
    /*for(dot = aBezier)
        translate([dot[0],dot[1],10])
            color([1,0,0])
                cylinder(10,10,10);*/
    nextBranch = [90,40,2,0];
    mod = [25,15,7,99999];
    direct = [0,1,1,1];
    angle = [25,30,35,99];
/*    nextBranch = [90,40,2,0];
    mod = [25,15,6,99999];
    direct = [0,1,1,0];
    angle = [25,30,35,99];*/

    colors = [[0,0,1],[1,0,0],[1,1,0],[0,0,0]];
    counterDiff = 0;
    path = bezier_curve(1/(num-1),aBezier);
    branchDiff = [0,len(path)-nextBranch[0],
        len(path)-(nextBranch[1]),
        len(path)-(nextBranch[2])];
    union()
    for(index = [2:len(path)-1]) {
        pBranch = [path[index-2],path[index-1],path[index]];
        steps2End = len(path)-index-1;
        newWidth = steps2End;
        branch(pBranch,newWidth,steps2End,leaves);
        shorten = floor(steps2End*0.45);
        branchType = getBranchType(steps2End,nextBranch);
        branchCounter =  index - branchDiff[ branchType ];
        if (treeDebug == 1) 
            translate(pBranch[0])
                        color([1,1,1]) 
                            cylinder(h=10,r=5);
        if (newWidth>1 && (len(path)<10 || index>5)) {
            pSubBranch = [for(subIndex=[index-2:len(path)-shorten-1]) path[subIndex]];
            translate(pBranch[0]) {
                if (branchCounter%mod[branchType]==0) {
                    if (treeDebug == 1) color(colors[branchType]) 
                        cylinder(h=10,r=20-3*branchType);
                    rotate([0,0,angle[branchType]*(branchCounter%(2*mod[branchType])==mod[branchType]*direct[branchType]?-1:1)])
                        translate(-pBranch[0])
                               tree(pSubBranch,len(pSubBranch),leaves);
                } 
             }    
        }
    }
}

module trees(leaves = 1){
    union(){
        tree([[75,0],[75,2000],[200,1400],[1800,2300],[2000,2400],
            [2500,2360],[3550,2300],[4150,2000]],160,leaves);       
        tree([[85,0],[85,500],[100,400],[1800,300],[2000,50],
            [2500,50],[3000,600],[3600,700]],115,leaves);
    }
}

module test(){
    front();
    trees(1);
}
//test();
//cutBody(14);