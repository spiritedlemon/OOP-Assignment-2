//C15413218 - Simon O'Leary - DT228/2 OOP Assignment 2

//Game is called Asteroids: The player shoots asteroids which explode and give score
//Score or Round??

void setup()
{
  
  size(720, 640);  //Recommended ~720,640 -- smaller screen makes it harder to dodge asteroids
  
  //Pass the info into the userShip class to create their ship controls - This allows the creation of multiple players easily which makes a multiplayer mode easier
  UserShip player1 = new UserShip(width / 2, height / 2, 0, 30, 'w', 's', 'a', 'd', ' '); 
  UserShip player2 = new UserShip(width / 2, height / 2, 0, 30, 'o', 'l', 'k', ';', 'p'); 
  
  
  if(screen == 1)
  {
    println("One Player Mode");
    gameObjects.add(player1);
  }
  else if(screen == 2)
  {
    println("Two Player Mode");
    gameObjects.add(player1);
    gameObjects.add(player2);
  }
  
}


//Variables
float timeDelta = 1.0f / 60.0f;  //This variable tracks time passing - Used to kill bullets that have been alive too long
int initialRadius = 50;          //This is used for the asteroids size  -  This is actually their diameter but w/e
int Tcounter = 4;                //This will increment ~ every time an asteroid is destroyed (TotalCounter)
int Ccounter = 0;                //This will keep track of the number of asteroids currently spawned (CurrentCounter)

int screen = 0;                    //Used to navigate screens 

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];  //Used to discern if a key is being held down



void menu()  //Called from setup to display a menu on start-up
{
  background(0);
  stroke(0, 255, 255);
  fill(0);
  
  //Rectangles created to be used to navigate to one player, two player and either settings or high-score
  rect(width/6, height/10, 4*width/6, 2*height/10);  //First rectangle on the screen 
  
  rect(width/6, 4*height/10, 4*width/6, 2*height/10);
  
  rect(width/6, 7*height/10, 4*width/6, 2*height/10);
  
}


//Used to navigate the menu with the mouse
void mousePressed()
{
  if(screen == 0)
  {
    if( (mouseX > width/6) && (mouseX < 5*width/6) && (mouseY > height/10) && (mouseY < 3*height/10) )    //Refers to the first button of the menu
    {
      screen = 1;    //The value of screen is used in both setup() and draw() to find which game mode is being used
      setup();      //Call setup to create the necessary player ships 
    }
    else if((mouseX > width/6) && (mouseX < 5*width/6) && (mouseY > 4*height/10) && (mouseY < 6*height/10) )
    {
      screen = 2;
      setup();
    }
    else if((mouseX > width/6) && (mouseX < 5*width/6) && (mouseY > 7*height/10) && (mouseY < 9*height/10))
    {
      screen = 3;
      println("Coming Soon");
    }
    
  }
  
}


void draw()
{
  if(screen == 0)
  {
    
    menu();    //call the menu function
    
  }
  else if(screen == 1)
  {
      background(0);
      stroke(255);  //Assigns color to objects being created in game
      
      
      for (int i = gameObjects.size() -1 ; i >= 0  ; i --)
      {
        GameObject go = gameObjects.get(i); 
        go.update();
        go.render();    
      }
      
      if(Ccounter<Tcounter)    //If current number < Total number - Spawn asteroids until there is enough
      {
        spawn();  //call function to spawn asteroids
      }
  }
  else if(screen == 2)
  {
      background(0);
      stroke(255);  //Assigns color to objects being created in game
      
      
      for (int i = gameObjects.size() -1 ; i >= 0  ; i --)
      {
        GameObject go = gameObjects.get(i); 
        go.update();
        go.render();    
      }
      
      if(Ccounter<Tcounter)    //If current number < Total number - Spawn asteroids until there is enough
      {
        spawn();  //call function to spawn asteroids
      }
  }
  else
  {
     screen = 0; 
  }
}


void spawn()
{
  float temp = 0; //Used to save random variable below
  
  //Variable ==> AsteroidPositionX / AsteroidPositionY
  float aposx;    
  float aposy = random(50, (height-50) );  //randomly assign a height to spawn at  [ between 50 <--> (height-50) ]
  
  temp = random(1,6);    //Randomly spawn on either side of screen
  if(temp < 3.5)         //Less than 3.5 == left side , else == right side
  {
    aposx = 50;
  }
  else
  {
    aposx = (width - 50);
  }
  
  
  
  gameObjects.add(new Asteroid(aposx, aposy, initialRadius));
   
  Ccounter++;
  
}



//Two functions used to discern if a key is being held down or not
void keyPressed()
{ 
  keys[keyCode] = true;
}
 
void keyReleased()
{
  keys[keyCode] = false; 
}



//This function is used in the UserShip class to assign momentum to the ship
boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];  
  }
  return false;
}