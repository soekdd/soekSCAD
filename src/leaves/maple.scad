include <leaf.scad>
module mapleLeaf(x,y,orientation,seed,bow) {
     leaf(maplePoints(),mapleFaces(),x,y,orientation,seed,bow);
}
module testLeaves(){
    {
    for(x = [-5:1:5])
        for(y = [-5:1:5])
            mapleLeaf(x*120,y*120,0,x*20+y,x+y);
    }
 }
/*
 mapleLeaf(-240,0,0,0,-2);
 mapleLeaf(-120,0,0,0,-1);
 mapleLeaf(0,0,0,0,0);
 mapleLeaf(120,0,0,0,1);
 mapleLeaf(240,0,0,0,2);
 */
 //testLeaves();