import { Bezier } from "./bezier.js";
var colors = ['#000','#00F','#0F0','#F00','#0FF','#F0F','#FF0','#FFF'];
function branch(pBranch, width, index, leaves = 1, depth = 0) {
    let s = "";
    let bezier = new Bezier(pBranch); 
    let svgPath = vec2Path(bezier.getLUT(5),width,"#000"/*,colors[depth]*/);
    s += svgPath;
    //console.log(svgPath,pBranch,index);
    let branchAngle = Math.atan2(pBranch[2].y-pBranch[1].y,
        pBranch[2].x - pBranch[1].x);
    let angle = index == 0 ? branchAngle - 90
            : (-90 + 65 * ( index % 2 ==0 ? -1 : 1 ) + branchAngle);
    if (width<45 && index % 5 ==0)
        s += leaf(pBranch[2],angle,index%3);
    return s
}

function tree(aBezier, num, leaves = 1, depth=0) {
    let nextBranch = [90,40,2,0];
    let mod = [25,15,7,99999];
    let direct = [0,1,1,1];
    let angle = [25,30,35,99];
    let counterDiff = 0;
    //console.log(aBezier);
    let bezier = new Bezier(aBezier); 
    let path = bezier.getLUT(num);
    let len = path.length;
    let branchDiff = [0,len-nextBranch[0],
        len - (nextBranch[1]),
        len - (nextBranch[2])];
    let s = ""; //vec2Path(path);
    let direction = 1;
    let branchCounter = 0;
    for (let index = 2; index < len; index++) {
        let pBranch = [path[index-2],path[index-1],path[index]];
        let steps2End = len-index-1;
        let newWidth = steps2End;
        s += branch(pBranch, newWidth+6.5, steps2End, leaves, depth);
        let shorten = Math.floor(steps2End * 0.45);
        let branchType = getBranchType(steps2End, nextBranch);
        let last = mod[branchType];
        branchCounter++
        if (newWidth > 1 && (index > 4)) {
            const pSubBranch = [];
            for (let subIndex = index - 2; subIndex < len - shorten - 1;subIndex++ )
                pSubBranch.push({ x: 0*pBranch[0].x + path[subIndex].x, y: 0*pBranch[0].y + path[subIndex].y });
            if (branchCounter > last) {
                branchCounter = 0;
                // s += `<circle cx="${pBranch[0].x}" cy="${pBranch[0].y}" r="${newWidth}" fill="${colors[depth+1]}"/>`;
                const rotate = angle[branchType] * direction; //(branchCounter % (2 * mod[branchType]) == mod[branchType] * direct[branchType] ? -1 : 1);
                s += `<g transform="rotate(${rotate} ${pBranch[0].x} ${pBranch[0].y})">`;
                s += tree(pSubBranch,pSubBranch.length,leaves, depth+1);
                s += "</g>";
                direction = direction * -1;
            }
        }    
    }
    //s += leaf({x:1000,y:1000},0);
    return s;
}

function vec2Path(vec,width,color) {
    let s = `<path stroke="${color??'#FFF'}" stroke-width="${width}" d="M ${vec[0].x} ${vec[0].y}`;
    for (let i = 1; i < vec.length; i++)
        s += `L ${vec[i].x} ${vec[i].y}`;
    return `${s}" stroke="black" fill="transparent"/>`;
}
function getBranchType(w, b) {
    return ((w >= b[0]) ? 0 : ((w >= b[1]) ? 1 : ((w >= b[2]) ? 2 : 3)));
}
function inc(a) { return a + 1; }

function leaf(pos, r, color) {
    const lColor = ['FA8072','FF4500','DC143C']
    let s = ""; //`<circle fill="#0F0" cx="${pos.x}" cy="${pos.y}" r="10"/>`;
    const leaf = [
        [2, -50.0],    //0
        [2, -45.0],    //1
        [2, -24.3],    //2
        [13.2, -29.7],    //3
        [16.3, -27.2],    //4
        [25.9, -30.0],    //5
        [26.1, -27.5],    //6
        [40.1, -19.7],    //7
        [31.0, -15.8],    //8
        [44.8, -7.9],    //9
        [40.0, -5.2],    //10
        [48.2, 2.7],    //11
        [43.1, 3.5],    //12
        [50.0, 23.2],    //13
        [29.4, 12.6],    //14
        [29.6, 16.9],    //15
        [17.3, 8.4],    //16
        [23.9, 24.9],    //17
        [11.9, 23.4],    //18
        [15.0, 31.8],    //19
        [10.8, 31.8],    //20
        [10.0, 36.6],    //21
        [5.0, 36.1],    //22
        [0.0, 50.0]];    //23
    s += `<g transform="translate(${pos.x} ${pos.y})">`;
    s += `<path fill="#${lColor[color]}" transform="scale(${scale()}, ${scale()}) rotate(${r} 0 0)" d="M `; 
    for (let index in leaf) {
        s += `${-ran()*leaf[index][0]} ${ran()*(50+leaf[index][1])} L`;
    } 
    for (let index = leaf.length - 1; index >= 0;index--) {
        s += `${ran()*leaf[index][0]} ${ran()*(50+leaf[index][1])} `;
        if (index != 0)
            s +='L '
    } 
    return s + 'Z"/></g>';
}

function ran() {
    const mEff = 0.05;
    return Math.random() * mEff - mEff / 2 + 1; 
}

function scale() {
    const sEff = 0.1;
    return 1.5 * (Math.random() * sEff - sEff / 2 + 1); 
}

export {tree}