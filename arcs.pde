//"ARCS"
//By Mira Keersmaekers, mira.keersmaekers@student.ehb.be, Erasmushogeschool Brussel - Multec 2015-2016.

//This program creates a figure, consisting of multiple arcs with different amplitudes.
//An arc with a certain amplitude is always drawn 4 times. Every time I turned it 90 degrees around the mid point, forming a cross.

size(900, 900);
background(0); 
stroke(255);
strokeWeight(2);
colorMode(RGB, 100, 100, 100, 100);

int mx = width/2;      //The x-pos of the screen's midpoint
int my = height/2;     //The y-pos of the screen's midpoint


int m = 20;                          //The amount of arcs
for(int j = 1; j <= m; j++){         //This iteration draws 20 arcs with different amplitudes
  
  float amplitude = pow(j, 3)/20.0;  //When "j" goes from [1, 10, 20], the amplitude of the arc goes from [1/20, 50, 400].
  
  int n = 100;                       //The amount of points in one arc
  for(int i = 0; i <= n; i++){       //This iteration draws a set of 4 arcs with the same amplitude consisting of "n" points
    
    int u = 1;                       //The next pair of variables (u, v), i created to decide how many half sinus arcs I would draw in one "length".
    float v = 0.5 * u;               //I sticked with 1. Increase "u" to get an other figure.
    
    
    float alpha = v * TWO_PI/n * i;              //The angle from the midpoint to each point separately
    stroke(100, 100 * abs(sin(alpha)));          //The opacity depends on the sinus of this angle:
                                                 //alpha [0, PI/2, PI] --> sin(alpha) [0, 1, 0] --> opacity [0, 100, 0]
                                                 //abs() is to avoid negative values when "u" is increased 
    
    float margin = 20;                           //The margin of the screen
    float length = width - 2 * margin;           //The length of an arc
    
    float x0 = margin + (length * i/n);          //The x-pos of the horizontal arcs/The y-pos of the vertical arcs
    float y0 = my - (sin(alpha) * amplitude);    //The y-pos of the horizontal arc pointed towards the top/ x-pos of the vertical arc pointed towards the right
    float y1 = my + (sin(alpha) * amplitude);    //The y-pos of the horizontal arc pointed towards the bottom/ x-pos of the vertical arc pointed towards the left
    
    point(x0, y0); //draws a horizontal arc pointed towards top
    point(x0, y1); //draws a horizontal arc pointed towards bottom
    point(y0, x0); //draws a vertical arc pointed towards right
    point(y1, x0); //draws a vertical arc pointed towards left
  }
  
}

save("CP1_Taak_1_E1_extra.png");
