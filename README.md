# speed-detection

A simple MATLAB project of determining the speed of an object moving between two known lines.
The object must come from left to right. Two red lines must be drawn on the ground and the distance between them must be known.

INPUT:
- fileName: the name (or path) of the video file
- RGB: a vector that contains the conditions for column matching. It is a 3 x 1 (or 1 x 3) vector of type int ([0, 255]):
  - RGB(1) - the minimum amount of red a pixel must have
  - RGB(2) - the maximum amount of green a pixel must have
  - RGB(3) - the maximum amount of blue a pixel must have
- DISTANCE: the distance in meters between the two lines
- p: minimum percentage a pixel must be changed than another pixel to be counted as different
- DIF: the minimum percentage in which two columns differ in order to found a new object getting in the frame
- spF: speed format ('km/h' or 'm/s')

OUTPUT:
- SPEED: the speed of the object (in either km/h or m/s)
