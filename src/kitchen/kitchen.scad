include <front.scad>
include <part.scad>

module kitchen3D(index=-1){
    fronts = getFronts();
    union(){
        translate([0,0,20])
        if (index == -1)
            union()
            for(i = [0:len(fronts)-1]) {
                f = fronts[i];
                translate([f[1]+f[6][0],f[2],f[6][1]])
                    rotate([0,f[5],0])
                        translate(-[f[1],f[2],0])
                            part(i);
                echo(floor(100*(i+1)/len(fronts)),"%");
            }
        else {
            f = fronts[index];
            i = index;
            translate([f[1]+f[6][0],f[2],f[6][1]])
                rotate([0,f[5],0])
                    translate(-[f[1],f[2],0])
                        part(i);
        }    
        boards();
    }
}
module kitchen3DPreGenerated(dir = "parts"){
    fronts = getFronts();
    union() {
        translate([0,0,20])
        for(i = [0:len(fronts)-1]) {
            f = fronts[i];
            translate([f[1]+f[6][0],f[2],f[6][1]])
                    rotate([0,f[5],0])
                        translate(-[f[1],f[2],0]) {
                            import(str("../../output/kitchen/",dir,"/part",i,".stl"), convexity=3);
                            handleBars(i,2);
                        }
        }
        boards();
    }
}
//kitchen3DPreGenerated();
