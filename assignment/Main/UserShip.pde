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
  int hit; //Used to track who was hit in multiplayer
  
  PVector force;
  float power = 100;
  
  float fireRate;                    //Set to 2.5 in update()
  float toPass = 1.0 / fireRate;    //These variables are for shooting
  float elapsed = toPass;
  
  
  //Values passed into this fnc from main, allocating player controls and size
  UserShip(float x, float y, float theta, float size, char up, char down, char left, char right, char shoot, int hit)
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
    this.hit = hit;
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
    
    rotate(theta);    

    shape(shape, 0, 0);
    popMatrix(); // Restore the transform
    
  }
  
  
  //This will be used to move the ship and shoot 
  void update()
  {
    
    if(powerUp == 1)  //When power up is active
    {
      fireRate = 7;
      toPass = 1.0 / fireRate;    
    }
    else if(powerUp != 1)  //Revert back to normal
    {
      fireRate = 2.5;
      toPass = 1.0 / fireRate;    
    }
    
    
    forward.x = sin(theta);    //Forward is a PVector created in the above UserShip function
    forward.y  = -cos(theta);
    
    
    Ttimer = int(millis()/1000);  //creates a timer which tracks seconds passing
    timer = Ttimer - (timer1+timer2);
    
    
    //Controls to move the ship
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
    
    //Causes the ship to re-enter another part of the screen
    if (pos.x > width)                        
    {
      pos.x = 0;
    }
    if (pos.x < 0)
    {
      pos.x = width;
    }
    if (pos.y > height)
    {
      pos.y = 0;
    }
    if (pos.y < 0)
    {
      pos.y = height;
    }
    
    
    //If the shoot button is pressed, create the bullet object
    if (checkKey(shoot) && elapsed > toPass)
    {
      PVector bp = PVector.add(pos, PVector.mult(forward, 40));
      Bullet b = new Bullet(bp.x, bp.y, theta, 20, 5);      //Passes this info to the 'bullet' class
      gameObjects.add(b);
      elapsed = 0;          //Starts timer
    }
    
    
    //Check for collision with the user - Same as the for loop used in Bullet
     
     for(int i = 0; i < gameObjects.size(); i ++)
      {
        GameObject go = gameObjects.get(i);
        if (go instanceof Asteroid)
        {
          Asteroid t = (Asteroid) go;  //asteroid temp(t)
          if (dist(go.pos.x, go.pos.y, this.pos.x, this.pos.y) < t.radius)
          {
            if(timer >= 3)
            {
              gameObjects.remove(this);
              reset = 0;              //sets this to 0, destroying the player's ship and calling the setup() fnc in main
              powerUp = 0;
              lives--;
              this.hit = 0;
              
              
              //reset the timer to protect the player for 3 seconds
              if(lives == 2)
              {
                timer1 = Ttimer;
              }
              else if(lives == 1)
              {
                timer2 = Ttimer - timer1;
              }
              
             }//end of if loop to check timer
          }
        }
      }//End of for loop
    
    
    accel = PVector.div(force, mass);
    vel.add(PVector.mult(accel, timeS));
    pos.add(PVector.mult(vel, timeS));
    force.x = force.y = 0;
    vel.mult(0.99f);
    elapsed += timeS;
    
  }
  
}