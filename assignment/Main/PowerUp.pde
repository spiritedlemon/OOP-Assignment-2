class PowerUp extends GameObject
{
  
  
  
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
          
          println("done");
          
          powerUp = 1;      //This will activate the power up
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