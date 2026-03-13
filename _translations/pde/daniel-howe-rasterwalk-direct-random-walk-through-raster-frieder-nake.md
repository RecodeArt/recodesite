---
title: "RasterWalk"
translator: "Daniel Howe"
translator_url: "http://rednoise.org/~dhowe/"
slug: "daniel-howe-rasterwalk-direct-random-walk-through-raster-frieder-nake"
artwork_slug: "v1n4-random-walk-through-raster"
category: "direct"
description: "Direct translation of Frieder Nake's 1966 \"Random Walk Through Raster\" from Computer Graphics and Art, May, 1976, Vol. 1, No. 4, Pg 6-7 Copyright (c) 2012 Daniel C. Howe. To see this sketch run in JavaScript, go to: http://rednoise.org/sketches/RasterWalk/"
runs_in_browser: 
---
/*
 * This sketch is part of the ReCode Project - http://recodeproject.com
 * Computer Graphics and Art - May, 1976 - Vol. 1, No. 4 - Pg 6-7
 *
 * "Random Walk Through Raster"
 * by Frieder Nake, 1966
 *
 * direct recode by Daniel C. Howe
 *
 * Copyright (c) 2012 Daniel C. Howe
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:

 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

var x=50, y=50, cellSz, grid=[];
var DOWN=1, RIGHT=2, px=0, py=0, sw=2;

void setup() {

    size(400,400); 

    background(255);
    noFill();
    strokeWeight(sw); 
    strokeCap(PROJECT);

    makeGrid();
    foreach(drawCell);

    step();
}


function drawCell(j,i) {

    // skip one row/col around edge
    if (i > 0 && j < y-1 && i < y-1 && i < x-1 && j < x-1) {

        var off = 0;
        stroke(0);
        if (!exists(j, i, DOWN)) { 
            stroke(255); // erase
            if (j > 1) off = sw;
        }

        if (j  > 0) {
            line(j * cellSz + off, cellSz + i * cellSz, // horiz 
                    (j + 1) * cellSz-1, cellSz +(i * cellSz));
        } 

        off = 0;
        stroke(0);
        if (!exists(j, i, RIGHT)) {
            stroke(255); // erase
            if (i > 1) off = sw;
        }

        line((cellSz + j * cellSz), i * cellSz + off, // vert 
                (cellSz + j * cellSz), (i + 1) * cellSz-1); 	
    }
}

function makeGrid() {

    cellSz = min(width,height) / x;

    for (var j = 0; j < x+1; j++) { 

        grid[j] = []; // initialize to 0 
        for (var i = 0; i < y+1; i++) 
            grid[j][i] = 0;
    }
}

function step() {

    var dirs = (Math.random() < .9)  ? [DOWN] : [RIGHT,DOWN];
    var idx = floor(random(dirs.length))  
    var dir = dirs[idx];
    remove(px, py, dir);

    // but weight verticals and the diagonal
    var d = dist(px,0,py,0) / x;
    if (Math.random()  < d) 
        remove(px, py, RIGHT);

    drawCell(px,py); 

    if (++px % x == 0) { px = 0; ++py; } 

    if (py < y-1 || px < x-1) 
        setTimeout(step, 0);
}

function foreach(fun) {

    for (var i = 0; i < y; i++) { 
        for (var j = 0; j < x; j++)  
            fun.apply(this,[j,i]);
    }	
}

function exists(j,i,side) {

    switch(side) {
        case RIGHT: return (grid[j][i] < 2);
        case DOWN:  return (grid[j][i] % 2==0);
    }
}

function remove(j,i,side) {

    if (exists(j,i,side)) 
        grid[j][i] += side;
}
