---
title: "ReCode_Hieroglyphs"
translator: "Arnaud Coolsaet"
translator_url: "http://www.dotburo.com/"
slug: "arnaud-coolsaet-recode-hieroglyphs-direct-untitled-1-aaron-marcus"
artwork_slug: "v3n2-untitled-marcus1"
category: "direct"
description: "You can set incrementBoxes to false to distribute the squares according to a fixed range throughout the sketch. If set to true (default) the range widens as more boxes appear, mimicking the original that ends up cluttered with white boxes. - my first Processing sketch :)"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Aaron Marcus
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Arnaud Coolsaet - OSI/MIT license (http://recodeproject/license).
*/

let xPos, xPosStart, boxIndex;
let yPos, rowCount;
let prevEl;
let rowStarted, incrementBoxes = true;

function setup()
{
  createCanvas(420, 560);
  background(0);
  stroke(255);

  xPos = 0;
  yPos = 35;

  rowCount = 32;
  rowStarted = true;

  boxIndex = 0.1;
}

function draw()
{
  while ( rowCount > 0 )
  {
    // randomly choose a fn
    let rIndex = random(15);

    // increment possible range for boxes
    if ( incrementBoxes && rIndex >= 0 && rIndex <= boxIndex && boxIndex < 12)
    {
        aBox();
        boxIndex += random(1)/5;
    }
    // else distribute them through fixed range
    else if ( !incrementBoxes && rIndex >= 3 && rIndex <= 6 )
    {
        aBox();
    }
    // ranges for other shapes
    else if ( rIndex >= 7  && rIndex <= 8 && rowCount < 27 && rowCount > 19 )
    {
      aCircle();
    }
    else if ( rIndex >= 9  && rIndex <= 10)
    {
      aDot();
    }
    else
    {
      aBar();
    }

    // set new line
    if ( xPos >= (width - xPosStart) )
    {
      rowCount--;
      yPos += 15;
      rowStarted = true;
    }
  }
  noLoop();
}

// shape fns

function aCircle()
{
  fill(0);
  strokeWeight(2);

  xPos = randomX( "circle" );

  ellipse( xPos, yPos+5, 8, 8 );
}

function aDot()
{
  strokeWeight(2);

  xPos = randomX( "dot" );

  line( xPos, yPos+6, xPos, yPos+7 );
}

function aBar()
{
  let shorter;

  strokeWeight(1);

  xPos = randomX( "bar" );

  if ( random(1) < 0.5 )
  {
    shorter = 1;
  }
  else
  {
    shorter = 0;
  }

  line( xPos, (yPos + shorter), xPos, (yPos + 12 - (shorter*3)) );
}

function aBox()
{

  xPos = randomX( "box" );

  if ( random(1) < 0.5 - boxIndex )
  {
    strokeWeight(1);
    fill(0);
  }
  else
  {
    strokeWeight(1);
    fill(255);

    let rGlitch = random(1);

    if ( rGlitch < 0.2 )
    {
      twoTrema();
    }
    else if ( rGlitch > 0.2 && rGlitch < 0.4 )
    {
      oneCirc();
    }
  }

  rect( xPos+1, yPos+1, 8, 8 );
}

function twoTrema()
{
  strokeWeight(1);

  line( xPos-1, yPos-2, xPos-1, yPos-1 );
  line( xPos-3, yPos-2, xPos-3, yPos-1 );

  line( xPos+7, yPos-2, xPos+7, yPos-1 );
  line( xPos+9, yPos-2, xPos+9, yPos-1 );
}

function oneCirc()
{
  fill(255);
  textSize(8);
  strokeWeight(1);

  line( xPos + 5, yPos-1, xPos+7, yPos-3 );
  line( xPos + 7, yPos-3, xPos + 9, yPos-1 );
}


// set 'random' x-position according to shape & previous shape

function randomX( what )
{

  if ( rowStarted == true )
  {
    rowStarted = false;

    xPos = random(80, 180);

    xPosStart = xPos;
  }
  else
  {
    if ( what == "circle" )
    {
        xPos += 15;
    }
    else if ( prevEl == "box" || prevEl == "circle" )
    {
        xPos += random(12, 17);
    }
    else if ( what == "dot" && ( prevEl == "dot" || prevEl == "line" ) )
    {
        xPos += 7;
    }
    else
    {
        xPos += random(2, 10);
    }
  }

  prevEl = what;

  return xPos;
}

function mouseClicked()
{
  background(0);

  xPos = 0;
  yPos = 30;

  rowCount = 32;
  rowStarted = true;

  boxIndex = 0.1;

  loop();
}
</script>
