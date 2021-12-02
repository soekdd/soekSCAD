include <front.scad>
include <tree.scad>
module part(index){
    intersection() {
        cutBody(index);                  
        union(){
            front();
            translate([0,0,-0.05])
                trees(0);
        }
    }
}
module partTest(index){
    intersection() {
        cutBody(index);                  
        front();
    }
}
module partPreGenerated(index){
    intersection() {
        cutBody(index);
        union(){
            import(str("../../output/kitchen/completeFront.stl"), convexity=3);
        }
    }
}
