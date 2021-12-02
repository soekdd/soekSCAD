b = 150;
p = 4; // padding
f = 5; 
d = 12;
module setDoorGlobals(border,thickness,fase,padding) {
    b = border;
    p = padding;
    d = thickness;
    f = fase;
}
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
      [      b+p,       b+p,  -d],   // 21
      [      b+p,height-b-p,  -d],   // 22
      [width-b-p,height-b-p,  -d],   // 23
      [width-b-p,       b+p,  -d],   // 24
      ];
module gDoor(x,y,width,height) {
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
             [13,14,22,21],  //innenrand  
             [14,15,23,22],
             [15,16,24,23],
             [16,13,21,24],
             [21,22,18,17],  // rueckseite
             [22,23,19,18],
             [23,24,20,19],
             [24,21,17,20]
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
        cube([width,height,d]);
}
//gDoor(0,0,600,800);
//gDoor(700,0,600,800);