class UserShip extends GameObject
{
  
  //Variables 
  PVector vel;
  PVector accel;
  float theta;
  
  float radius;
  float mass = 1;
  PShape shape;
  char up, down, left, right, shoot;
  int lives;
  
  PVector force;
  
  
  
  //Values passed into this fnc from main, allocating player controls and size
  UserShip(float x, float y, float theta, float size, char up, char down, char left, char right, char shoot)
  {
    pos = new PVector(x, y);
    forward = new PVector(0, -1);
    accel = new PVector(0,0);
    vel = new PVector(0,0);
    force = new PVector(0, 0);
    this.theta = theta;
    this.size = size;
    radius = size / 2;
    
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    this.shoot = shoot;
    this.lives = 3;
    create();
    
  }
  
  //Creates the ship shape - Currently same shape as from class(Will likely change)
  void create()
  {
    
    shape = createShape();
    shape.beginShape();
    shape.stroke(255);
    shape.noFill();
    shape.strokeWeight(2);
    shape.vertex(-radius, radius);
    shape.vertex(0, - radius);
    shape.vertex(radius, radius);
    shape.vertex(0, 0);
    shape.endShape(CLOSE);
    
  }
  
  void render() // Takes priority over the 'render()' method in the 'GameObject' class
  {
    
    pushMatrix(); // Stores current transform
    translate(pos.x, pos.y);
    //text("Health: " + health, -20, -50);
    
    rotate(theta);    

    // Use a PShape
    shape(shape, 0, 0);
    popMatrix(); // Restore the transform
    
  }
  
  
}