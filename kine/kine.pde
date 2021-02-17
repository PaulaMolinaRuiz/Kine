/*
* Universidad de los Andes
* Estudio 6: Interacción
* Autor: Paula Molina Ruiz
* Versión 2
*/
import org.openkinect.processing.*;
import processing.sound.*;

//----------------------------------------------------------
// Constantes
//----------------------------------------------------------
static final int OPACIDAD = 0;
static final int COLOR = 1;

//----------------------------------------------------------
// Atributos
//----------------------------------------------------------
 /*
 * Live video from a Kinect() connected to the computer
 */
Kinect kinect;

 /*
 * Angulo de la camara Kinect
 */
float deg; 

/*
 * Audio input from computer microphone 
 */
 AudioIn input;

/*
 * Analisis de amplitud
 */
Amplitude analyzer;
float volumeAnalisis;

/*
 * Cambio de filtro
 */
boolean cambioEstado = true;
int estado = 1; //inicia con el filtro de opacidad


void setup()
{
  // Specify P3D renderer
  // With P3D, we can use z (depth) values and 3D-specific functions
  size(displayWidth, displayHeight, P3D); //Tamaño de la pantalla (ancho, largo)
  
  //Configuración Camara
  kinect = new Kinect(this);
  kinect.initVideo(); //inicia el video y video IR 

  deg = kinect.getTilt();
  
  //Configuracion Audio
  input= new AudioIn(this,0);
  input.start();
  
  //Analisis de amplitud
  analyzer = new Amplitude(this);
  analyzer.input(input);
}

void draw()
{
  background(0);
  kinect.enableColorDepth(true);
  PImage img= kinect.getVideoImage(); //maps the color of every pixel as to how far it is.
  
  volumeAnalisis = analyzer.analyze();
  println(volumeAnalisis);
  
  //Ubica cada pixel y toma su color
  int skip = 6;
  for(int x = 0; x < img.width; x+=skip ){
    for(int y = 0; y < img.height; y+=skip )
    {
      int index = x + y * img.width;
      // Convert kinect data to world xyz coordinate
      
      
      //análisis de profundidad
      float b = brightness(img.pixels[index]);
      float z = map(b, 0, 255, 150, 0);//Imagen mas estable
      fill(z); //muestra solo a la persona en fondo blonco
      noStroke();
      pushMatrix();
      
      //tamaño de la imagen completa
      translate(x+400,y+200,z+250); 
      
     float volumeColor;
      if(estado == 0 && cambioEstado == true) //Color
      {
        //println(estado);
       
         //Cambio de color con el sonido
         volumeColor = map(volumeAnalisis, 0, 0.095, 0, 255); //Definir que tanto queremos que la gente grite
         fill(255 - volumeColor/2, 255- volumeColor, volumeColor);
        
      }
      else if(estado == 1 && cambioEstado == true) //Opacidad
      {
         //Cambio de opacidad con el sonido (z)
        volumeColor = map(volumeAnalisis, 0, 20, 0, 255); //Definir que tanto queremos que la gente grite (ahi está con un grito duro)
        fill(z*volumeColor,0, 0);
      }
        rect(0,0,skip/2,skip/2);
        popMatrix();
      
  /************************************************************************************
  * COLOR
  *************************************************************************************/
        
      //Color party con el movimiento del mouse con z
      //fill(z ,z+ (mouseY/2) - 300, z+ (mouseX/2) - 500);

 /************************************************************************************
  * OPACIDAD
  *************************************************************************************/

      //Opacidad Invertida
      //  fill(z - 255 - volumeColor/2, z-255- volumeColor, z - volumeColor);
      //tamaño de los rectangulos

    }  
  }
}

//----------------------------------------------------------
// Controles
//----------------------------------------------------------

/*
* Control del kinect
*/
void keyPressed() {
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      deg++;
    } 
    else if (keyCode == DOWN) 
    {
      deg--;
    }
    
    deg = constrain(deg, 0, 30);
    kinect.setTilt(deg);
  }
}

/*
* Control del filtro
*/
void mouseReleased()
{
  if(estado == 1)
  {
    cambioEstado=true;
    estado = 0;
  }
  else if(estado == 0)
  {
    cambioEstado=true;
    estado = 1;
  }
}
