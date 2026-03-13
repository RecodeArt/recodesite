---
title: "Variations on Untitled Serigraphs"
translator: "Alba Francesca Battista"
translator_url: "https://independent.academia.edu/AlbaBattista"
slug: "alba-francesca-battista-variations-on-untitled-serigraphs-experimental-untitled-serigraphs-belfort-group"
artwork_slug: "v2n2-untitled-serigraphs"
category: "experimental"
description: "Copyright (c) 2013 Alba Francesca Battista - OSI/MIT license (http: //recodeproject/license)."
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled Serigraphs" by Belfort Group
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2013 Alba Francesca Battista  - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int x=20; 
int y=50; 
int i=0; 
int j=0; 
int larghezza=320; 
int lunghezza=60; 
int vicini=80; 
int offset=50; 
float A; 
float G; 


void setup() 
{ 
size(600,800); 
background(0); 
strokeWeight(0); 
smooth(); 
stroke(255); 
noLoop(); 
} 

void draw() 
{ 
background(0); 

for (int k = 0; k < 1000; k++) 
{ 
A=random(width); 
G=random(height); 
strokeWeight(random(0.1,.8)); 
point(A, G); 
} 

strokeWeight(2); 

for (int i=-50; i<lunghezza; i=i+(int)random(2,6)) 
{ 
for (int j=99-i; j<larghezza; j=j+(int)random(1,6)) 
{ x = j-(i/3)+vicini; 
if (y<180 && x>(235+random(0,4))){ } 
else{ 

point(x, y); 
point(width-x, height-y); 
} 
} 


y = (y<=height ? y=y+(int)random(2,28)+j+2 : 0); 

} 
} 

void mousePressed() 
{ 
redraw(); 
x=20; 
y=offset; 
}
