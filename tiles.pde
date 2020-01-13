//"TILES"
// By Mira Keersmaekers, mira.keersmaekers@student.ehb.be, Erasmushogeschool Brussel - MulTec, 2015-2016.

// This program creates a grid of tiles in different shades of grey.
// The tiles are striped by black lines, creating a nice graphic entirety.

// Make sure canvas width and height are divisible by 100. (the tiles have a width of 100px)

size(1000, 1000);
background(00); 
colorMode(RGB, 100, 100, 100, 100);

randomSeed(3);

int m = height/100; //amount of tiles vertically
int n = width/100; //amount of tiles horizontally

for(int j = 0; j < m; j++){   // The vertical counter
 for(int i = 0; i < n; i++){ // The horizontal counter
    noStroke();
    rectMode(CORNERS); // Sets the rectMode to CORNERS so it's more easy to constrain them
    
    float ax = 5 + i * 100 + constrain(3 * randomGaussian(), -5, 5);  // x-position top-left corner
    float ay = 5 + j * 100 + constrain(3 * randomGaussian(), -5, 5);  // y-position top-left corner
    float bx = 95 + i * 100 + constrain(3 * randomGaussian(), -5, 5); // x-position bottom-right corner
    float by = 95 + j * 100 + constrain(3 * randomGaussian(), -5, 5); // y-position bottom-right corner
    float r = 10;                                                     // The radius of all four corners (static)
    
    //COMMENTS: 
    // The 5 + ... / 95 + ... sets the standard gap between two tiles to 2 times 5 px (10 px).
    // The randomGaussian()-function is used to vary this gap.
    // The constrain-function is used so the tile will never enter the tilezone of the tiles next to them.
        // The gap between two tiles will now always be between the range of [0, 20]
        
    rect(ax, ay, bx, by, r); // Draws the tile
    
    for(int k = 0; k < 8; k++){ // This iteration draws eight lines from left to right and eight lines from top to bottom
                                // within the tilezone of the current tile
      stroke(0);
      strokeWeight(2);
      line(ax, random(ay, by), bx, random(ay, by)); // Draws a line from left to right
      line(random(ax, bx), ay, random(ax, bx), by); // Draws a line from top to bottom
    }
  } 
}


for(int i = 0; i < 80; i++){ // This iteration draws eighty black squares with opacity 50% to cover a random tile
  noStroke();
  fill(0, 50);
  rectMode(CORNER);
  rect(round(random(0, n)) * 100, round(random(0, m)) * 100, 100, 100);
}

save("CP1_Taak_1_E1.png");