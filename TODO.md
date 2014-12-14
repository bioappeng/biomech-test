# Project TODO

Currently in progress

## Implement functional parameter calculations

In addition to peak values, users need a number of calculations that correspond
to rider assessment of the surface. Those calculations are as follows


* Impact firmness (implemented)
  
  peak vertical acceleration from the triaxial accelerometer

* Cushioning (implemented)

  peak vertical force from the triaxial load cell

* Responsiveness (not yet implemented)
    1. differentiate the linear potentiometer signal to get velocity
    2. find the time between peak force and maximum displacement of the linear potentiometer (Dmax time)
    3. find the time between maximum displacement of the linear potentiometer and maximum velocity of recovery of the spring (say Vmax time)
    4. calculate Dmax time / Vmax time = responsiveness


* Grip (not yet implemented)
    1. find the point of impact (based on the resultant of the three axes of the triaxial load cell)
    2. calculate the speed of the string pot and based on the angle of the slope (8 degrees currently) calculate the horizontal component of speed at the point of impact
    3. divide the horizontal force signal from the tri-axial load cell by the mass of the machine sliding components (33 kg, according to Sarah Hobbes)
    4. calculate the indefinite integral of the result using a constant of zero to obtain velocity
    5. calculate the indefinite integral of the velocity result using a constant of the horizontal speed at the point of impact to obtain displacement. 
    6. determine the displacement during loading by calculating the difference between displacement at the point of impact to displacement at the point of peak forcefrom the vertical force measurements
