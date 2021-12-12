include <settings.scad>
include <door.scad>
function getFronts()=[
    // Sockel Boden
    [doorS,left+heater, 0 ,900-heater,sockelH,0,[0,0]],              //  0
    [doorS,left+900, 0,900,sockelH, 0,[0,0]],                        //  1
    [doorS,left+2*900, 0,800,sockelH, 0,[0,0]],                      //  2
    [doorS,left+2*900+800, 0,600,sockelH,-90,[0,0]],                 //  3
    // Seitenteil
    [doorS,0, 0, left+heater,tableH-drawH,0,[0,0]],                  //  4
    [doorS,0, tableH-drawH, left,fullH-headBH-tableH+drawH,0,[0,0]], //  5
    [doorS,0, fullH-headBH, left,headBH,0,[0,0]],                    //  6
    
    // Hochschrank
    [doorG,left,tableH,400,fullH-tableH-headBH,0,[0,0]],             //  7
    [doorG,left,fullH-headBH,400,headBH,0,[0,0]],                    //  8
    // Seitenteil
    [doorS,left+400,tableH,700,fullH-tableH-headBH,90,[0,0]],        //  9
    [doorS,left+400,fullH-headBH,300,headBH,90,[0,0]],               // 10
    // Grosse Oberschraenke
    for(i = [0:3])
        [i<2?doorC:doorG,left+700+i*400,fullH-headBH,
            400,headBH,0,[-300,-300]],                               // 11..14
    // Kleine Oberschraenke
    for(i = [0:1])
        [doorG,left+300+5*400+i*400,fullH-headSH,400,
            headSH,0,[-300,-300]],                                   // 15,16
    for(i = [0:1])
         [doorG,left+300+5*400+(2+i)*400,fullH-headSH,400,
                headSH,-90,[-300-i*400,-300+i*400]],                 // 17,18
    // Abschluss Seitenteil gross zu klein
    [doorS,left+300+5*400,fullH-headBH,400,headBH-headSH,90,[-300,-300]],// 19
 // Abschluss Seitenteil oben
    [doorS,left+300+9*400,fullH-headSH,400,headSH,0,[-700-400,500]], // 20
    // Schieber links
    [doorG,left+heater,sockelH,drawW1-heater,
        (tableH-drawH-sockelH)/2,0,[0,0]],                           // 21
    [doorG,left+heater,sockelH+(tableH-drawH-sockelH)/2,
        drawW1-heater,(tableH-drawH-sockelH)/2,0,[0,0]],             // 22
    [doorM,left,tableH-drawH,drawW1,drawH,0,[0,0]],                  // 23
    
    // Schieber unter Kochfeld
    [doorG,left+drawW1,sockelH,drawW2,(tableH-drawH-sockelH)/2,0,[0,0]],// 24
    [doorG,left+drawW1,sockelH+(tableH-drawH-sockelH)/2,
        drawW2,(tableH-drawH-sockelH)/2,0,[0,0]],                    // 25
    [doorM,left+drawW1,tableH-drawH,drawW2,drawH,0,[0,0]],           // 26
    // Geschirrspueler
    [doorM,left+600+800,tableH-drawH,600,drawH,0,[0,0]],             // 27
    [doorC,left+600+800,sockelH,600,tableH-drawH-sockelH,0,[0,0]],   // 28
    // Spuele 
    [doorG,left+2*600+800,sockelH,600,tableH-sockelH,0,[0,0]],       // 29
    // Eckschrank
    [doorG,left+3*600+800,sockelH,600,tableH-sockelH,-90,[0,0]],     // 30
    // Abschluss Seitenteil unten
    [doorS,left+4*600+800,0,600,tableH,0,[-600,600]],                // 31
    // Rückwand 
    [glass,left+400+700,tableH,400*4,fullH-tableH-headBH,0,[-700,-700]],  // 32
    [glass,left+400+700+4*400,tableH,400*3,fullH-tableH-headSH,0,[-700,-700]]   // 33
    
    // 
    
];

module board(c,x,y,z,w,h,d){
    color(c)
        translate([x,y,z])
            cube([w,h,d]);
}

module boards(material = -1){
    union(){
        if (material == -1 || material == 1) {  
            //Seitenwände
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

module cutBody(index=-1){
    fronts = getFronts();
    if (index == -1) {
        union()
            for(f = fronts)    
                if (f[0]==doorS)
                    translate([f[1],f[2],-50]) 
                        cube([f[3],f[4],100]);
                else 
                  translate([f[1]+padding,f[2]+padding,-50]) 
                    cube([f[3]-2*padding,f[4]-2*padding,100]);
   } else {
        f = fronts[index];
        if (f[0]==doorS)
            translate([f[1],f[2],-50]) 
                cube([f[3],f[4],100]);
        else 
          translate([f[1]+padding,f[2]+padding,-50]) 
            cube([f[3]-2*padding,f[4]-2*padding,100]);
   }
}

//front();