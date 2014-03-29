// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of falling rectangles

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

ArrayList<ElevatorSteps> steps;

float timer=0;
void setup() {
  size(640, 500);
  smooth();
  frameRate(240);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  steps=new ArrayList<ElevatorSteps>();




  boundaries.add(new Boundary(new Vec2(0, 0), new Vec2(10, 0), new Vec2(10, height), new Vec2(0, height)));
  boundaries.add(new Boundary(new Vec2(70, 30), new Vec2(79, 30), new Vec2(79, height-40), new Vec2(70, height-40)));
  boundaries.add(new Boundary(new Vec2(100, height-80), new Vec2(110, height-80), new Vec2(110, height), new Vec2(100, height)));

  boundaries.add(new Boundary(new Vec2(70, height-15), new Vec2(110, height-20), new Vec2(110, height), new Vec2(70, height)));
  boundaries.add(new Boundary(new Vec2(0, height-15), new Vec2(width, height-15), new Vec2(width, height), new Vec2(0, height)));

  boundaries.add(new Boundary(new Vec2(width-8, 0), new Vec2(width, 0), new Vec2(width, height), new Vec2(width-8, height)));
  int i=-1;
  boundaries.add(new Boundary(new Vec2(70+30, 40+i*40+10), new Vec2(width, 40+i*40), new Vec2(width, 40+i*40+10+10+10), new Vec2(70+30, 40+i*40+10+10)));

  for ( i=1;i<10;i+=2) {
    boundaries.add(new Boundary(new Vec2(70, i*40), new Vec2(width-30, i*40+10), new Vec2(width-30, i*40+10+10), new Vec2(70, i*40+10+10+10)));
    boundaries.add(new Boundary(new Vec2(70+30, 40+i*40+10), new Vec2(width, 40+i*40), new Vec2(width, 40+i*40+10+10+10), new Vec2(70+30, 40+i*40+10+10)));

    // boundaries.add(new Boundary(new Vec2(70, i*50+50+10), new Vec2(width-50, i*50+50), new Vec2(width-50, i*50+10+10+50), new Vec2(70, i*50+50)));


    //  boundaries.add(new Boundary(new Vec2(75+u*50, i*50+((2-u)*10)), new Vec2(width-u*50, i*50+(u*10)), new Vec2(width-u*50, i*50+((2-u)*10)), new Vec2(75+u*50, i*50+(u*10))));
  }

  for ( i=0;i<10;i++) {
    steps.add(new ElevatorSteps(10, height+i*50));
  }
}

void draw() {
  while (boxes.size ()<250 && timer < millis()) {
    timer=millis()+50;
    Box p = new Box(80, 30, int(random(2))==0);
    boxes.add(p);
  }
  if (boxes.size()<250) {
    for (int i=0;i<50;i++) {

      box2d.step();
    }
  }
  background(255);

  // We must always step through time!


  box2d.step();
  box2d.step();
  box2d.step();
  box2d.step();



  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
  for (ElevatorSteps step: steps) {
    step.move();
    step.display();
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}

void mousePressed() {
  Box p = new Box(80, 30, int(random(2))==0);
  boxes.add(p);
}

