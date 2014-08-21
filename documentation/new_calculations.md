# Functional parameters (Correlated to rider terms)

## Impact firmness (implemented)
peak vertical acceleration from the triaxial accelerometer

## Cushioning (implemented)
peak vertical force from the triaxial load cell

## Responsiveness (not yet implemented)

* differentiate the linear potentiometer signal to get velocity
* find the time between peak force and maximum displacement of the linear potentiometer (Dmax time)
* find the time between maximum displacement of the linear potentiometer and maximum velocity of recovery of the spring (say Vmax time)
* calculate Dmax time / Vmax time = responsiveness

## Grip (not yet implemented)

* find the point of impact (based on the resultant of the three axes of the triaxial load cell)
* calculate the speed of the string pot and based on the angle of the slope (8 degrees currently) calculate the horizontal component of speed at the point of impact
* divide the horizontal force signal from the tri-axial load cell by the mass of the machine sliding components (33 kg, according to Sarah Hobbes)
* calculate the indefinite integral of the result using a constant of zero to obtain velocity
* calculate the indefinite integral of the velocity result using a constant of the horizontal speed at the point of impact to obtain displacement. 
* determine the displacement during loading by calculating the difference between displacement at the point of impact to displacement at the point of peak forcefrom the vertical force measurements
