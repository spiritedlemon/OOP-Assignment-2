class PowerUp extends GameObject
{
  
  float rand = 0;      //used to choose one or two randomly
  int randi = 0;       //Converts the random float value to an int
  int temptimer = 0;   //Used to track the life of the powerUp
  int T2timer;
  //float thetaP = 0;     //Used to rotate the power-ups
  
   PowerUp(float x, float y)
   {
     
     pos = new PVector(x,y);
     
   }
   
   void action()
   {
     rand = random(1,2);  
     randi = round(rand);
         
          
     powerUp = randi;            //This will activate the power up
     println("powerup activated");
          
   }
   
   void update()
   {
     
    for(int i = 0; i < gameObjects.size(); i ++)
    {
      GameObject gs = gameObjects.get(i);
      if (gs instanceof UserShip)
      {
        UserShip t = (UserShip) gs;            //ship temp variable(t)
        if (dist(gs.pos.x, gs.pos.y, this.pos.x, this.pos.y) < t.radius)
        {
          gameObjects.remove(this);
          action();  //fnc to randomly choose 1 or 2
          
        }
      }
    }
    
     
   }
    
   void render()
   {
      
     pushMatrix();
      
     noStroke();
     fill(255, 255, 0);
     rect(pos.x, pos.y, 30, 30);
      
     popMatrix();
      
  }
  
}//end of power up class