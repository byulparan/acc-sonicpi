import java.util.ArrayList;
import java.util.Iterator;
import oscP5.*;
import netP5.*;

class Point {
  float mX;
  float mY;
  float mAlpha;
  color mColor;
  Point(float x, float y) {
    mX = x;
    mY = y;
    mAlpha = 255;
    mColor = color(random(255), random(255), random(255));
  }
  void display() {
    fill(mColor, mAlpha);
    ellipse(mX, mY, 30, 30);
    mY += 2;
    mX += random(-2, 2);
    mAlpha -= 4;
  }
  boolean isDead() {
    return mY > height || mAlpha < 0;
  }
}

ArrayList<Point> points;
OscP5 oscP5;
NetAddress sonicpi;

void setup() {
  size(800, 600);
  oscP5 = new OscP5(this, 12000);
  sonicpi = new NetAddress("127.0.0.1", 4560);
  points = new ArrayList<Point>();
}

void draw() {
  background(0);
  Iterator<Point> iter = points.iterator();
  synchronized(points) {
    while (iter.hasNext()) {
      Point p = iter.next();
      p.display();
      if (p.isDead()) {
        iter.remove();
      }
    }
  }
}

void oscEvent(OscMessage theOscMessage) {
  synchronized(points) {
    points.add(new Point(random(width), random(height*0.5)));
  }
}


void mousePressed() {
  synchronized(points) {
    points.add(new Point(mouseX, mouseY));
  }
  OscMessage myMessage = new OscMessage("/trigger");
  myMessage.add(int(random(55,84)));
  oscP5.send(myMessage, sonicpi);
}

void mouseDragged() {
  synchronized(points) {
    points.add(new Point(mouseX, mouseY));
  }
  OscMessage myMessage = new OscMessage("/trigger");
  myMessage.add(int(random(55,84)));
  oscP5.send(myMessage, sonicpi);
}
