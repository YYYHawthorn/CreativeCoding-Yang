// Particles, by Daniel Shiffman.
// Particles system is adapeted from processing Examples
import java.util.*;
ParticleSystem ps;
PImage sprite;  
LinkedList<int[]> myList;



void setup() {
  myList = new LinkedList();
  size(1024, 768, P2D);
  orientation(LANDSCAPE);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(200); 

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

void draw () {
  background(0); //refresh the background every frame
  ps.update(); //update the location of particles
  ps.display(); 

  ps.setEmitter(mouseX, mouseY); //set mouse as the point to emit particles

  //myList stores most recent 20 points locations of the mouse
  if ( myList.size() >20 ) {
    myList.removeFirst();
  }

  //exclude (0,0) to be the start point of lines
  if (mouseX!=0 && mouseY!=0) {
    myList.addLast(new int[] {mouseX, mouseY});
  }

  //lineList is used store current point and the point before  
  LinkedList<int[]> lineList = new LinkedList();

  //when lineList has at least two points, start to draw the line  
  for (int[] p : myList) {    
    if ( lineList.size() >=2 ) {
      int[] q1 = lineList.get(0);
      int[] q2 = lineList.get(1);

      //draw the lines
      stroke(250, 250, 177);
      strokeWeight(8);
      strokeJoin(ROUND);
      strokeCap(ROUND);
      line(q1[0], q1[1], q2[0], q2[1]);   

      //remove the first point in lineList
      lineList.removeFirst();
    }
    //store the new point into lineList that make the new line
    lineList.addLast(p);
  }
}

