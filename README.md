# comet3n
COMET3N plots trajectories of multiple objects in 3D 
comet3n(src) plots tracjectors of objects specified by MxN  matrix src.
The first 3 columns of src must be the x, y, and z coordinates of the
object at a timepoint. The 4th column is timepoint where spatial
coordinates are registered. The 5th column is the ID number of the
object. 

comet3n(src) plots cells and trajectories using the color
specified by the 6th to 8th column (R,G and B) of the input file, src. 

comet3n(src,'speed',num) allows different plotting speed, ranging from
1 to 10. When speed argument is not given, this function will plot at
maximum speed.

comet3n(src,'taillength',num) allows user to specify taillength.
Defauly is 20.

comet3n(src,'scale',num) allows user to change scale of the comet head.
The scale is relative to default size, which is 1/100 of the x axis
range.

comet3n(src,'alpha',num) allows user to change alpha value of the comet
head. Default is 1. 

Version 1.2.0
Copyright Chaoyuan Yeh, 2015
