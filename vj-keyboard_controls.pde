//SPIRALS

// By Mira Keersmaekers, mira.keersmaekers@student.ehb.be, Erasmushogeschool Brussel - MulTec, 2015-2016



//In this VJ-program, one main spiral is drawn, but there are different features you can activate:

//Switching "0" on: add some distortion on the spiral
//Pressing on "1" :  the radius of the spiral will be multiplied by 1.5 ('pulse')
//Switching "2" on : add lines at the sides of the screen
//Switching "3" on : add two more spirals turning around the main spiral
//Switching "4" on : add flickering stars on the background
//Switching "SPACEBAR" on: generate a stroboscope effect
//Presing UP or DOWN  arrows: speed up or slow down the stroboscope effect

//Switching "R" on : record your events. 

//Press on the key again to switch it back off.





float mx;                  //The xpos of the midpoint of the screen
float my;                  //The ypos of the midpoint of the screen
float lowest;

float r;
float n;
int l;

boolean lines;
boolean twoSpirals;
boolean stars;
boolean distortion;
boolean beat;
boolean pressed;
boolean record;


void setup() {
  size(1600, 900);
  mx = width / 2; 
  my = height / 2;
  lowest = min(width, height);             //Defines the max-radius later on, so it's compatible on as well landscape as portrait screens.

  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  frameRate(30);
  l = 30;
}


void draw() {

  float hue = frameCount % 360;           //Hue changes every frame one degree on the color wheel

  fill(0, 20);
  stroke(hue, 50, 100, 50);

  if (beat) {
    inverseColor();
  }

  strokeWeight(lowest/25);
  rect(0, 0, width, height);

  r = (lowest/4.5) + (lowest/45) * randomGaussian();      //The radius of the spiral
  n = 5 + randomGaussian();                               //The length of the spiral line
  strokeWeight(lowest/250);

  controls();

  spiral(mx, my, n, r);

  if (lines) {
    lines("bottom", 0, width, 0, (lowest/15), 20);       //Draws lines on the top side of the screen (orientated to the bottom)
    lines("top", 0, width, height, (lowest/15), 20);     //Draws lines on the bottom side of the screen (orientated to the top)
    lines("right", 0, height, 0, (lowest/15), 20);       //Draws lines on the left side of the screen (orientated to the right)
    lines("left", 0, height, width, (lowest/15), 20);    //Draws lines on the right side of the screen (orientated to the left)
  }

  if (twoSpirals) {
    twoSpirals(20);

  }

  if (stars) {
    stars(100);
  }

  if (record) {                            //Saves the frame when record = true
    saveFrame("frame-#####.jpeg");
  }
}





void spiral(float ax, float ay, float m, float r) {      
  //Draws a spiral with:
  //ax = xpos midpoint, ay = ypos midpoint, 
  //m = The length of the spiral line (the amount of times it's wrapped),
  //r = radius of the spiral.

  float n =  100 * m;                    //The accuracy of the spiral
  int i0 = round(random(0, m/2));        //The start of the spiral
  float r0 = r / m * i0;                 //The start radius 

  float alpha0 = m * TWO_PI * i0 / n;    //The start angle (depending on i0 so it's not always 0)
  float x0 = ax + cos(alpha0) * r0;      //The start xpos depending on alpha
  float y0 = ay + sin(alpha0) * r0;      //The start ypos depending on alpha



  for (int i = i0; i < n; i++) {         //Draws a line between the next and the previous point


    float R = r0 + (r/n) * i;            //The actual radius of the point (x, y) depending on the i-value and the greatest radius r


    float alpha = m * TWO_PI * i / n;          //The actual angle of the point (x, y)

    if (distortion) {                    //Sets distortion to this angle
      alpha += randomGaussian()/2;
    }

    float x = ax + cos(alpha) * R;       //x-pos of the point
    float y = ay + sin(alpha) * R;       //y-pos of the point
    line(x, y, x0, y0);                  //Draws a line from the current point to the previous point

    x0 = x;
    y0 = y;
  }
}



void twoSpirals(float v) {
    //Draws two spirals turning around the main spiral,
    //with v = velocity of the rotation in orbits per minute

    pushMatrix();
    translate(width/2, height/2);                            //Translates the coordinate system to the midpoint
    rotate(TWO_PI * v * millis()/60000.0);                   //Rotates the coordinate system
    spiral(-width/4, 0, 2.5 + randomGaussian()/2, r/3);      //Draws a spiral left from the main spiral
    spiral(width/4, 0, 2.5 + randomGaussian()/2, r/3);       //Draws a spiral right from the main spiral
    popMatrix();
  
}







void lines(String orientation, float start, float end, float placement, float l, float n) {
  //Draws lines perpendicular to a (invisible) horizontal or vertical line, with:

  //orientation = the direction of the lines (top-bottom-left-right),
  //start = the begin point (x if hor, y if vert),
  //end = the end point (x if hor, y if vert),
  //placement = the placement of the lines (y if hor, x if vert),
  //l = the average length of a line,
  //n = the amount of lines.


  if (orientation == "bottom") {
    for (int i = 0; i < n; i++) {
      float x = random(start, end);
      line(x, placement, x, placement + l + l/6 * randomGaussian());
    }
  } else if (orientation == "top") {

    for (int i = 0; i < n; i++) {
      float x = random(start, end);
      line(x, placement, x, placement - l + l/6 * randomGaussian());
    }
  } else if (orientation == "right") {
    for (int i = 0; i < n; i++) {
      float y = random(start, end);
      line(placement, y, placement + l + l/6 * randomGaussian(), y);
    }
  } else if (orientation == "left") {
    for (int i = 0; i < n; i++) {
      float y = random(start, end);
      line(placement, y, placement - l + l/6 * randomGaussian(), y);
    }
  }
}





void stars(int n) {
  //Draws an amount n of random points ('stars') on your screen

    for (int i = 0; i < n; i++) {
    float x = random(width);
    float y = random(height);

    if (dist(x, y, mx, my) > r) {       //Draws a random point only if its distance to the midpoint is greater than the main spiral's radius
      point(x, y);
    }
  }
}





void inverseColor() {

  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP && l > 5) {
        l -= 1;
      }
      if (keyCode == DOWN && l < 100) {
        l += 1;
      }
    }
  }  
  if (frameCount % l > 0 && frameCount % l < 3) {
    fill(360);
    stroke(0);
  } else if (frameCount % l == 3) {
    fill(0);
  }
}





void controls() {

  if (keyPressed) {
    if (key == '1') {
      r *= 1.5; 
      n = 1.5 * n;
    }
  }


  if (keyPressed && pressed == false) {

    if (key == '2') {
      lines = !lines;
    } 
    else if (key == '3') {
      twoSpirals = !twoSpirals;
    } 
    else if (key == '4') {
      stars = !stars;
    } 
    else if (key == '0') {
      distortion = !distortion;
    } 
    else if (key == ' ') {
      beat = !beat;
    } 
    else if (key == 'r' || key == 'R') {
      record = !record;
    }

    pressed = true;
  }
}

void keyReleased() {
  pressed = false;
}