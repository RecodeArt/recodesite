---
title: "RasterWalk"
translator: "polygonsoup"
translator_url: "https://www.instagram.com/polygonsoup/"
slug: "polygonsoup-rasterwalk-direct-random-walk-through-raster-frieder-nake"
artwork_slug: "v1n4-random-walk-through-raster"
category: "direct"
description: 'Direct translation of Frieder Nake''s 1966 "Random Walk Through Raster" from Computer Graphics and Art, May, 1976, Vol. 1, No. 4, Pg 6-7'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
  //------------------------------------------------------------
const settings = 
{
  debug    : false,
  nCols    : 50,
  nRows    : 50,
  xFreq    : 0.5,
  yFreq    : 0.02,
  opt      : 2, // Les 4 variations (0 -> 3)
}

//------------------------------------------------------------
function setup() 
{
  createCanvas(600,600);
  noLoop();
}

//------------------------------------------------------------
async function draw() 
{
  background(240);
  noFill();
  strokeWeight(2);
  randomSeed(Math.floor(Math.random()*999999));
  let xMargin = width * 0.05;
  let xDim    = (width - 2 * xMargin) / settings.nCols;
  let yMargin = (height - (settings.nRows * xDim)) * .5;
  let yDim    = xDim;


  // BEGIN DRAW
  push();

  for (let j = 0; j < settings.nRows; j++) {
    for (let i = 0; i < settings.nCols; i++) {
      let x = xMargin + i * xDim;
      let y = yMargin + j * yDim;
      let n = scalarField(x, y, xMargin, yMargin, settings.opt);
      let noiseVal = random() * noise(x * settings.xFreq, y * settings.yFreq);
      let tile = 2;
      if      (n*random()>0.2) {tile = 2}
      else if (noiseVal  <0.05){tile = 0}
      else if (noiseVal  <0.9) {tile = 1}
      settings.debug ? debugTile(x, y, xDim, xDim, n) : drawTile(x, y, xDim, xDim, tile);
    }
  }

  pop();
  // END DRAW

}

//------------------------------------------------------------
function drawTile(x, y, w, h, tile) {
  if (tile === 0) { line(x, y, x + w, y) }
  else if (tile === 1) { line(x + w, y, x + w, y + h) }
}

//------------------------------------------------------------
function debugTile(x, y, w, h, t) {
  push();
  fill(t * 255);
  stroke(t * 255);
  rect(x, y, w, h);
  pop();
}

//--------------------SCALAR-FIELD----------------------------
function scalarField(x, y, xMargin, yMargin, opt) {
  let n = 1;
  const optFns = [
    // Diagonale
    () => { let a = map(x, xMargin, width - xMargin, -0.5, 0.5); let b = map(y, yMargin, height - yMargin, 0.5, -0.5); n = abs(a + b) },
    // Disque bas droite
    () => { let a = map(x, xMargin, width - xMargin, 0, 1); let b = map(y, yMargin, height - yMargin, 0, 1); n = a * b; },
    // Gradient vertical
    () => n = abs(map(y, height / 2, height - yMargin, 0, 0.5) ),
    // Disque central
    () => {
        let A = (width / 2) - xMargin;
        let B = (height / 2) - yMargin;
        let hyp = Math.sqrt(A * A + B * B);
        let d = dist(width / 2, height / 2, x, y) / hyp;
        n = (1 - d) * (1 - d)  
    },
  ]
  optFns[opt]();
  return n;
}

//------------------------------------------------------------
function keyPressed() {
  if (key == ' ') {
    redraw();
  }
}

</script>
