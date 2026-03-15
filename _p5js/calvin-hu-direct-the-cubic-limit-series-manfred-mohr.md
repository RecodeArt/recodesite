---
title: "Cube Limit Series"
translator: "Calvin Hu"
translator_url: "http://www.calvin.hu/"
slug: "calvin-hu-direct-the-cubic-limit-series-manfred-mohr"
artwork_slug: "v1n2-the-cubic-limit-series"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Cube Limit Series - Inward" by Manfred Mohr
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Calvin Hu - OSI/MIT license (http://recodeproject/license).
*/

let offset = 30;
let interval = 30;
let bitPositions = [0, 1, 2, 3, 4, 5, 12];
let permutation = [true,true,true,true,true,true,false,false,false,false,false,false];

function draw_cube(slength, permutation){
  let side = slength/2;
  let start_point = -side;
  if(permutation[0])
    line(start_point, start_point, start_point, start_point, start_point, side);
  if(permutation[1])
    line(start_point, start_point, start_point, start_point, side, start_point);
  if(permutation[2])
    line(start_point, start_point, start_point, side, start_point, start_point);
  if(permutation[3])
    line(start_point, start_point, side, start_point, side, side);
  if(permutation[4])
    line(start_point, start_point, side, side, start_point, side);
  if(permutation[5])
    line(start_point, side, start_point, side, side, start_point);
  if(permutation[6])
    line(start_point, side, start_point, start_point, side, side);
  if(permutation[7])
    line(side, start_point, start_point, side, side, start_point);
  if(permutation[8])
    line(side, start_point, start_point, side, start_point, side);
  if(permutation[9])
    line(side, side, start_point, side, side, side);
  if(permutation[10])
    line(side, start_point, side, side, side, side);
  if(permutation[11])
    line(start_point, side, side, side, side, side);
}

function swap_boolean_array(boolArr, indexFrom, indexTo){
  let temp = boolArr[indexTo];
  boolArr[indexTo] = boolArr[indexFrom];
  boolArr[indexFrom] = temp;
  return boolArr;
}

function nextPermutation(){
   for(let i = 5; i >= 0; i--){
     if(bitPositions[i] + 1 < bitPositions[i + 1]){
       permutation = swap_boolean_array(permutation, bitPositions[i], ++bitPositions[i]);
       if(i < 5){
         for(let j = i + 1 ; j < 6; j++){
           permutation = swap_boolean_array(permutation, bitPositions[j], bitPositions[j - 1] + 1);
           bitPositions[j] = bitPositions[j - 1] + 1;
         }
       }
       return true;
     }
   }
   return false;
}

function setup(){
    createCanvas(990, 990, WEBGL);
    ortho();
    background(0);
    noFill();
    stroke(255);
    for(let i = 0; i < 32; i++){
      let columnX = offset + i * interval;
      line(columnX, offset, columnX, height - offset);
    }
    for(let i = 0; i < 32; i++){
      let rowY = offset + i * interval;
      line(offset, rowY, width - offset, rowY);
    }


    let anyPermsLeft = true;
    push();
    translate(32 * interval + offset/2, offset/2);
    for(let i = 0; i < 31 && anyPermsLeft; i++){
      translate(-interval, 0);
      push();
      for(let j = 0; j < 31 && anyPermsLeft; j++){
          translate(0, interval);
          push();
          rotateX(PI * 5/6);
          rotateY(PI * -5/6);
          draw_cube(15, permutation);
          anyPermsLeft = nextPermutation();
          pop();
      }
      pop();
    }
    pop();
}

function draw(){
}
</script>
