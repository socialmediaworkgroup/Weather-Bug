/*
Brandon Wade

Processing code that retrieves weather information for wunderground.com

1/17/2017

*/
import static javax.swing.JOptionPane.*;

String server = ("http://api.wunderground.com/api/a30fcf18ad5fcace/conditions/q/NM/Albuquerque.xml");


XML xml;

PFont font;

byte firstrun = 0;
byte errcount = 0;

int speed = 0;
int ystep;// Spacing out the data on screen
int linespace = 18;
int currenttime;
int oldtime;

float windColor;

String location = " ";
String thislocation = location;

void setup()
{
  
 //font = createFont("arial.ttf", 14);
 //textFont(font);
 
 fill(#000000);
 
 size(500, 700);
 
 fill(#FFFF00);
 
 stroke(#FFFF00);
 
 background(#4040FF);
 
 surface.setLocation(10, 10);
  
 ystep = 24;
 
 oldtime = millis();

}

void draw()
{
  int minSpeed= 1;
  int maxSpeed = 95;
  
  if (firstrun == 0)
    {
     // Put 1st time code here
      Cprintme("Loading: " + thislocation);
      firstrun = 1;
    }
    else{
    currenttime = millis();
    if (firstrun == 1 || currenttime - oldtime >= 60000){
    oldtime = currenttime;
    firstrun = 2;
    ystep = 24;
    // Load the XML document
    xml = loadXML(server);
    
   
    background(color(255-windColor, windColor, windColor));
    //
    Cprintme("Location: " + thislocation); ystep = ystep + linespace;
    // Grab the element we want
     XML myval = xml.getChild("current_observation/display_location/full");
     String test = myval.getContent();
     
      if (test == null){
        print("test1");
      noLoop();
      errcount++;
          if (errcount<4){
          // reset to default url
          thislocation = location;
          firstrun = 1;          
          javax.swing.JOptionPane.showMessageDialog(null, "The last location returned null.\r\nThe default location has been applied.");
          loop();
          print("test2");
          }else{
          javax.swing.JOptionPane.showMessageDialog(null, "Error limit exceeded, stopping");
          }
      }else{
        try{
        // Get the attributes we want
        String city = myval.getContent();
        Cprintme(city);
        
        myval = xml.getChild("current_observation/observation_time");
       
        Lprintme(myval.getContent() + ":", 20);
       
        
         
        
        
         myval = xml.getChild("current_observation/wind_mph");
         
       
    
       
        String showspeed = "Wind: " + myval.getContent() + " ";
          
        Lprintme(showspeed, 20);
        
         // Convert wind speed to a 0-255 color value
        // windColor = map(speedcolor, minSpeed, maxSpeed, 0, 255); 
        
     
        
       
      
        }
        catch(Exception e){

        noLoop();
        errcount ++;
          if (errcount<4){
          // reset to default url
          thislocation = location;
          
          firstrun = 0;           
          javax.swing.JOptionPane.showMessageDialog(null, "The last location returned null.\r\nThe default location has been applied.");
          loop();
          
          }else{
          javax.swing.JOptionPane.showMessageDialog(null, "Error limit exceeded, stopping");
          }
                
        } // end catch
      } // end else
    } // end firstrun = 1 or timeout     
  } // end firstrun !=0
  
  
 /* 
  xml = loadXML(server);
  XML myval = xml.getChild("current_observation/wind_mph");
 
  println(myval.getContent());
  */
 
  
}

void Cprintme(String temp)
{
  float mywidth = textWidth(temp);
  text(temp, (width - mywidth) / 2, ystep);
  ystep = ystep + linespace;
}
void Lprintme(String temp, int margin){
text(temp, margin, ystep);
ystep = ystep + linespace;
}