//C15413218 - Simon O'Leary - DT228/2 OOP Assignment 2

//Game is called Asteroids: The player shoots asteroids which explode and give score
//Score or Round??

void setup()
{
  
  size(720, 640);  //Recommended ~720,640 -- smaller screen makes it harder to dodge asteroids
  
  //Load the background images
  
  img = loadImage("space1.jpg");
  img.resize(width, height); //Resizes the image to be the size of the window
  
  img2 = loadImage("space2.jpg");
  img2.resize(width, height); //Resizes the image to be the size of the window
  
  
  //Pass the info into the userShip class to create their ship controls - This allows the creation of multiple players easily which makes a multiplayer mode easier
  UserShip player1 = new UserShip(width / 2, height / 2, 0, 30, 'w', 's', 'a', 'd', ' '); 
  UserShip player2 = new UserShip(width / 2, height / 2, 0, 30, 'o', 'l', 'k', ';', 'p'); 
  
  
  if(screen == 1)
  {
    gameObjects.add(player1);
  }
  else if(screen == 2)
  {
    gameObjects.add(player1);
    gameObjects.add(player2);
  }
  
}


//Variables
PImage img, img2;  

float timeS = 1.0f / 60.0f;  //This variable tracks time passing - Used to kill bullets that have been alive too long
float initialRadius;          //This is used for the asteroids size  -  This is actually their diameter but w/e
int Tcounter = 4;                //This will increment ~ every time a small asteroid is destroyed up until 10 (TotalCounter)
int Ccounter = 0;                //This will be used to spawn the initial asteroids (CurrentCounter)
int powerUp = 0;                 //Default = 0 -- at 1 shoot quicker -- at 2 asteroids slow down -- at 3 ???? - Random reward - Spawn at 1k, 5k, 25k...
int target = 1000;                //The target score for a power-up

int screen = 0;                  //Used to navigate screens - set to one so its easier to test new features  -  default 0
boolean clickChange = false;     //When player lives hits 0 this is set to true and onClick the player will be returned to the menu  -  default = false

int score = 0;                   //Global variable to track player's score
String[] scoreT;                 //Temp string array variable used to write score to a file
int reset = 1;                   //Used to track if the ship is hit by an Asteroid - used in draw() and the UserShip class  -  default = 1
int lives;                   //The player's life counter  -  default = 3

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];  //Used to discern if a key is being held down

int Ttimer = 0;  //Total timer (seconds)
int timer1, timer2 = 0;   //Timers to track each life's time - Only matters the first two deaths
int timer = 0; //This will be the actual timer used to protect the playeing spawn killed

//Color of menu border is random every time - (at least 20 so it wont be invisible) - Randomized when compiled to avoid 60 changes per sec
float cx = random(20,255);
float cy = random(20,255);
float cz = random(20,255);


void menu()  //Called from setup to display a menu on start-up
{
  background(0);
  image(img, 0, 0);
  fill(0);
  
  stroke(cx, cy, cz);  //Variables are global and random at time of compile
  
  //Rectangles created to be used to navigate to one player, two player and either settings or high-score
  rect(width/6, height/10, 4*width/6, 2*height/10);  //First rectangle on the screen 
  
  rect(width/6, 4*height/10, 4*width/6, 2*height/10);
  
  rect(width/6, 7*height/10, 4*width/6, 2*height/10);
  
  
  
  //Now fill in the boxes made above 
  PFont f;
  float fontSize = ( (height * width)/10000 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 18, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont' f
  fill(255);
  
  
  text("One Player", width * 0.35f, height*0.225f);
  text("Two Player ", width * 0.35f, height*0.525f);
  text("High Score", width * 0.35f, height*0.825f);
}


//Used to navigate the menu with the mouse
void mousePressed()
{
  if(screen == 0)
  {
    if( (mouseX > width/6) && (mouseX < 5*width/6) && (mouseY > height/10) && (mouseY < 3*height/10) )    //Refers to the first button of the menu
    {
      lives = 3; 
      screen = 1;    //The value of screen is used in both setup() and draw() to find which game mode is being used
      setup();      //Call setup to create the necessary player ships 
      println("One Player Mode");
    }
    else if((mouseX > width/6) && (mouseX < 5*width/6) && (mouseY > 4*height/10) && (mouseY < 6*height/10) )
    {
      lives = 6;
      screen = 2;
      setup();
      println("Two Player Mode");
    }
    else if((mouseX > width/6) && (mouseX < 5*width/6) && (mouseY > 7*height/10) && (mouseY < 9*height/10))
    {
      screen = 3;
    }
    
  }//end of screen == 0 if statement
  
  if(screen == 1)
  {
    if(clickChange == true)
    {
      screen = 0;
      clickChange = false;
    }
    
    
  }//end of screen == 1 if statement
  
}

String kk;
void draw()
{  
  
  if(screen == 0)
  {
    menu();    //call the menu function
    
  }
  else if(screen == 1)
  {
      
    
    if(lives > 0)
    {
      onePlayer();    //When life counter == 0 the screen will freeze so the user can read the message
    }
    else if(lives == 0)
    {
      //scoreT[0] = Integer.toString(score);
      //saveStrings("highscores.txt", scoreT);
      println(score);
      score = 0;
      endGame();
    }
      
  }
  else if(screen == 2)
  {
    
    if(lives > 0)
    {
      twoPlayer();
    }
    else
    {
      endGame2();
    }
  }
  else if(screen == 3)
  {
     highScores(); 
  }
}

void endGame()
{
        PFont f;
        float fontSize = ( (height * width)/15000 );   //Font size scales with chosen display dimensions
        f = createFont("Arial", 18, true); // true -> anti-aliasing on
        textFont(f, fontSize);  //sets font size of 'PFont' f
      
        fontSize = ( (height * width)/10000 );   //Font size scales with chosen display dimensions
        textFont(f, fontSize);  //sets font size of 'PFont' f
        text("GAME OVER", width *0.3f, height *0.5f);
        
        text("Click To Return To Menu", width *0.15f, height *0.6f);
        clickChange = true;  //When 'True', screen will be set to 0 on click 
}


void endGame2()
{
        PFont f;
        float fontSize = ( (height * width)/15000 );   //Font size scales with chosen display dimensions
        f = createFont("Arial", 18, true); // true -> anti-aliasing on
        textFont(f, fontSize);  //sets font size of 'PFont' f
      
        fontSize = ( (height * width)/10000 );   //Font size scales with chosen display dimensions
        textFont(f, fontSize);  //sets font size of 'PFont' f
        text("GAME OVER", width *0.3f, height *0.2f);
        
        
        text("Your Time is: ", width*0.3f, height*0.5f);
        text(Ttimer, width*0.45f, height*0.6f);
        
        
        text("Click To Return To Menu", width *0.15f, height *0.85f);
        clickChange = true;  //When 'True', screen will be set to 0 on click
        
        
}

void onePlayer()
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
      
      
      //Create power-ups as a reward for score
      float pposx, pposy;  //power up position x/y
      pposx = random((width/3),(2*width/3));  //random position in middle 3rd of the screen
      pposy = random((height/5), (4*height/5));  //random btween middle 60% of screen
      
      if(score >= target)
      {
        println("Power-Up Deployed");
        gameObjects.add(new PowerUp(pposx, pposy));
        target = target*5;  //Means power ups at 1k, 5k, 25k and 125k  -  Needs to be done on pick-up
        
      }
      
      
      //Create the font color and size
      PFont f;
      float fontSize = ( (height * width)/15000 );   //Font size scales with chosen display dimensions
      f = createFont("Arial", 18, true); // true -> anti-aliasing on
      textFont(f, fontSize);  //sets font size of 'PFont' f
      fill(255);
      
      //Print the score to the bottom corner of the screen
      text("Score: ", width *0.8f, height *0.9f);
      text(score, width *0.8f, height *0.95f);
      
      //Print the Lives counter to the bottom of the screen
      text("Lives: ", width *0.05f, height *0.9f);
      text(lives, width *0.05f, height *0.95f);
      
      
      
      
      //Value is set to 0 in the UserShip class upon collision with an asteroid
      if(reset == 0)    //I.e. if you fly into an asteroid
      {
        setup();
        reset = 1;
      }
      
      
}//End of onePlayer()

void twoPlayer()    //Team survival
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
      
      
      //Create the font color and size
      PFont f;
      float fontSize = ( (height * width)/15000 );   //Font size scales with chosen display dimensions
      f = createFont("Arial", 18, true); // true -> anti-aliasing on
      textFont(f, fontSize);  //sets font size of 'PFont' f
      fill(255);
      
      //Print the score to the bottom corner of the screen
      text("Time: ", width *0.8f, height *0.9f);
      text(Ttimer, width *0.8f, height *0.95f);
      
      //Print the Lives counter to the bottom of the screen
      text("Lives: ", width *0.05f, height *0.9f);
      text(lives, width *0.05f, height *0.95f);
      
      
      
      //Value is set to 0 in the UserShip class upon collision with an asteroid
      if(reset == 0)    //I.e. if you fly into an asteroid
      {
        setup();
        reset = 1;
      }
      
}//End of Two Player


//Variables used in the sorting of the scoreboard
String records[];
int rec1, rec2, rec3;  //Top three highest scores in file
int current;
int tempSwap;  //Used to swap the ints around

void highScores()
{
  background(0);
  image(img2, 0, 0);
  records = loadStrings("highscores.txt");
  
  //Find the three highest scores
  
  //Assume first three are largest
  rec1 = int(records[0]);
  rec2 = int(records[1]);
  rec3 = int(records[2]);
  
  //Then compare to each other and order them
  if(rec3 > rec1 && rec3 > rec2)  //If rec3 is biggest
  {
    tempSwap = rec3;
    rec3 = rec1;
    rec1 = tempSwap;
    if(rec3 > rec2)  //Sort the other parts of the array
    {
      tempSwap = rec2;
      rec2 = rec3;
      rec3 = tempSwap;
    }
  }
  
  else if(rec3 > rec1 && rec3 < rec2)  //If rec2 is biggest, rec1 smallest
  {
    tempSwap = rec1;
    rec1 = rec2;
    rec2 = rec3;
    rec3 = tempSwap;
  }
  else if(rec3 > rec1 && rec3 < rec2) //If rec2 is biggest, rec3 smallest
  {
    tempSwap = rec1;
    rec1 = rec2;
    rec2 = tempSwap;
  }
  
  else if(rec1 > rec2 && rec1 > rec2)  //If rec1 is biggest
  {
    if(rec3 > rec2)
    {
      tempSwap = rec2;
      rec2 = rec3;
      rec3 = tempSwap;
    }
  }
  
  
  //Now compare the rest of the array to the top three  --  Just gonna re-use tempSwap to save memory
  for(int i=3; i<(records.length); i++)  //Starts at 3!! cause 0, 1, 2 are already sorted 
  {
    tempSwap = int(records[i]);
    
    if(tempSwap > rec3)  //if 3rd biggest yet
    {
      
      if(tempSwap > rec2)  //If 2nd biggest 
      {
        
        if(tempSwap > rec1)  //If biggest yet
        {
          rec3 = rec2;
          rec2 = rec1;
          rec1 = tempSwap;
        }//end if3
        else
        {
          rec3 = rec2;
          rec2 = tempSwap;
        }
        
      }//end if2
      else
      {
         rec3 = tempSwap; 
      }
      
    }//End if1
    
  }//End of for loop
  
  //Create the font color and size
  PFont f;
  float fontSize = ( (height * width)/10000 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 18, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont' f
  fill(255,255,0);
  
  text(rec1, width*0.45f, height*0.25f);
  text(rec2, width*0.45f, height*0.5f);
  text(rec3, width*0.45f, height*0.75f);
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
  
  initialRadius = random(50, 100);
  
  gameObjects.add(new Asteroid(aposx, aposy, initialRadius));
  
  Ccounter++;  //Counter for current num of asteroids increments
  
  if(Ccounter == 4)
  {
    Ccounter = Ccounter+1;    //This is so later only every Second tiny asteroid will spawn another big one ( otherwise there is far too many asteroids )
  }
  
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