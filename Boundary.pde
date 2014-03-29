// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A fixed boundary class

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  Vec2 a;
  Vec2 b;
  Vec2 c;
  Vec2 d;

  // But we also have to make a body for box2d to know about it
  Body body;

  Boundary(Vec2 a_, Vec2 b_, Vec2 c_, Vec2 d_) {
    a = a_;
    b = b_;
    c = c_;
    d = d_;


    // Define the polygon
    Vec2[] vertices = new Vec2[4];  // An array of 4 vectors


    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0, 0));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(b.x-a.x, b.y-a.y));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(c.x-a.x, c.y-a.y));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(d.x-a.x, d.y-a.y));




    PolygonShape sd = new PolygonShape();
    sd.set(vertices, vertices.length);




    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(a.x, a.y));
    body = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    body.createFixture(sd, 1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(255);
    stroke(0);
    noStroke();
    beginShape();

    vertex(a.x, a.y);
    vertex(b.x, b.y);
    vertex(c.x, c.y);
    vertex(d.x, d.y);


    endShape(CLOSE);
  }
}

