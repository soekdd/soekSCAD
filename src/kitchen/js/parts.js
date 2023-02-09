const border = 120;
const padding = 6;
const fase = 2*4;
const thickness = 16.5;
const sockelH = 80;
const tableH = 950;
const fullH = 2420;
const headBH = 800;
const headSH = 400;
const drawH = 180;
const heater = 150;
const drawW1 = 625+heater;
const drawW2 = 625;
const left = 39;
const hbMargin = border/2+padding+fase;
const hbShort = 128;
const hbLong = 320;
const hbLong2 = 480;
const hbExtra = 30;
const hbCenterTop = 1;
const hbCenterCenter = 2;
const hbCenterBottom = 5;
const hbLeft = 3;
const hbRight = 4;
const hbRightCenter = 6;

function doorM(part) {
    let p = padding - fase / 2;
    return `<rect x="${part[1]+p}" y="${part[2]+p}" width="${part[3]-2*p}" height="${part[4]-2*p}" stroke="#00F" stroke-width="${fase}" fill="none"/>`;
};
function doorG(part) {
    let p = padding + border - fase / 2;
    return doorM(part)+`<rect x="${part[1]+p}" y="${part[2]+p}" width="${part[3]-2*p}" height="${part[4]-2*p}" stroke="#00F" stroke-width="${fase}" fill="none"/>`;

}
const doorC = doorG;
function glass(part) {
    return `<rect x="${part[1]}" y="${part[2]}" width="${part[3]}" height="${part[4]}" stroke="#777" fill="none"/>`;
};
const doorS = glass;

function parts() {
    const p = [];
    // Sockel Boden
    p.push([doorS, left + heater, 0, 900 - heater, sockelH, 0, [0, 0]]);                  //  0
    p.push([doorS, left + 900, 0, 900, sockelH, 0, [0, 0]]);                            //  1
    p.push([doorS, left + 2 * 900, 0, 800, sockelH, 0, [0, 0]]);                          //  2
    p.push([doorS, left + 2 * 900 + 800, 0, 600, sockelH, -90, [0, 0]]);                     //  3
    // Seitenteil
    p.push([doorS, 0, 0, left + heater, tableH - drawH, 0, [0, 0]]);                      //  4
    p.push([doorS, 0, tableH - drawH, left, fullH - headBH - tableH + drawH, 0, [0, 0]]);     //  5
    p.push([doorS, 0, fullH - headBH, left, headBH, 0, [0, 0]]);                        //  6

    // Hochschrank
    p.push([doorG, left, tableH, 400, fullH - tableH - headBH, 0, [0, 0], hbLong2, hbRightCenter]);//  7
    p.push([doorG, left, fullH - headBH, 400, headBH, 0, [0, 0], hbShort, hbRight]);      //  8
    // Seitenteil
    p.push([doorS, left + 400, tableH, 700, fullH - tableH - headBH, 90, [0, 0]]);            //  9
    p.push([doorS, left + 400, fullH - headBH, 300, headBH, 90, [0, 0]]);                   // 10
    // Grosse Oberschraenke
    for (let i = 0; i < 4;i++)
        p.push([i < 2 ? doorC : doorG, left + 700 + i * 400, fullH - headBH,
            400, headBH, 0, [-300, -300], hbShort, hbRight - i % 2]);          // 11..14
    // Kleine Oberschraenke
    for (let i = 0; i < 2;i++)
        p.push([doorG, left + 300 + 5 * 400 + i * 400, fullH - headSH, 400,
            headSH, 0, [-300, -300], hbShort, hbRight - i % 2]);              // 15,16
    for (let i = 0; i < 2;i++)
        p.push([doorG, left + 300 + 5 * 400 + (2 + i) * 400, fullH - headSH, 400, headSH, -90,
            [-300 - i * 400, -300 + i * 400], hbShort, hbRight - i % 2]);          // 17,18
    // Abschluss Seitenteil gross zu klein
    p.push([doorS, left + 300 + 5 * 400, fullH - headBH, 400, headBH - headSH, 90, [-300, -300]]);// 19
    // Abschluss Seitenteil oben
    p.push([doorS, left + 300 + 9 * 400, fullH - headSH, 400, headSH, 0, [-700 - 400, 500]]);     // 20
    // Schieber links
    p.push([doorG, left + heater, sockelH, drawW1 - heater,
        (tableH - drawH - sockelH) / 2, 0, [0, 0], hbLong, hbCenterTop]);           // 21
    p.push([doorG, left + heater, sockelH + (tableH - drawH - sockelH) / 2, drawW1 - heater,
        (tableH - drawH - sockelH) / 2, 0, [0, 0], hbLong, hbCenterTop]);           // 22
    p.push([doorM, left, tableH - drawH, drawW1, drawH, 0, [0, 0], hbLong2, hbCenterCenter]);// 23

    // Schieber unter Kochfeld
    p.push([doorG, left + drawW1, sockelH, drawW2,
        (tableH - drawH - sockelH) / 2, 0, [0, 0], hbLong, hbCenterTop]);           // 24
    p.push([doorG, left + drawW1, sockelH + (tableH - drawH - sockelH) / 2,
        drawW2, (tableH - drawH - sockelH) / 2, 0, [0, 0], hbLong, hbCenterTop]);    // 25
    p.push([doorM, left + drawW1, tableH - drawH, drawW2, drawH,
        0, [0, 0], hbLong, hbCenterCenter]);                                 // 26
    // Geschirrspueler
    p.push([doorM, left + 600 + 800, tableH - drawH, 600, drawH,
        0, [0, 0], hbLong, hbCenterCenter]);                                  // 27
    p.push([doorC, left + 600 + 800, sockelH, 600,
        tableH - drawH - sockelH, 0, [0, 0], hbLong, hbCenterTop]);               // 28
    // Spuele 
    p.push([doorG, left + 2 * 600 + 800, sockelH, 600,
        tableH - sockelH, 0, [0, 0], hbLong, hbCenterTop]);                     // 29
    // Eckschrank 
    p.push([doorG, left + 3 * 600 + 800, sockelH, 600,
        tableH - sockelH, -90, [0, 0], hbLong, hbCenterTop]);                   // 30
    // Abschluss Seitenteil unten
    p.push([doorS, left + 4 * 600 + 800, 0, 600, tableH, 0, [-600, 600]]);                    // 31
    // Rückwand 
    p.push([glass, left + 400 + 700, tableH, 400 * 4, fullH - tableH - headBH, 0, [-700, -700]]); // 32
    p.push([glass, left + 400 + 700 + 4 * 400, tableH, 400 * 3,
        fullH - tableH - headSH, 0, [-700, -700]])                        // 33
    
    let s = '';
    console.log('parts.length', p.length);
    for (let i = 0; i < p.length; i++) {
        s += p[i][0](p[i]);
    }
    return s;
}


export {parts}