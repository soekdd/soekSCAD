include <settings.scad>
include <front.scad>
include <tree.scad>
module plus(){
    union(){
        front();
        translate([0,0,0.01])
            trees(1);
    }
}
module part(index){
    f = getFronts()[index];
    intersection() {
        cutBody(index);                  
        plus();
        //front(index);
    }
   /* translate([f[1]+padding,f[2]+padding,0]) 
        handleBar(f,2);            
    */        
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
//part(15);
//cutBody(15);