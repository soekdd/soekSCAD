include <front.scad>
include <../../lib/dotSCAD/src/path_extrude.scad>;
include <../../lib/dotSCAD/src/bezier_curve.scad>;
include <../../lib/dotSCAD/src/curve.scad>;
include <../leaves/maple.scad>
include <../leaves/simple.scad>
debug = 0;
resolution = 30; 
stepSmooth = 1/(resolution*2);
truncHeight = 4;
function truncShape(truncWidth)=
    [[truncWidth/2,0],
     [-truncWidth/2,0],
     [-truncWidth*0.3,truncHeight*0.8],
     [0,truncHeight],
     [truncWidth*0.3,truncHeight*0.8]];

module branch(pBranch,height,index,leaves=1){
    if (height>0) 
        union() {
            pShape = truncShape(height);
            if (leaves != 2)
                path_extrude(pShape, pBranch, method = "EULER_ANGLE");
            angle = 90*(index%2)-180+45+atan2(pBranch[2][1]-pBranch[1][1],
                                       pBranch[2][0]-pBranch[1][0]);
            if (height<15 && index%3 ==0) {
                if (debug == 1) color([0,1,0]) translate([pBranch[2][0],pBranch[2][1]]) cylinder(5,5,5);
                if (leaves != 0 && leaves != 3) {
                    mapleLeaf(pBranch[2][0],
                              pBranch[2][1],
                              angle,
                              pBranch[2][0]*5000+pBranch[2][1],0);
                } else if (leaves == 3) {
                    simpleLeaf(pBranch[2][0],
                              pBranch[2][1],
                              angle,
                              pBranch[2][0]*5000+pBranch[2][1],0);
                }
            }
        }
}
module tree(aBezier,width,leaves=1){
    /*for(dot = aBezier)
        translate([dot[0],dot[1],10])
            color([1,0,0])
                cylinder(10,10,10);*/
    moreBranches1 = 105;
    mod1 = 11;
    angle1 = 25;
    moreBranches2 = 40;
    mod2 = 9;
    angle2 = 30;
    noBranches = 5;
    mod3 = 3;
    angle3 = 35;
    path = bezier_curve(2.2/(10+width),aBezier);
    //for(v = path) translate([v[0],v[1],20]) color([0,1,0]) cylinder(10,10,10);
    union()
    for(index = [2:len(path)-1]) {
        shorten = floor((len(path)-index)/2);
        pBranch = [path[index-2],path[index-1],path[index]];
        newWidth = width-2.1*index;
        branch(pBranch,newWidth,index,leaves);
        if (newWidth>0 && index>2 && len(path)-shorten>index+5) {
             pSubBranch = [for(subIndex=[index-2:len(path)-shorten-1]) path[subIndex]];
        /*for(v = pSubBranch)
               translate([v[0],v[1],20]) color([0,1,0]) cylinder(10,10,10);*/
            translate(pBranch[0]) {
                if (index%mod1 == 0 && newWidth>=moreBranches1 ) {
                    if (debug == 1) color([0,0,1]) cylinder(20,20,20);
                    rotate([0,0,angle1*(index%(2*mod1)==0?-1:1)])
                        translate(-pBranch[0])
                               tree(pSubBranch,newWidth-10,leaves);
                } else if (index%mod2 == 0 && newWidth<moreBranches1 && newWidth>=moreBranches2) {
                    if (debug == 1) color([1,0,0]) cylinder(15,15,15);
                    rotate([0,0,angle2*(index%(2*mod2)==0?-1:1)])
                        translate(-pBranch[0])
                               tree(pSubBranch,newWidth-5,leaves);
                } else if (index%mod3 == 0 && newWidth<moreBranches2 && newWidth>noBranches) {
                    if (debug == 1) color([1,1,0]) cylinder(10,10,10);   
                    rotate([0,0,angle3*(index%(2*mod3)==0?-1:1)])
                        translate(-pBranch[0])
                               tree(pSubBranch,newWidth,leaves);
                }
            }    
        }
    }
}

module trees(leaves = 1){
    union(){
        tree([[50,0],[50,2000],[100,1400],[1800,2300],[2000,2400],
            [2500,2360],[3000,2300],[4600,2200]],150,leaves);       
        tree([[50,0],[50,500],[100,400],[1800,300],[2000,500],
            [2500,50],[3000,600],[3600,700]],130,leaves);
    }
}

module test(){
    front(14);
    trees(1);
}
//test();
//cutBody(14);