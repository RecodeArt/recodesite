---
title: "P5Aeleana"
translator: "Makio135"
translator_url: ""
slug: "makio135-p5aeleana-direct-aeleana-manuel-barbadillo"
artwork_slug: "v1n2-aeleana"
category: "direct"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Aeleana" by Manuel Barbadillo
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Makio135 - OSI/MIT license (http://recodeproject/license).
*/

void setup() {
	size(400, 400);
}

void draw() {
	drawPattern(0, 0, 200, true, 0);
	drawPattern(200, 0, 200, false, PI/2);
	drawPattern(0, 200, 200, false, -PI/2);
	drawPattern(200, 200, 200, true, PI);
}

void drawPattern(int x, int y, int Size, boolean black, float angle) {
	PGraphics pg = createGraphics(200, 200, JAVA2D);
	pg.beginDraw();
	pg.smooth();
	pg.noStroke();
	pg.background(black?0:255);
	pg.pushMatrix();
	pg.translate(Size/2, Size/2);
	pg.rotate(angle);
	pg.fill(black?255:0);
	pg.rect(-125, -100, Size+25, Size, 25, 25);
	pg.fill(black?0:255);
	pg.rect(-125, -100, Size, Size-25, 25, 25);

	for (int i=0; i<6;i++) {
		black=!black;
		pg.fill(black?0:255);
		pg.rect(-125, -125, Size/2+25, 175-i*25, 25, 25);
	}

	for (int i=0; i<4;i++) {
		black=!black;
		pg.fill(black?0:255);
		pg.rect(0, -Size/2+i*25, Size/2-i*25, (i==0)?Size/2:Size-(2*i)*25, (Size/2-i*25>25)?25:15, (Size/2-i*25>25)?25:15);
	}

	pg.popMatrix();
	pg.endDraw();

	image(pg, x, y);
}
