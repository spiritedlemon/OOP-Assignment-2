//This class determines the look, starting point, velocity and fire rate of the player's ship

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
  float power = 100;
  
  float fireRate = 2;
  float toPass = 1.0 / fireRate;    //These variables are for shooting
  float elapsed = toPass;
  
  
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
    //text("Lives: " + health, -20, -50);
    
    rotate(theta);    

    shape(shape, 0, 0);
    popMatrix(); // Restore the transform
    
  }
  
  
  //This will be used to move the ship and shoot 
  void update()
  {
    forward.x = sin(theta);    //Forward is a PVector created in the above UserShip function
    forward.y  = -cos(theta);
    
    if (checkKey(up))
    {
      force.add(PVector.mult(forward, power));  
    }
    if (checkKey(down))
    {
      force.add(PVector.mult(forward, -power));      
    }
    if (checkKey(left))  
    {
      theta -= 0.1f;
    }
    if (checkKey(right))
    {
      theta += 0.1f;
    }
    
    
    //If the shoot button is pressed, create the bullet object
     if (checkKey(shoot) && elapsed > toPass)
    {
      PVector bp = PVector.add(pos, PVector.mult(forward, 40));
      Bullet b = new Bullet(bp.x, bp.y, theta, 20, 5);      //Passes this info to the 'bullet' class
      gameObjects.add(b);
      elapsed = 0;          //Starts timer
    }
    
    
    
    accel = PVector.div(force, mass);         //f = ma so a = f/m
    vel.add(PVector.mult(accel, timeDelta));  //vel = acc*time
    pos.add(PVector.mult(vel, timeDelta));    //pos = vel*time
    force.x = force.y = 0;                    //pos/vel/accel/force are PVectors created above
    vel.mult(0.99f);
    elapsed += timeDelta;                    //Elapsed increases with time
    
  }
  
}