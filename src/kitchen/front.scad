include <door.scad>

sockelH = 80;
tableH = 800;
fullH = 2200+140;
headBH = 800;
headSH = 400;
drawBH = 360;
drawSH = 220;
doorM = 1;
doorG = 2;
doorS = 3;
border = 150;
padding = 4; 
fase = 15; 
thickness = 20;
cWood = [.83,.80,.75];
cWall = [1,1,1];
cBench = [0.1,0.1,0.1];
function getFronts()=[
    // Sockel
    [doorS,-39, -sockelH ,6*400+200+39,sockelH,0,[0,0]],        //  0
    [doorS,6*400+200, -sockelH,600,sockelH,-90,[0,0]],          //  1
    [doorS,6*400+200+600, -sockelH,600,sockelH,0,[-600,600]],   //  2
    [doorS,-39, 0, 39,fullH,0,[0,0]],
    
    // Hochschrank
    [doorG,0,0,400,tableH,0,[0,0]],                             //  3
    [doorG,0,tableH,400,fullH-tableH-headBH,0,[0,0]],           //  4
    [doorG,0,fullH-headBH,400,headBH,0,[0,0]],                  //  5
    // Seitenteil
    [doorS,400,tableH,600,fullH-tableH-headBH,90,[0,0]],        //  6
    [doorS,400,fullH-headBH,200,headBH,90,[0,0]],               //  7
    // Grosse Oberschraenke
    for(i = [0:3])
        [doorG,600+i*400,fullH-headBH,400,headBH,0,[-200,-200]],    //  8..11
    // Kleine Oberschraenke
    for(i = [0:1])
        [doorG,200+5*400+i*400,fullH-headSH,400,headSH,0,[-200,-200]],  // 12,13
    [doorG,200+5*400+2*400,fullH-headSH,400,headSH,-90,[-200,-200]],    // 14
    // Abschluss Seitenteil gross zu klein
    [doorS,200+5*400,fullH-headBH,400,headBH-headSH,90,[-200,-200]],    // 15
 // Abschluss Seitenteil oben
    [doorS,200+8*400,fullH-headSH,400,headSH,0,[-600,200]],             // 16
 
    // Schmaler Schieber
    [doorM,400,0,200,800,0,[0,0]],                              // 17
    // Schieber unter Kochfeld
    [doorG,600,0,600,drawBH,0,[0,0]],                           // 18
    [doorM,600,drawBH,600,drawSH,0,[0,0]],                      // 19
    [doorM,600,drawBH+drawSH,600,drawSH,0,[0,0]],               // 20
    // Spuele 
    [doorG,2*600,0,600,tableH,0,[0,0]],                         // 21
    // Breite Schieber
    [doorG,3*600,0,800,drawBH,0,[0,0]],                         // 22
    [doorM,3*600,drawBH,800,drawSH,0,[0,0]],                    // 23
    [doorM,3*600,drawBH+drawSH,800,drawSH,0,[0,0]],             // 24
    // Geschirrspueler
    [doorM,3*600+800,0,600,tableH,-90,[0,0]],                   // 25
    // Abschluss Seitenteil unten
    [doorS,4*600+800,0,600,tableH,0,[-600,600]]                 // 26
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
            board(cWood,-39            ,-sockelH,-600 ,thickness,fullH+sockelH,600);
            board(cWood,8*400-thickness,-sockelH,-600,thickness,tableH+sockelH,1200);
            board(cWood,8*400-thickness,fullH-headSH,-600,thickness,headSH,800);
            // Deckel
            board(cWood,-39,fullH-thickness,-600,8*400+39,thickness,400);
            board(cWood,-39,fullH-thickness,-200,400+39,thickness,200);
            board(cWood,7*400,fullH-thickness,-200,400,thickness,400);
            // Unterseiten oben
            board(cWood,400,fullH-headBH,-600,4*400,thickness,400);
            board(cWood,5*400,fullH-headBH+headSH,-600,3*400,thickness,400);
            board(cWood,7*400,fullH-headBH+headSH,-200,400,thickness,400);
            // Unterseiten unten
            board(cWood,-39,-sockelH,-600,8*400+39,thickness,600);
            board(cWood,3*600+800,-sockelH,0,600,thickness,600);
        }
        if (material == -1 || material == 2) {  
            // Arbeitsplatte
            board(cBench,400,tableH,-600,3*600+800+200,3*thickness,600+20);
            board(cBench,3*600+800-20,tableH,0,620,3*thickness,600);
        }
        if (material == -1 || material == 3) {  
            // Waende
            board(cWall,-39,-sockelH,-600,8*400+39,fullH+sockelH+100,thickness);
            board(cWall,8*400-thickness,-sockelH,-600,thickness,fullH+sockelH+100,1500);
        }
   }
}
module front3D(index=-1){
    fronts = getFronts();
    union(){
        if (index == -1)
            union()
            for(i = [0:len(fronts)-1]) {
                f = fronts[i];
                echo(i,floor(100*(i+1)/len(fronts)),"%",f);
                translate([f[1]+f[6][0],f[2],f[6][1]])
                    rotate([0,f[5],0])
                        translate(-[f[1],f[2],0])
                            if (f[0] == doorM) 
                                mDoor(f[1],f[2],f[3],f[4]);
                            else if (f[0] == doorG) 
                                gDoor(f[1],f[2],f[3],f[4]);
                            else if (f[0] == doorS) 
                                sDoor(f[1],f[2],f[3],f[4]);
            }
        else {
            f = fronts[index];
            i = index;
            translate([f[1]+f[6][0],f[2],f[6][1]])
                rotate([0,f[5],0])
                    translate(-[f[1],f[2],0])
                        if (f[0] == doorM) 
                            mDoor(f[1],f[2],f[3],f[4]);
                        else if (f[0] == doorG) 
                            gDoor(f[1],f[2],f[3],f[4]);
                        else if (f[0] == doorS) 
                            sDoor(f[1],f[2],f[3],f[4]);
        }    
        boards();
    }
}


module front(index=-1){
    fronts = getFronts();
    if (index == -1) {
        union()
            for(f = fronts) {
                if (f[0] == doorM) 
                    mDoor(f[1],f[2],f[3],f[4]);
                else if (f[0] == doorG) 
                    gDoor(f[1],f[2],f[3],f[4]);
                else if (f[0] == doorS) 
                    sDoor(f[1],f[2],f[3],f[4]);
            }
    } else {
        f = fronts[index];
        if (f[0] == doorM) 
            mDoor(f[1],f[2],f[3],f[4]);
        else if (f[0] == doorG) 
            gDoor(f[1],f[2],f[3],f[4]);
        else if (f[0] == doorS) 
            sDoor(f[1],f[2],f[3],f[4]);      
    }
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

setDoorGlobals(border,thickness,fase,padding);
//front3D();