include <settings.scad>
include <door.scad>

function getFronts()=[
    // Sockel Boden
    [doorS,left+heater, 0 ,900-heater,sockelH,0,[0,0]],                  //  0
    [doorS,left+900, 0,900,sockelH, 0,[0,0]],                            //  1
    [doorS,left+2*900, 0,800,sockelH, 0,[0,0]],                          //  2
    [doorS,left+2*900+800, 0,600,sockelH,-90,[0,0]],                     //  3
    // Seitenteil
    [doorS,0, 0, left+heater,tableH-drawH,0,[0,0]],                      //  4
    [doorS,0, tableH-drawH, left,fullH-headBH-tableH+drawH,0,[0,0]],     //  5
    [doorS,0, fullH-headBH, left,headBH,0,[0,0]],                        //  6
    
    // Hochschrank
    [doorG,left,tableH,400,fullH-tableH-headBH,0,[0,0], hbLong2, hbRightCenter],//  7
    [doorG,left,fullH-headBH,400,headBH,0,[0,0], hbShort, hbRight],      //  8
    // Seitenteil
    [doorS,left+400,tableH,700,fullH-tableH-headBH,90,[0,0]],            //  9
    [doorS,left+400,fullH-headBH,300,headBH,90,[0,0]],                   // 10
    // Grosse Oberschraenke
    for(i = [0:3])
        [i<2?doorC:doorG,left+700+i*400,fullH-headBH,
            400,headBH,0,[-300,-300],hbShort, hbRight - i % 2],          // 11..14
    // Kleine Oberschraenke
    for(i = [0:1])
        [doorG,left+300+5*400+i*400,fullH-headSH,400,
            headSH,0,[-300,-300], hbShort, hbRight- i % 2],              // 15,16
    for(i = [0:1])
         [doorG,left+300+5*400+(2+i)*400,fullH-headSH,400, headSH,-90,
            [-300-i*400,-300+i*400], hbShort, hbRight - i % 2],          // 17,18
    // Abschluss Seitenteil gross zu klein
    [doorS,left+300+5*400,fullH-headBH,400,headBH-headSH,90,[-300,-300]],// 19
 // Abschluss Seitenteil oben
    [doorS,left+300+9*400,fullH-headSH,400,headSH,0,[-700-400,500]],     // 20
    // Schieber links
    [doorG,left+heater,sockelH,drawW1-heater,
        (tableH-drawH-sockelH)/2,0,[0,0],hbLong, hbCenterTop],           // 21
    [doorG,left+heater,sockelH+(tableH-drawH-sockelH)/2, drawW1-heater,
        (tableH-drawH-sockelH)/2,0,[0,0],hbLong, hbCenterTop],           // 22
    [doorM,left,tableH-drawH,drawW1,drawH,0,[0,0],hbLong2, hbCenterCenter],// 23
    
    // Schieber unter Kochfeld
    [doorG,left+drawW1,sockelH,drawW2,
        (tableH-drawH-sockelH)/2,0,[0,0],hbLong, hbCenterTop],           // 24
    [doorG,left+drawW1,sockelH+(tableH-drawH-sockelH)/2,
        drawW2,(tableH-drawH-sockelH)/2,0,[0,0],hbLong, hbCenterTop],    // 25
    [doorM,left+drawW1,tableH-drawH,drawW2,drawH,
        0,[0,0],hbLong, hbCenterCenter],                                 // 26
    // Geschirrspueler
    [doorM,left+600+800,tableH-drawH,600,drawH,
        0,[0,0],hbLong, hbCenterCenter],                                  // 27
    [doorC,left+600+800,sockelH,600,
        tableH-drawH-sockelH,0,[0,0],hbLong, hbCenterTop],               // 28
    // Spuele 
    [doorG,left+2*600+800,sockelH,600,
        tableH-sockelH,0,[0,0],hbLong, hbCenterTop],                     // 29
    // Eckschrank 
    [doorG,left+3*600+800,sockelH,600,
        tableH-sockelH,-90,[0,0],hbLong, hbCenterTop],                   // 30
    // Abschluss Seitenteil unten
    [doorS,left+4*600+800,0,600,tableH,0,[-600,600]],                    // 31
    // R??ckwand 
    [glass,left+400+700,tableH,400*4,fullH-tableH-headBH,0,[-700,-700]], // 32
    [glass,left+400+700+4*400,tableH,400*3,
        fullH-tableH-headSH,0,[-700,-700]]                               // 33
    // 
    
];

module partList(){
    fronts = getFronts();
    for(f = fronts)
        echo( f[0], f[3], f[4] );
}

module board(c,x,y,z,w,h,d){
    color(c)
        translate([x,y,z])
            cube([w,h,d]);
}

module boards(material = -1){
    union(){
        if (material == -1 || material == 1) {  
            //Seitenw??nde
            board(cWood,0            ,0,-700 ,thickness,fullH,700-thickness);
            board(cWood,left+8*400-thickness,0,-700,thickness,tableH+sockelH,1200);
            board(cWood,left+8*400-thickness,fullH-headSH,-700,thickness,headSH,800);
            // Deckel
            board(cWood,0,fullH-thickness,-700,8*400+left,thickness,400-thickness);
            board(cWood,0,fullH-thickness,-300-thickness,400+left-thickness,thickness,300);
            board(cWood,left+7*400+thickness,fullH-thickness,-300-thickness,400-thickness,thickness,800);
            // Unterseiten oben
            board(cWood,left+400,fullH-headBH,-700,4*400,thickness,400-thickness);
            board(cWood,left+5*400,fullH-headBH+headSH,-700,3*400,thickness,400-thickness);
            board(cWood,left+7*400,fullH-headBH+headSH,-300-thickness,400,thickness,800);
            // Unterseiten unten
            board(cWood,0,0,-700,8*400+left,thickness,700-thickness);
            board(cWood,left+3*600+800+thickness,0,-thickness,600-thickness,thickness,600);
        }
        if (material == -1 || material == 2) {  
            // Arbeitsplatte
            board(cBench,left+400,tableH,-700,3*600+800+200,3*thickness,700+20);
            board(cBench,left+3*600+800-20,tableH,0,620,3*thickness,620);
        }
        if (material == -1 || material == 3) {  
            // Waende
            board(cWall,0,0,-700,8*400+left,fullH,thickness);
            board(cWall,left+8*400-thickness,0,-700,thickness,fullH,1500);
        }
   }
}
module door(f){
    //translate([f[1],f[2],0]) handleBar(f,2);
    if (f[0] == doorM) 
        mDoor(f[1],f[2],f[3],f[4]);
    else if (f[0] == doorG) 
        gDoor(f[1],f[2],f[3],f[4]);
    else if (f[0] == doorS) 
        sDoor(f[1],f[2],f[3],f[4]);
    else if (f[0] == doorC) 
        cDoor(f[1],f[2],f[3],f[4]);
    else if (f[0] == glass) 
        glassDummy(f[1],f[2],f[3],f[4]);
}
module door3D(f){
    translate([f[1]+f[6][0],f[2],f[6][1]])
                rotate([0,f[5],0])
                    translate(-[f[1],f[2],0])
                        door(f);
}

module front3D(index=-1){
    fronts = getFronts();
    union(){
        if (index == -1)
            for(f = fronts) 
                color(doorColor[f[0]])
                    //union()
                        door3D(f);
        else 
            door3D(fronts[index]); 
        //boards();
    }
}


module front(index=-1){
    fronts = getFronts();
    if (index == -1) {
        union()
            for(f = fronts)
                door(f);
    } else 
        door(fronts[index]);
}

module dorn(radius){
    cylinder(h=10, r1=radius, r2=radius+5, center=true, $fn=72);
    translate([0,0,-5])
        cylinder(h=3, r=3, center=true, $fn=36);
}

module handleBar(f, type = 1) {
    width = f[7];
    pos = f[8];
    height = 40;
    deep = (type==1) ? 5 :height/2 ;
    radius = (type==1) ? 7 : 6;
    color(cBench)
    if (pos == hbCenterCenter)
        if (type==2) {
            translate([f[3]/2-width/2,f[4]/2,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]/2+width/2,f[4]/2,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]/2+width/2,f[4]/2,height]) rotate([0,90,0]) translate([0,0,-width/2])
                cylinder(h=width+2*hbExtra, r=radius, center=true);
        } else {
            translate([f[3]/2-width/2,f[4]/2,deep]) dorn(radius);
            translate([f[3]/2+width/2,f[4]/2,deep]) dorn(radius);
        } 
    else if (pos == hbCenterBottom) 
        if (type==2) {
            translate([f[3]/2-width/2,hbMargin,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]/2+width/2,hbMargin,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]/2+width/2,hbMargin,height]) rotate([0,90,0]) translate([0,0,-width/2])
                cylinder(h=width+2*hbExtra, r=radius, center=true);
        } else {
            translate([f[3]/2-width/2,hbMargin,deep]) dorn(radius);
            translate([f[3]/2+width/2,hbMargin,deep]) dorn(radius);
        }
    else if (pos == hbCenterTop) 
        if (type==2){
            translate([f[3]/2-width/2,f[4]-hbMargin,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]/2+width/2,f[4]-hbMargin,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]/2+width/2,f[4]-hbMargin,height]) 
                rotate([0,90,0]) translate([0,0,-width/2])
                cylinder(h=width+2*hbExtra, r=radius, center=true);        
        } else {
            translate([f[3]/2-width/2,f[4]-hbMargin,deep]) dorn(radius);
            translate([f[3]/2+width/2,f[4]-hbMargin,deep]) dorn(radius);
        }
    else if (pos == hbRight) 
        if (type==2) {
            translate([f[3]-hbMargin,hbMargin+width,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]-hbMargin,hbMargin,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]-hbMargin,hbMargin,height]) rotate([90,0,0]) translate([0,0,-width/2])
                cylinder(h=width+2*hbExtra, r=radius, center=true);
        } else {
            translate([f[3]-hbMargin,hbMargin+width,deep]) dorn(radius);
            translate([f[3]-hbMargin,hbMargin,deep]) dorn(radius);
        }
    else if (pos == hbRightCenter) 
        if (type==2) {
            translate([f[3]-hbMargin,f[4]/2-width/2,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]-hbMargin,f[4]/2+width/2,deep])
                cylinder(h=height, r=radius, center=true);
            translate([f[3]-hbMargin,f[4]/2-width/2,height]) rotate([90,0,0]) translate([0,0,-width/2])
                cylinder(h=width+2*hbExtra, r=radius, center=true);
        } else {
            translate([f[3]-hbMargin,f[4]/2-width/2,deep]) dorn(radius);
            translate([f[3]-hbMargin,f[4]/2+width/2,deep]) dorn(radius);
        }
    else if (pos == hbLeft) 
        if (type==2) {
            translate([hbMargin,hbMargin+width,deep])
                cylinder(h=height, r=radius, center=true);
            translate([hbMargin,hbMargin,deep])
                cylinder(h=height, r=radius, center=true);
            translate([hbMargin,hbMargin,height]) rotate([90,0,0]) translate([0,0,-width/2])
                cylinder(h=width+2*hbExtra, r=radius, center=true);
        } else {
            translate([hbMargin,hbMargin+width,deep]) dorn(radius);
            translate([hbMargin,hbMargin,deep]) dorn(radius);
        }
}

module cutBody(index=-1){
    fronts = getFronts();
    if (index == -1) {
        union()
            for(f = fronts)    
                if (f[0]==doorS || f[0]==glass)
                    translate([f[1],f[2],-50]) 
                        cube([f[3],f[4],100]);
                else 
                  translate([f[1]+padding,f[2]+padding,-50]) 
                //union() {
                //difference() {
                    cube([f[3]-2*padding,f[4]-2*padding,100]);
                //    handleBar(f,1);
                //  }
   } else {
        f = fronts[index];
        if (f[0]==doorS)
            translate([f[1],f[2],-50]) 
                cube([f[3],f[4],100]);
        else 
            translate([f[1]+padding,f[2]+padding,-50]) 
                //difference() {
                    cube([f[3]-2*padding,f[4]-2*padding,100]);
                //    handleBar(f,1);            
                //}
   }
}

module handleBars(index=-1,mode=1){
    fronts = getFronts();
    if (index == -1) {
        union()
            for(f = fronts)    
                if (f[0]!=doorS && f[0]!=glass)
                  translate([f[1]+padding,f[2]+padding,0]) 
                    handleBar(f,mode);
                  
   } else {
        f = fronts[index];
        if (f[0]!=doorS && f[0]!=glass) 
            translate([f[1]+padding,f[2]+padding,0]) 
                handleBar(f,mode);            
                
   }
}
//partList();
//handleBars();
//front3D();
//front();
//cutBody();