---
title: "Social Circle"
translator: "Alonso Araujo"
translator_url: ""
slug: "alonso-araujo-social-circle-experimental-untitled-edward-zajec"
artwork_slug: "v2n4-untitled-zajec"
category: "experimental"
description: '"Social Circle" represents the evolution of a social circle of shapes, where the influence of the larger group compels a minority to resemble them in order to stay in the circle.'
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

/*
Part of the ReCode Project (http://recodeproject.com)
"Social Circle" by Alonso Araujo
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 Alonso Araujo - OSI/MIT license (http://recodeproject/license).
Contact alonso.araujo@outlook.com

"Social Circle" represents the evolution of a social circle of shapes,
where the influence of the larger group compels a minority to resemble
them in order to stay in the circle.

Controls
Move the mouse over the piece to go further in time and see the evolution of the
social circle.
*/

let numero = 1;
let colur = 2;
let rotar = 0.6;
let rotar2 = 1;
let number2 = 1;
let colur2 = 2;
let number3 = 1;
let colur3 = 2;
let triangleOpacity = 255;
let began = 1;

function setup() {
  createCanvas(500, 650);
  noStroke();
  background(255);
  ellipseMode(CENTER);
  rectMode(CENTER);
}

function draw() {

  drawCenterRectangle();
  drawUpperRectangle();
  if(began == 1){
    drawTriangle();
    drawCompleteCenterEllipse();
    drawCompleteUpperCircle();
    drawCompleteBottomCircle();
  }

}

function drawCenterEllipse(){

  let diameterMax = 460;
  let diameterMin = 30;
  let positionX = 205;
  let positionY = 205;

  if(colur == 1)
    stroke(255,0,0,110);
  else if (colur == 2)
    stroke(1,80);

  let d = 33 * numero;


    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);

}

function drawCompleteCenterEllipse(){

  let diameterMax = 460;
  let diameterMin = 30;
  let positionX = 205;
  let positionY = 205;

  for(let d = diameterMin; d < diameterMax; d = d + 33){

    stroke(0.9,10);
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
  rotate(rotar);

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
  rotate(rotar);

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

  if(colur3 == 1)
    stroke(255,0,0,90);
  else if (colur3 == 2)
    stroke(1,80);

  let d = number3 * 6;

    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);



}

function drawBottomCircle(){

  let diameterMax = 240;
  let diameterMin = 5;
  let positionX = 470;
  let positionY = 525;

  if(colur2 == 1)
    stroke(255,0,0,90);
  else if (colur2 == 2)
    stroke(1,80);

  let d = 10 * number2;

    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);



}

function drawCompleteUpperCircle(){

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

function drawCompleteBottomCircle(){

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
  push();
  translate(80,-40);
  rotate(rotar2);

  for(let i = 0; i < maxTriangles; i = i + 5){

    stroke(1,5 - (mouseX*0));
    strokeWeight(2);
    //fill(255,255,255,0);
    triangle(x1 + i, y1, x2 - i/2, y2 - i, x3 - i/2, y3 + i);

  }
  pop();
}

function mouseMoved(){

  numero++;
  number2++;
  number3++;

  if(numero*33 > 490){
    numero = 1;
    colur++;
  }

  if(number2*10 > 240){
    number2 = 1;
    colur2++;
  }

  if(number3*6 > 124){
    number3 = 1;
    colur3++;
  }

  if(colur > 2)
    colur = 1;
  if(colur2 > 2)
    colur2 = 1;


  drawCenterEllipse();
  drawBottomCircle();
  drawUpperCircle();
  drawTriangle();

  triangleOpacity = 0;
  rotar = rotar + 0.005;
  rotar2 = rotar2 + 0.005;
  began =0;
}
</script>
