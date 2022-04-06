include <settings.scad>
include <front.scad>
include <tree.scad>
module plus(index){
    union(){
        front(index);
        translate([0,0,0.01])
            trees(1);
    }
}
module part(index){
    difference(){
        intersection() {
            cutBody(index);                  
            plus(index);
        }
        handleBars(index,1);
    }
}

module partTest(index){
    intersection() {
        translate([0,0,-1])
            cutBody(index);                  
        front(index);
    }
}
module partPreGenerated(index){
    intersection() {
        cutBody(index);
        trees();
        /*union(){
            import(str("../../output/kitchen/parts/tree_fixed.stl"), convexity=3);
        }*/
    }
}
//part(14);
//cutBody(15);