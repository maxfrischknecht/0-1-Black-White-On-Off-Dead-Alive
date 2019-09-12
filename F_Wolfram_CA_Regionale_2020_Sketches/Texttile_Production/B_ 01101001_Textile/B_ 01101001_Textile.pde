// 0/1 – Black/White – On/Off – Dead/Alive
// Scripting Workshop, Seminar Week, 17–22 March 2019.
// by Max Frischknecht, based on Daniel Shiffmans http://natureofcode.com

// Simple demonstration of a Wolfram 1-dimensional cellular automata
// When the system reaches bottom of the window it stops
// Mouse click produces a random new rule & drawing
// CMD + S = save jpg
// q = quit & save pdf

import java.util.Calendar;
import processing.pdf.*;
CA ca;   // An instance object to describe the Wolfram basic Cellular Automata


void setup() {
  size(860, 950); 
  beginRecord(PDF, "everything.pdf");

  ca = new CA(); // Initialize CA


  noStroke();
  background(0);
  frameRate(120); // how fast it draws
}

void draw() {
  if (!ca.finished()) {
    ca.display(); // Draw the CA
    ca.generate(); // generate next generation
  }
}

void mousePressed() {
  //beginRecord(PDF, "frame-####.pdf"); 
  background(0);
  //ca.randomRule();
  //ca.restartCenter(); // draws from the middle
  ca.restartRandom(); // draws randomly
}


void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("export/"+timestamp()+"_##.png");
  println("safed");

  if (key == 'q') {
    endRecord();
    exit();
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
