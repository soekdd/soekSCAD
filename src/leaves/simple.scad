simpleLeaveThickness = 5;
simpleLeaveOffset = 3;
simplePoints = [[  0.0,-50.0,  0.0],    //0
                [  2,-45.0,  0.0],    //1
                [  0,-24.3,  0.0],    //2
                [ 13.2,-29.7,  0.0],    //3
                [ 16.3,-27.2,  0.0],    //4
                [ 25.9,-30.0,  0.0],    //5
                [ 26.1,-27.5,  0.0],    //6
                [ 40.1,-19.7,  0.0],    //7
                [ 31.0,-15.8,  0.0],    //8
                [ 44.8, -7.9,  0.0],    //9
                [ 40.0, -5.2,  0.0],    //10
                [ 48.2,  2.7,  0.0],    //11
                [ 43.1,  3.5,  0.0],    //12
                [ 50.0, 23.2,  0.0],    //13
                [ 29.4, 12.6,  0.0],    //14
                [ 29.6, 16.9,  0.0],    //15
                [ 17.3,  8.4,  0.0],    //16
                [ 23.9, 24.9,  0.0],    //17
                [ 11.9, 23.4,  0.0],    //18
                [ 15.0, 31.8,  0.0],    //19
                [ 10.8, 31.8,  0.0],    //20
                [ 10.0, 36.6,  0.0],    //21
                [  5.0, 36.1,  0.0],    //22
                [  0.0, 50.0,  0.0],    //23
                [ 11.2,-14.0,  5.0],    //24
                [ 33.8, -5.7,  3.0],    //25
                [ 27.7, -2.3,  4.0],    //26
                [ 24.7,  7.5,  3.0],    //27
                [  0.0, -9.7,  5.0],    //28
                [  0.0, 13.3,  5.0],    //29
                [  0.0, 24.7,  4.0],    //30
                [ 14.5,-18.5,  5.0],    //31
                ];
simpleFaces = [ [ 7, 2,28],           // A
               [13, 7,28],
               [23,13,28],
               [ 2, 7,13,23],
               [ 23,28,2]
               ];
                       
module simpleLeaf(x,y,orientation,seed,bow) {
    mEff = 0.05;//.1;
    sEff = 0.2;//.2;
    rEff = 0.0;
    tEff = 0;
    locSimplePoints = [for(i = [0:len(simplePoints)-1])[
        simplePoints[i][0]*rands(1-mEff,1+mEff,1,seed+i*3+100)[0],
        simplePoints[i][1]*rands(1-mEff,1+mEff,1,seed+i*3+101)[0],
        simplePoints[i][2]*rands(1-mEff,1+mEff,1,seed+i*3+102)[0]]];
    translate([x+100*rands(-tEff,+tEff,1,seed+14)[0],y+100*rands(-tEff,+tEff,1,seed+13)[0],simpleLeaveOffset]) 
        scale([1,1,simpleLeaveThickness/5])
            rotate([0,0,orientation+100*rands(-rEff,+rEff,1,seed+12)[0]])
            union(){
               translate([bow/2,0,0])
               rotate([90+1.5*abs(bow),0,0])
               translate([0, -abs(bow), -20])
                    linear_extrude(height = 40, center = true, convexity = 10, twist = -bow*10)
                        translate([bow, 0, 0])
                            circle(r = 2);
                /*translate([0,0,5])
                    color([1,0,0])
                        cylinder(2,2,2);*/
               translate([bow*1.5,0,0])
                   union(){
                   scale([rands(1-sEff,1+sEff,1,seed+20)[0],rands(1-sEff,1+sEff,1,seed+21)[0],1])
                        translate([0,47,0])
                            polyhedron(points=locSimplePoints,faces=simpleFaces,convexity = 3);
                   scale([rands(1-sEff,1+sEff,1,seed+22)[0],rands(1-sEff,1+sEff,1,seed+21)[0],1])
                        translate([0,47,0])
                            mirror([1,0,0])
                            polyhedron(points=locSimplePoints,faces=simpleFaces,convexity = 3);
                   }
            }
}
module testLeaves(){
    {
    for(x = [-5:1:5])
        for(y = [-5:1:5])
            simpleLeaf(x*120,y*120,0,x*20+y,x+y);
    }
 }
 /*
 simpleLeaf(-240,0,0,0,-12);
 simpleLeaf(-120,0,0,0,-10);
 simpleLeaf(0,0,0,0,0);
 simpleLeaf(120,0,0,0,10);*/
 //testLeaves();