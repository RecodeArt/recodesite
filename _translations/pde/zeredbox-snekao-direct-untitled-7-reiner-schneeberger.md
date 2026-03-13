---
title: "Snekao"
translator: "zeredbox"
translator_url: "https://linktr.ee/zeredbox"
slug: "zeredbox-snekao-direct-untitled-7-reiner-schneeberger"
artwork_slug: "v3n2-untitled-7-schneeberger"
category: "direct"
description: "Based on \"SNEKAO\" by Hans Corneder Originally published in \"Computer Graphics and Art\", 1978 p. 13 and 23/24"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 7" by Reiner Schneeberger
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2023 zeredbox - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

/*
Part of the ReCode Project (http://recodeproject.com)
Based on "SNEKAO" by Hans Corneder

Originally published in "Computer Graphics and Art", 1978 p. 13 and 23/24
https://github.s3.amazonaws.com/downloads/matthewepler/ReCode_Project/COMPUTER_GRAPHICS_AND_ART_May1978.pdf

Recode project : http://recodeproject.com/artwork/v3n2untitled-7-schneeberger

January 2023
zeredbox : https://github.com/zeredbox
contact : https://linktr.ee/zeredbox
*/

// Global variables

const cellsNb = 10;  // Number of cells. Try 5 to 100
let cellSize;        // Cells size

// Lines density. Try values from 1 (max) to 5 (min)
const vLinesDensity = 3;  // Verical lines
const hLinesDensity = 5;  // Horizontal lines

// Stroke weight. Try values from 0.1 to 5
const strokeWVlines = 1.2;  // Stroke vertical lines
const strokeWHlines = 0.3;    // Stroke horizontal lines

function setup() {
  createCanvas(500, 500);
  // Calculate cells size
  cellSize = width/cellsNb;
  
  strokeCap(SQUARE);
  stroke(50);
  noLoop();
}

function draw() {
  background(245);
  drawLines();
}

function mousePressed() {
  draw();
}

function drawLines(){

  for (let i = 0; i < width / cellSize; i++){
    for (let j = 0; j < height / cellSize; j++){
     
      // Draw horizontal or lines ?
      let rand = floor(random(0, 2));

      let x = i * cellSize;
      let y = j * cellSize;  

    switch (rand) {
                 
      // Draw horizontal lines
      case 0:
        strokeWeight(strokeWHlines);
        for (let i=0; i<cellSize; i+=hLinesDensity){
          line(x, y+i, x+cellSize, y+i);
          }
        break;
        
      // Draw vertical lines
      case 1: 
        strokeWeight(strokeWVlines);
        for (let i=0; i<cellSize; i+=vLinesDensity){
          line(x+i, y, x+i, y+cellSize);
          }
        break;
      }
    }
  }
}
