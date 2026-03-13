---
title: "Structure Square"
translator: "Fabien bonnamy"
translator_url: ""
slug: "fabien-bonnamy-structure-square-direct-structure-square-series-inwards-roger-coqart"
artwork_slug: "v1n3-structure-square-series-inwards"
category: "direct"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure Square Series Inwards" by Roger Coqart
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2013 Fabien bonnamy - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int x1,x2,y1,y2,aleatoire,ecart,marge,taille; 
int h = 18; // Mettre un multiple de 3
int[] check = {0,1,2,3,4,5,6,7};
int[][] lines = { {0,0,h,h}, {h,0,0,h}, {h/2,0,h/2,h}, {0,h/2,h,h/2}, {0,h/2,h/2,0}, {0,h/2,h/2,h}, {h/2,0,h,h/2}, {h,h/2,h/2,h} }; 

void setup(){
	noLoop(); // j'utilise le noLoop car je ne souhaite pas la fonction draw() soit exetuté plus d'une fois 
	smooth(); // pour que mes traits soient plus net
	aleatoire = 0; //
	marge = h/3; // l'espace entre les carrés
	ecart = h+marge; // la place dans laquelle evelue un carré
	taille = ((h+marge)*13); // la taille de mon carré
	size(taille +marge , taille + marge, OPENGL); // notez que rajoute marge encore une fois afin dessiner la border droit et bas
}

void draw(){
	background(255);
	translate(marge,marge);// je deplace le point initial de mon ecran pour creer une marge en haut et à gauche
	stroke(0);
	strokeWeight(1); // traits sont noir

	// j'utilise une double bouble for pour placé chaque carrés sur l'ecran. 
	// Ici je place 15 carrés en long (i) et 15 en large (j)
	for (int i = 0; i <15; i++){
		for (int j = 0; j < 15; j++){
			//Je deplace le point 0,0 de mon ecran à chaque tour de boucle. cela me permet de toujour utilser 0,0 comme point de reference.
			// pour ce faire je vais un translate encapsuluer avec mon code dans un pushMatrix, popMatrix
			pushMatrix();
			translate(i*ecart, j*ecart);
			fill(255,255,255);

			//maintenant en fonction de l'emplacement de mon carré je dessine plus ou moins de trais à l'interieur

			// carré est au centre
			if(j == 6 && i == 6){
				rect(0, 0, h, h);
			}
			// carrés sont 1 carré du centre
			else if(j>=5 && j<8 && i>=5 && i<8){
				rect(0, 0, h, h);	
				strokeWeight(2);
				generateLines(2);
			}
			// carrés sont 2 carrés du centre
			else if(j>=4 && j<9 && i>=4 && i<9){
				rect(0, 0, h, h);	
				strokeWeight(2);
				generateLines(3);
			}
			// carrés sont 3 carrés du centre
			else if(j>=3 && j<10 && i>=3 && i<10){
				rect(0, 0, h, h);	
				strokeWeight(2);
				generateLines(4);
			}
			// carrés sont 4 carré du centre
			else if(j>=2 && j<11 && i>=2 && i<11){
				rect(0, 0, h, h);	
				strokeWeight(2);
				generateLines(5);
			}
			// carrés sont 5 carré du centre
			else if(j>=1 && j<12 && i>=1 && i<12){
				rect(0, 0, h, h);	
				strokeWeight(2);
				generateLines(6);
			}
			// carrés sont 6 carré du centre
			else if(j>=0 && j<13 && i>=0 && i<13){
				rect(0, 0, h, h);	
				strokeWeight(2);
				generateLines(7);
			}
			popMatrix();
		}	
	}
	//decommenter pour enregistrer l'image produite
	//saveFrame("squareColor"+h+".jpg");
}

// fonction qui recoit un nombre de lignes en arguments
// Cette dessine les trais et fait aussi attention ne pas en dessiner les uns sur les autres
void generateLines(int numberOfLines) {
	// nous avons un tableau initial allant de 0 à 7
	// on echange quelques valeurs 
	for (int i = 0; i<numberOfLines-1; i++){
		int rand1 = int(random(8));
		int rand2 = int(random(8));
		int temp;

		temp = check[rand1];
		check[rand1] = 	check[rand2];
		check[rand2] = temp;
	}

	// puis on lit un nombre d'entrées egale à l'argument passé
	for (int i = 0; i< numberOfLines; i++){
		aleatoire = check[i];
		line(lines[aleatoire][0], lines[aleatoire][1], lines[aleatoire][2], lines[aleatoire][3]);	
	}
}
