---
title: "RP_harmonicStory"
translator: "Alexandre Rivaux"
translator_url: "http://www.bonjour-lab.com/"
slug: "alexandre-rivaux-rp-harmonicstory-direct-harmonic-story-jean-claude-marquette"
artwork_slug: "v1n2-harmonic-story"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Harmonic Story" by Jean Claude Marquette
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Alexandre Rivaux - OSI/MIT license (http://recodeproject/license).
*/

let myPattern;
let nbPattern;

function setup()
{
  createCanvas( 500, 500);
  background(140);
  rotate(radians(-1)); //rotation de -0.01 radian pour etre calé avec la création originale
  nbPattern = 2;
  myPattern = new Array(nbPattern);
  for(let i=0; i<nbPattern; i++)
  {
    myPattern[i] = new Pattern(i);
    myPattern[i].display();
  }

}

function draw()
{

}

function mousePressed()
{
  rotate(radians(-1)); //rotation de -0.01 radian pour etre calé avec la création originale
  background(140);
  for(let p of myPattern)
  {
   p.update();
  }
}

/*Class Pattern*/

class Pattern
{
  /*
  l'idée ici est de dessiner une grille de 270*2
   composée de carrés de 18 pixels de cotés. (donc double boucle for)

   par la suite chaque couleur du carré sera définie de manière aléatoire
   et en binaire. Pour chacun des carrés nous attribuons une valeur entière
   random comprise entre 0 et 1.

   Si cette valeur est égales à 1 alors nous remplirons notre carré
   avec la couleurs de fond grise.
   Si elle est égales à 0 nous n'appliquerons pas de couleur de fond.

   Enfin nous dessinons nos rectangles.

   Au clic de la souris nous regenerons le visuel.
   */
  //variables

  //constructor
  constructor(_greyLevel)
  {
    this.heightPattern = 270;
    this.widthPattern = 270;
    this.tailleRect = 18;
    this.range=0;
    this.greyLevel = int(map(_greyLevel, 0, 1, 200, 44));

    this.x = new Array(this.widthPattern/this.tailleRect);
    this.y = new Array(this.heightPattern/this.tailleRect);

    for(let i = 0; i< this.widthPattern/this.tailleRect; i++)
    {
      this.x[i] = i*this.tailleRect;
    }

    for(let j = 0; j< this.heightPattern/this.tailleRect; j++)
    {
      this.y[j] = j*this.tailleRect;
    }

    this.posX = this.x[int(random(1, this.x.length-2))];
    this.posY = this.y[int(random(1, this.y.length-2))];

  }
  //function display
  display()
  {
    push();
    translate(this.posX, this.posY);
    for (let i = 0; i< this.widthPattern/this.tailleRect; i++) {
      for ( let j = 0; j < this.heightPattern/this.tailleRect; j++ ) {
        this.range = int(random(0, 2));
        noStroke();
        if ( this.range == 1) {
          fill(this.greyLevel);
        }
        else {
          noFill();
        }

        /*marge internes*/
        if(this.greyLevel==200)
        {
          if(i<2)
          {
            fill(this.greyLevel);
          }
          if(i==2)
          {
            noFill();
          }
        }
        if(this.greyLevel==44)
        {
          if(i>this.x.length-3)
          {
            fill(this.greyLevel);
          }
          if(i==this.x.length-3)
          {
            noFill();
          }
        }
        rect( i*this.tailleRect, j*this.tailleRect, this.tailleRect+1, this.tailleRect+1 );
        /*
        Ici pour éviter l'impression de bordure pour chacun des carrés du à la rotation.
         nous faisons des carrés plus grand de 1 pixel que la grille de sorte à ce qu'il
         débordent les un sur les autres.
         */
      }
    }
    pop();
  }

  //update function
  update()
  {
    this.posX = this.x[int(random(1, this.x.length-2))];
    this.posY = this.y[int(random(1, this.y.length-2))];
    this.display();
  }
}
</script>
