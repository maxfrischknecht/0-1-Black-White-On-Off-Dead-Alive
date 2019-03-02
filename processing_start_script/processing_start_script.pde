// define some variables
int x = 200;
int y = 200;

void setup() {
  // set the size
  size(800, 800);
}

void draw() {
  // add a background color
  background(0, 0, 255);

  // define colors and draw a rectangle
  stroke(255, 255, 0);
  strokeWeight(20);
  fill(255, 0, 0);
  rect(x, y, 400, 400);
  
  // play around!
  // try to replace the x, y, in rect() by mouseX, and mouseY
  // try to uncomment (=deactivate) the background
}
