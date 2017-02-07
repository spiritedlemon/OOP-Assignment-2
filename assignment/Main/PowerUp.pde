class PowerUp extends GameObject
{
  
  float temp = 0;  //used to choose one or two randomly
  int tempi = 0;    //Converts the random float value to an int
  int temptimer = 0;   //Used to track the life of the powerUp
  
   PowerUp(float x, float y)
   {
     
     pos = new PVector(x,y);
     
   }
   
   void update()
   {
     
    for(int i = 0; i < gameObjects.size(); i ++)
    {
      GameObject go = gameObjects.get(i);
      if (go instanceof UserShip)
      {
        UserShip t = (UserShip) go;  //ship temp variable(t)
        if (dist(go.pos.x, go.pos.y, this.pos.x, this.pos.y) < t.radius)
        {
          gameObjects.remove(this);
          
          
          temp = random(1,2);
          tempi = int(temp);
          
          
            powerUp = tempi;      //This will activate the power up
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