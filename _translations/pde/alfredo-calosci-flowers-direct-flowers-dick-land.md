---
title: "Flowers"
translator: "Alfredo Calosci"
translator_url: "http://www.negot.net/"
slug: "alfredo-calosci-flowers-direct-flowers-dick-land"
artwork_slug: "v3n2-flowers"
category: "direct"
description: "[C] show construction lines [N] cleaup Canvas [S] Save Canvas as png https://www.openprocessing.org/sketch/891937"
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Flowers" by Dick Land
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2020 Alfredo Calosci - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

// a port to processing of:
// "Flowers" by Dick Land and Dan Cohen
// pubblished on "Computer Graphics and Art num __ may 1978
// https://github.com/downloads/matthewepler/ReCode_Project/COMPUTER_GRAPHICS_AND_ART_May1978.pdf
// part of RECODE Project - http://recodeproject.com/
// [C] show construction lines [N] cleaup Canvas [S] Save Canvas as png
// https://www.openprocessing.org/sketch/891937


var a1,a2,a3;
var r1,r2,r3;
var P0, P1, P2, P3;
var lines = [];

var maxLines = 5000;
var speed = 0.05;

var w1, w2, w3, w4;
var showC = false;

var slider_1, slider_2, slider_3, slide_4;
var c;

function setup() {
	c = createCanvas(windowWidth, windowHeight);
	background(0);
	frameRate(24);
	
	r1 = r2 = r3 = windowWidth/12;
	// r2 = r1*0.61803;
	// r3 = r2 * 0.61803;
	
	a1 = a2= a3 = 0;
	
	P0 = createVector(windowWidth/2, windowHeight/2);
	P1 = createVector(P0.x + (cos(a1)*r1), P0.y + (sin(a1)*r1) );
	P2 = createVector(P1.x + (cos(a2)*r2), P1.y + (sin(a2)*r2) );
	P3 = createVector(P2.x + (cos(a3)*r3), P2.y + (sin(a3)*r3) );
	
	w1 = random();
	w2 = random();
	w3 = random();
	w4 = windowWidth/12;
	
	slider_1 = createSlider(-1, 1, w1, 0.05);
  slider_1.position(10, 24);
  slider_1.style('width', '120px');
	
	slider_2 = createSlider(-1, 1, w2, 0.05);
  slider_2.position(10, 24*2);
  slider_2.style('width', '120px');
	
	slider_3 = createSlider(-1, 1, w3, 0.05);
  slider_3.position(10, 24*3);
  slider_3.style('width', '120px');
	
	slider_4 = createSlider(windowWidth/48, windowWidth/4, w4, 1);
  slider_4.position(10, 24*5);
  slider_4.style('width', '120px');
	
}

function draw() {
	background(0);
	stroke(255);
	strokeWeight(1);
	
	// store Line
	if(frameCount%2 == 0){
			let new_loc = [P2.x, P2.y, P3.x, P3.y];
			lines.push(new_loc);
	}
	
	if(showC){
		stroke(200,0,0);
		line(P0.x, P0.y, P1.x, P1.y);
		line(P1.x, P1.y, P2.x, P2.y);
	}	
	
	stroke(255,128);
	// draw all lines
	for (let item of lines) {
 		line(item[0], item[1], item[2], item[3]);
		//console.log(item);
	}
	
	// draw last line
	stroke(255);
	strokeWeight(3);
	line(P2.x, P2.y, P3.x, P3.y);
	
	
	// increments a
	a1+= w1*speed;
	a2+= w2*speed;
	a3+= w3*speed;
	
	// updates P
	P1.x = P0.x + (cos(a1)*r1);
	P1.y = P0.y + (sin(a1)*r1);
	
	P2.x = P1.x + (cos(a2)*r2);
	P2.y = P1.y + (sin(a2)*r2);
	
	P3.x = P2.x + (cos(a3)*r3);
	P3.y = P2.y + (sin(a3)*r3);
	
	// updates variables
	w1 = slider_1.value();
	w2 = slider_2.value();
	w3 = slider_3.value();
	w4 = slider_4.value();
	
	r1 = r2 = r3 = w4;
	
}

function keyPressed() {
	if (keyCode === 67) {
		showC = !showC;
	}
	
	if (keyCode === 78) {
		lines = [];
	}
	
	if (keyCode === 83) {
		// lines = [];
		saveCanvas(c, 'myCanvas', 'png');
	}
}
