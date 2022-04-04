include <leaf_copy.scad>
module mapleLeaf(x,y,orientation,seed,bow,XYscale) {
     leaf(maplePoints(),mapleFaces(),x,y,orientation,seed,bow,XYscale);
}
module testLeaves(){
    {
    for(x = [-5:1:5])
        for(y = [-5:1:5])
            mapleLeaf(x*120,y*120,0,x*20+y,x+y,1+(x+y)/20);
    }
 }

 mapleLeaf(-240,0,0,0,-2,1);
 mapleLeaf(-120,0,0,0,-1,1);
 mapleLeaf(0,0,0,0,0,1);
 mapleLeaf(120,0,0,0,1,1);
 mapleLeaf(240,0,0,0,2,1);
 //testLeaves();