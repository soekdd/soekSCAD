include <front.scad>
union(){
    import(str("../../output/kitchen/leaves.stl"), convexity=3);
    front();
}