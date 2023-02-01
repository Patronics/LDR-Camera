# LDR-Camera
My 2013 project to make a rudimentary camera out of a grid of light dependent resistors and a PICAXE microcontroller

#### example photo
this photo was actually captured with this camera, and shows sunlight coming through a tall and narrow window

![A 7x7 pixel black and white picture, showing a tall and narrow window as a slightly lighter grey rectangle than the background](https://www.patronics.org/uploads/1/0/5/9/10597534/published/9771797.png) 

![A photo of the green circuit board of the project, most of which is filled by a grid of spots to insert the LDR sensors](https://www.patronics.org/uploads/1/0/5/9/10597534/440453754.jpg)

#### Usage (as I recall from memory, given this project has been mostly untouched for a decade now)
- compile picaxecam.c using your C compiler of choice
- Upload the .bas program of choice to the PICAXE 40X2.
- Press the shutter button if enabled on the script of choice
- connect the PICAXE to the computer, copy and paste output from the serial monitor into a text file (output is a newline delimited file of integers)
- run `echo textFileFromPreviousStep.txt > ./picaxecam inputBMPWithMatchingDimensionsToDesiredOutput.bmp outputFileName.bmp`
