include <settings.scad>
b = border;
p = padding; 
f = fase; 
d = thickness;
gx = glassNotchX;
gy = glassNotchY;

function getDoorPoints(width,height) =
    [[0,0,0], // 0
      [        p,         p,  -f],   // 1
      [        p,  height-p,  -f],   // 2
      [  width-p,  height-p,  -f],   // 3
      [  width-p,         p,  -f],   // 4
      [      f+p,       f+p,   0],   // 5
      [      f+p,height-f-p,   0],   // 6
      [width-f-p,height-f-p,   0],   // 7
      [width-f-p,       f+p,   0],   // 8
      [    b-f+p,     b-f+p,   0],   // 9
      [    b-f+p,height-b+f-p, 0],   // 10
      [width-b+f-p,height-b+f-p,0],  // 11
      [width-b+f-p,   b-f+p,   0],   // 12
      [      b+p,       b+p,  -f],   // 13
      [      b+p,height-b-p,  -f],   // 14
      [width-b-p,height-b-p,  -f],   // 15
      [width-b-p,       b+p,  -f],   // 16
      [        p,         p,  -d],   // 17
      [        p,  height-p,  -d],   // 18
      [  width-p,  height-p,  -d],   // 19
      [  width-p,         p,  -d],   // 20
      
      [      b+p-gx,       b+p-gx,  -d],   // 21
      [      b+p-gx,height-b-p+gx,  -d],   // 22
      [width-b-p+gx,height-b-p+gx,  -d],   // 23
      [width-b-p+gx,       b+p-gx,  -d],   // 24
      
      [      b+p-gx,       b+p-gx,  -d+gy],   // 25
      [      b+p-gx,height-b-p+gx,  -d+gy],   // 26
      [width-b-p+gx,height-b-p+gx,  -d+gy],   // 27
      [width-b-p+gx,       b+p-gx,  -d+gy],   // 28
      
      [      b+p,       b+p,  -d+gy],   // 29
      [      b+p,height-b-p,  -d+gy],   // 30
      [width-b-p,height-b-p,  -d+gy],   // 31
      [width-b-p,       b+p,  -d+gy],   // 33
      ];
module gDoor(x,y,width,height) {
    /*for(p = getDoorPoints(width,height))
       color([1,0,0])
       translate([p[0],p[1],p[2]])
           cylinder(2,2,2);*/
    translate([x,y,0])
    polyhedron(
    points = getDoorPoints(width,height),  
    faces = [[ 1, 2, 6, 5],  // a
             [ 2, 3, 7, 6],  // b
             [ 3, 4, 8, 7],  // c
             [ 4, 1, 5, 8],  // d
             [ 5, 6,10, 9],  // e
             [ 6, 7,11,10],  // f
             [ 7, 8,12,11],  // g
             [ 8, 5, 9,12],  // h
             [ 9,10,14,13],  // i
             [10,11,15,14],  // j
             [11,12,16,15],  // k
             [12, 9,13,16],  // l
             [ 2, 1,17,18],  //aussenrand
             [ 3, 2,18,19],
             [ 4, 3,19,20],
             [ 1, 4,20,17],
             [13,14,30,29],  //innenrand  
             [14,15,31,30],
             [15,16,32,31],
             [16,13,29,32],
             [25,26,22,21],  //glasrand vert
             [26,27,23,22],
             [27,28,24,23],
             [28,25,21,24],
             [29,30,26,25],  //glasrand hori
             [30,31,27,26],
             [31,32,28,27],
             [32,29,25,28],
             [21,22,18,17],  // rueckseite
             [22,23,19,18],
             [23,24,20,19],
             [24,21,17,20]
             ]); 
}

module cDoor(x,y,width,height) {
    /*for(p = getDoorPoints(width,height))
       color([1,0,0])
       translate([p[0],p[1],p[2]])
           cylinder(2,2,2);*/
    translate([x,y,0])
    polyhedron(
    points = getDoorPoints(width,height),  
    faces = [[ 1, 2, 6, 5],  // a
             [ 2, 3, 7, 6],  // b
             [ 3, 4, 8, 7],  // c
             [ 4, 1, 5, 8],  // d
             [ 5, 6,10, 9],  // e
             [ 6, 7,11,10],  // f
             [ 7, 8,12,11],  // g
             [ 8, 5, 9,12],  // h
             [ 9,10,14,13],  // i
             [10,11,15,14],  // j
             [11,12,16,15],  // k
             [12, 9,13,16],  // l
             [ 2, 1,17,18],  //aussenrand
             [ 3, 2,18,19],
             [ 4, 3,19,20],
             [ 1, 4,20,17],
             [13,14,30,29],  //innenrand  
             [14,15,31,30],
             [15,16,32,31],
             [16,13,29,32],
             [29,30,31,32],   // kassette innen
             [20,19,18,17]   // rueckseite
             ]); 
}

module mDoor(x,y,width,height) {
    translate([x,y,0])
    polyhedron(
 getDoorPoints(width,height),  
    faces = [[ 1, 2, 6, 5],  // a
             [ 2, 3, 7, 6],  // b
             [ 3, 4, 8, 7],  // c
             [ 4, 1, 5, 8],  // d
             [ 5, 6,7, 8],  // front
             [ 2, 1,17,18],  //aussenrand
             [ 3, 2,18,19],
             [ 4, 3,19,20],
             [ 1, 4,20,17],
             [20,19,18,17]   // rueckseite
           ]); 
}
module sDoor(x,y,width,height) {
    translate([x,y,-d])
        cube([width,height,d-f]);
}
module glassDummy(x,y,width,height) {
    /*color([1,1,1])
        translate([x,y,-d])
            cube([width,height,d-f]);*/
}
//cDoor(0,0,400,400);
//gDoor(0,0,400,400);
//gDoor(700,0,600,800);