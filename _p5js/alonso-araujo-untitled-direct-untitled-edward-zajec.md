---
title: "Untitled"
translator: "Alonso Araujo"
translator_url: ""
slug: "alonso-araujo-untitled-direct-untitled-edward-zajec"
artwork_slug: "v2n4-untitled-zajec"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 Alonso Araujo - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  createCanvas(500, 650);
  noStroke();
  background(255);
  ellipseMode(CENTER);
  rectMode(CENTER);
}

/*
Each one of the figures in this piece is drawn by a separate function,
that way we could customize their behavior in the future.
Each one of the figures were previously studied to be the more accurate possible
to the original piece.
At the beginning of each one of the functions are defined the different values
used to create the figures.
*/
function draw() {

  drawCenterEllipse();
  drawCenterRectangle();
  drawUpperRectangle();
  drawUpperCircle();
  drawBottomCircle();
  drawTriangle();

}

function drawCenterEllipse(){

  let diameterMax = 460;
  let diameterMin = 30;
  let positionX = 205;
  let positionY = 205;

  for(let d = diameterMin; d < diameterMax; d = d + 33){

    stroke(1,10);
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);

  }

}


function drawCenterRectangle(){

  let diameterMax = 250;
  let diameterMin = 15;
  let positionX = 317;
  let positionY = 460;
  push();
  translate(positionX,positionY);
  rotate(0.6);

  for(let d = diameterMin; d < diameterMax; d = d + 10){


    stroke(1,10);
    strokeWeight(1.2);
    fill(255,255,255,0);
    if(d + 10 < diameterMax)
      rect(0, 0, d, d,3);
    else
      rect(0, 0, d, d);

  }
  pop();

}

function drawUpperRectangle(){

  let diameterMax = 150;
  let diameterMin = 15;
  let positionX = 288;
  let positionY = 180;
  push();
  translate(positionX,positionY);
  rotate(0.6);

  for(let d = diameterMin; d < diameterMax; d = d + 10){

    stroke(1,10);
    strokeWeight(1.2);
    fill(255,255,255,0);
    if(d + 10 < diameterMax)
      rect(0, 0, d, d,3);
    else
      rect(0, 0, d, d);

  }
  pop();


}

function drawUpperCircle(){

  let diameterMax = 124;
  let diameterMin = 1;
  let positionX = 375;
  let positionY = 250;

  for(let d = diameterMin; d < diameterMax; d = d + 6){

    stroke(0.5,2);
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);

  }

}

function drawBottomCircle(){

  let diameterMax = 240;
  let diameterMin = 5;
  let positionX = 470;
  let positionY = 525;

  for(let d = diameterMin; d < diameterMax; d = d + 10){

    stroke(0.5,2);
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);

  }

}

function drawTriangle(){

  let x1 = 10;
  let y1 = 32;
  let x2 = 116;
  let y2 = 92;
  let x3 = 116;
  let y3 = -33;
  let maxTriangles = 70;

  for(let i = 0; i < maxTriangles; i = i + 5){

    stroke(0.5,20);
    strokeWeight(2);
    fill(255,255,255,0);
    triangle(x1 + i, y1, x2 - i/2, y2 - i, x3 - i/2, y3 + i);

  }

}
</script>
