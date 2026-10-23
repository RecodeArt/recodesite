---
title: "Segrid"
translator: "v3ga"
translator_url: "https://www.v3ga.net"
slug: "v3ga-segrid-direct-segrid-john-roy"
artwork_slug: "v1n2-segrid"
category: "direct"
description: ''
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
// Recode of Segrid | John Roy | 1973
// diagram here : https://www.ragnardigital.art/collection/segrid


let res               = 17;   // resolution 
let nbLinesMin        = 1;
let nbLinesMax        = 9;
let nbLinesHalfCell   = 5;    // used to compute the 'gap' between lines in a cell
let margin            = 0.05; // % of width
let sw                = 1.5;  // line width in pixels
let bDrawGrid         = false;

function setup() 
{
  createCanvas(800, 800);
  noLoop();
}

function draw() 
{
  background(0);
  noFill();
  strokeCap(ROUND);
  stroke(255);
  strokeWeight( sw );
  
  // Grid
  if (bDrawGrid)
    drawGrid();
  
  // Patterns
  let m = margin*width; 
  let d = (width-2*m)/res;
  let cx = (res - 1) / 2;
  let cy = (res - 1) / 2;
  let dMax = floor(res / 2);
  
  for (let j=0; j<res; j++)
    for (let i=0; i<res; i++)
    {
      // Coordinates of (i,j) cell
      let x = m+i*d;
      let y = m+j*d;
      
      // Density
      let dst = max(abs(i - cx), abs(j - cy));
      let n = map(dst / dMax,0,1,nbLinesMax,nbLinesMin);

      // Draw pattern
      drawPattern(x,y,d,i,j,n);              
    }
}

function drawPattern(x,y,d,i,j,n)
{
  let d2  = d/2;
  let gap = d2 * 1/nbLinesHalfCell;
  
  push();
  translate(x+d2, y+d2);

  let offset = d/(2*n)/2;
  for (let a=0;a<4;a++)
  {
    push();
    rotate(a*PI/2)
    let y = -d2+gap; 
    for (let k=0;k<n;k++)
    {
      line(-d2,y,0,y)
      y += gap;
    }
    pop();
    
  }
  
  pop();
}


function drawGrid()
{
  push();
  stroke(255,80);
  strokeWeight(1);

  let m = margin*width; 
  for (let i=0; i<=res; i++)
  {
     let x = map(i,0,res,m,width-m);
     line(x,m,x,height-m);
  }  
  for (let j=0; j<=res; j++)
  {
     let y = map(j,0,res,m,height-m);
     line(m,y,width-m,y);
  }  
  pop();
}  
</script>
