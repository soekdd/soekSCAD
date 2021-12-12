include <leaf.scad>
 
module simpleLeaf(x,y,orientation,seed,bow) {
    leaf(maplePoints(),simpleFaces(),x,y,orientation,seed,bow);
}
module testLeaves(){
    {
    for(x = [-5:1:5])
        for(y = [-5:1:5])
            simpleLeaf(x*120,y*120,0,x*20+y,x+y);
    }
 }
/* 
 simpleLeaf(-240,0,0,0,-2);
 simpleLeaf(-120,0,0,0,-1);
 simpleLeaf(0,0,0,0,0);
 simpleLeaf(120,0,0,0,1);
 simpleLeaf(240,0,0,0,2);
 */
 //testLeaves();