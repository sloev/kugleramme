// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A fixed boundary class

class ElevatorSteps {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  int topleft=0;
  int topright=5;

  // But we also have to make a body for box2d to know about it
  Body b;

  ElevatorSteps(float x_, float y_) {
    x = x_;
    y = y_;
    //    if(!left){
    //      topright=topleft;
    //      topleft=0;
    //    }


    // Define the polygon
    Vec2[] vertices = new Vec2[4];  // An array of 4 vectors
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0, topleft));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(50, topright));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(50, 15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(0, 15));



    PolygonShape sd = new PolygonShape();
    sd.set(vertices, vertices.length);



    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(sd, 1);
  }

  void move() {
    y--;
    b.setTransform(box2d.coordPixelsToWorld(x, y), 0.0);
    if (y<0) {
      y=height;
    }
  }


  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(255);
    stroke(0);
    noStroke();
    beginShape();

    vertex(x, y+topleft);
    vertex(x+50, y+topright);
    vertex(x+50, y+2*(topleft+topright));
    vertex(x, y+2*(topleft+topright));

    endShape(CLOSE);
  }
}

