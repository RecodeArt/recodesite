---
title: "Detail from Tapestry"
translator: "Juan Sebastian Robles"
translator_url: ""
slug: "juan-sebastian-robles-detail-from-tapestry-direct-detail-from-tapestry-jean-claude-marquette"
artwork_slug: "v1n2-detail-from-tapestry"
category: "direct"
description: "A free adaptation/interpretation of the original piece, with a bit of extra \"little variation\""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Detail from Tapestry" by Jean Claude Marquette
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2020 Juan Sebastian Robles - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

float lim = random();

void setup()
{
    size(416, 500, P2D);
    fill(63);
    noStroke();
    background(240 * (lim * 10));
    drawSquares();
}


void drawSquare(int x, int y)
{
    
    for (int i = 0; i < 26; i+=2) {
        for (int j = 0; j < 26; j+=2) {
            if (random() > lim)
                rect(x + i, y + j, 2, 2);
        }
        
    }
}


void drawSquares()
{
    
    for (int i = (int)round(-10, 10); i < 20; ++i) {
        for (int j = (int)round(-10, 10); j < 20; ++j) {
            if (random() > lim)
                drawSquare(i * 26, j*26);
        }
        
    }
    
}

void mousePressed() {
  lim = random();
  background(240 * (lim * 10));
  drawSquares();
}
