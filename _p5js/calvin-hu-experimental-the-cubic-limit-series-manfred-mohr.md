---
title: "Cube Limit Series with Rotation"
translator: "Calvin Hu"
translator_url: ""
slug: "calvin-hu-experimental-the-cubic-limit-series-manfred-mohr"
artwork_slug: "v1n2-the-cubic-limit-series"
category: "experimental"
description: "None"
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
This sketch is part of the ReCode Project - http://recodeproject.com
From Computer Graphics and Art vol1 no2 pg 14
by Manfred Mhor
"The Cubic Limit Series"

Calvin Hu
2012
Creative Commons license CC BY-SA 3.0
*/

let offset = 30;
let interval = 30;
let bitPositions;
let permutation;

let rotateXAngle, rotateYAngle, rotateZAngle;

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
  frameRate(8);

  rotateXAngle = PI * 5/6;
  rotateYAngle = PI * -5/6;
  rotateZAngle = 0;
}

function draw(){
  let newPermutation = [true,true,true,true,true,true,false,false,false,false,false,false];
  let newBitPositions = [0, 1, 2, 3, 4, 5, 12];
  permutation = newPermutation;
  bitPositions = newBitPositions;
  background(0);
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
        rotateX(rotateXAngle);
        rotateY(rotateYAngle);
        rotateZ(rotateZAngle);
        draw_cube(15, permutation);
        anyPermsLeft = nextPermutation();
        pop();
    }
    pop();
  }
  pop();
  rotateXAngle += PI/60;
  rotateYAngle += PI/60;
  rotateZAngle += PI/60;
}
</script>
