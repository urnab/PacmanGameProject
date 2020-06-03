int radius = 15; // pacman radius
int direction = 1; // it used for changing pacman way
int direction2 = 0; // it used for changing pacman way
int score = -2; // It starts from -2 because if it start 0 when the screen open the upper-left has dots and score start 2, thsnks tu -2 it start from 0 and the upper-left point has no dot at all
int winScore = 0;  // The Pacman will eat all the dots and score will be (width * height * 2)
int stage; // for start menu screen

float x = width/2 -30;   // x coordinate of pacman
float y = height/2 -30;  // y coordinate of pacman

int baitCoordinate = (int) random (10);  // for random bait coordinates

PImage pacmanWin;  // Image width star eyes on Pacman for winning
PImage pacmanLost; // Image with X eyes on Pacman for Lost
PImage pacmanStartScreen;

ArrayList<Dots> dot = new ArrayList();
ArrayList<Baits> bait = new ArrayList();

Lines l = new Lines();

void setup() {
  pacmanWin = loadImage("pacmanWinPng.png"); // loadImage of for pacmanWin
  pacmanLost = loadImage("pacmanLostPng.png"); // loadImage of for pacmanLost
  pacmanStartScreen = loadImage("pacmanStartScreen.jpg"); // start screen for pacman
  image(pacmanStartScreen, 0, 0, width, height);


  fullScreen();
  ellipseMode(RADIUS);
  textSize(50);

  for (int i = 20; i < width; i += 40) {   // add dots to arraylist
    for (int j = 20; j < height; j += 40) {
      Dots D = new Dots(i, j);
      dot.add(D);
    }
  }

  for (int z = 0; z < width; z += 40) {    // add baits to array list
    for (int t = 0; t < height; t += 40) {
      Baits B = new Baits(z, t);
      bait.add(B);
    }
  }

  stage=1;
}

void draw() {
  if (stage==1) {
    if (key == ' ') {   // start menu
      stage = 2;
    }
  }
  if (stage ==2) {
    background(0);
    l.drawLines();
    fill (0, 175, 255);
    smooth ();
    noStroke();
    render(); // pacman
    if (winScore == (((width/40)*2*(height/40)) - 22)) {
      background(0);
      bait.remove(bait.size());
      image(pacmanWin, 20, 140);
    }

    for (int t=0; t < dot.size(); t++) {
      Dots Dt = (Dots) dot.get(t);
      Dt.display();
      if (dist(x, y, Dt.x, Dt.y)<radius) {   // dist for calculating distance between two object
        dot.remove(t);   // removing objects from Arraylist
        score += 2;
        winScore = score;
      }
    }

    for (int t=40; t < bait.size(); t += 130 + baitCoordinate ) { // take random 10 bait from ArrayList
      Baits Bt = (Baits) bait.get(t);
      Bt.showBait();
      if (dist(x, y, Bt.baitZ+20, Bt.baitT +20)<radius) {   // dist for calculating distance between two object
        image(pacmanLost, 20, 140);
        noLoop();
      }
    }

    scoreText();
    score();
  }
}

void scoreText() {
  fill(12, 247, 19);
  text("Score: ", width-300, 50);
}

void score() {
  fill(12, 247, 19);
  text(score, width-150, 50);
}

class Dots {  // draw dots
  int x, y;
  Dots(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    noStroke();
    fill(255);
    ellipse(x, y, 5, 5);
  }
}

class Baits {  // draw baits
  int baitZ, baitT;
  Baits(int baitZ, int baitT ) {
    this.baitZ = baitZ;
    this.baitT = baitT;
  }
  void showBait() {
    noStroke();
    fill(255, 0, 0);
    ellipse(baitZ+20, baitT+20, 15, 15);
  }
}


void mousePressed() {   // Move the object where the mouse click
  x = mouseX;
  y = mouseY;
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      x = x - 40;
      direction = -1;   // change pacman directions
      direction2 = 0;
      if (x < 0) {
        x = x + 40;
        direction = 1;
        direction2 = 0;
      }
    } else if (keyCode == RIGHT) {  
      x = x + 40;
      direction = 1;
      direction2 = 0;
      if (x > width) {
        x = x - 40;
        direction = -1;   // change pacman directions
        direction2 = 0;
      }
    } else if (keyCode == UP) {
      y = y - 40;
      direction = 0;
      direction2 = -1;
      if (y < 0) {
        y = y + 40;
        direction = 0;
        direction2 = 1;
      }
    } else if (keyCode == DOWN) { 
      y = y + 40;
      direction = 0;
      direction2 = 1;
      if (y > height) {
        y = y - 40;
        direction = 0;
        direction2 = -1;
      }
    }
  }
}


void render() {
  for ( int i=-1; i < 2; i++) {
    for ( int j=-1; j < 2; j++) {
      pushMatrix();
      translate(x + (i * width), y + (j*height));
      if ( direction == -1) { 
        rotate(PI);
      }
      if ( direction2 == 1) { 
        rotate(HALF_PI);
      }
      if ( direction2 == -1) { 
        rotate( PI + HALF_PI );
      }
      arc(0, 0, radius, radius, map((millis() % 500), 0, 500, 0, 0.52), map((millis() % 500), 0, 500, TWO_PI, 5.76) );
      popMatrix();
      // mouth movement //
    }
  }
}



// ------ REFERENCES ------
// https://www.youtube.com/watch?v=NLzne4XaR3M - 13.1 Strings and Drawing Text - Processing Tutorial by The Coding Train (2015)
// https://forum.processing.org/two/discussion/1573/spoof-of-pacman-game-for-project - Spoof of Pacman Game for Project by logcabin664 (2013)
// https://www.youtube.com/watch?v=Xdeih9syh4I - Processing Pong Game: Game over method (Part 4/4) by Tanay Singhal (2015)
// https://processing.org/reference/dist_.html - dist() by Processing References (2020)
// https://forum.processing.org/two/discussion/18164/display-mousex-and-mousey-on-click-solved - Display mouseX and mouseY on click [SOLVED] by Alex_Pr (2016)
// https://imagecolorpicker.com/tr/ - Picker Color by ImageColorPicker.com (2020)
// https://www.youtube.com/watch?v=-CgPqs9THoM - Learn programming 65: Are we getting close? Use dist() to find out the distance by Abe Pazos (unknown)
// https://www.youtube.com/watch?v=TjcXcGJihyQ - Game Design in Processing Part. 6 The Transfer from Main Menu to Game by HowComputersTalk (2012)
// https://discourse.processing.org/t/problem-with-keypressed-and-space/7468/2 - Problem with keyPressed() and SPACE BY JoLi (2019)
