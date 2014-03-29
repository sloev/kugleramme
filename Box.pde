// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A rectangular box
class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  float w=20;
  float density=0.3;
  int col=255;

  // Constructor
  Box(float x, float y,boolean black) {
    if (black){
      col=0;
     // density=0.03;
    }

    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w,density);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*w) {
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(col);
    stroke(0);
    ellipse(0, 0, w, w);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float density_) {

    // Define a polygon (this is what we use for a rectangle)
          // The body is a circle
      CircleShape sd = new CircleShape();
      sd.m_radius = box2d.scalarPixelsToWorld(w_/2);

//    PolygonShape sd = new PolygonShape();
//    float box2dW = box2d.scalarPixelsToWorld(w_/2);
//    float box2dH = box2d.scalarPixelsToWorld(h_/2);
//    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 10.0;
    fd.friction = 0.0;
    fd.restitution = 0.0;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 5), 2));
    body.setAngularVelocity(random(-5, 5));
  }
}


