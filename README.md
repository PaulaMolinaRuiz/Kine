# Kine


El código hace un análisis de audio y video a partir de información que recibe a través de un micrófono y una cámara kinect que se encuentren conectados o integrados a un computador.  

Para el análisis de video, se utilizó la librería open kinect de Daniel Shiffman que nos permite acceder a la información de color y profundidad que captura el sensor. Dependiendo de la distancia y luminosidad de un punto, el programa interpreta la opacidad del color y lo asigna al pixel correspondiente en la imagen proyectada para crear un efecto tridimensional.  

Además, permite que la persona pueda ajustar el ángulo de la cámara desde su teclado, para esto nosotros asignamos los botones de las flechas arriba y abajo.

Para el análisis de volumen se utilizó la librería de sonido de processing, con la cual podemos obtener el valor de la  amplitud del audio que se recibe como input. 

Si usted quiere usar este codigo para hacer la instalación por su cuenta, deberá crear un nuevo "Branch" en donde agrgue los cambios que realizó.
