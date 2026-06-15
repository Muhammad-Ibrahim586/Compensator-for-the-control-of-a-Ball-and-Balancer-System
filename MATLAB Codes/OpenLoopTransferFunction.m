s = tf('s'); 
 
alpha = 0; 
 
m = 0.11; 
R = 0.015; 
d = 0.03; 
g = -9.8; 
L = 1.0; 
I = 0.00000999; 
 
Y = -m*g*(d/L); 
Theta = (s^2)*((I/R^2)+m); 
 
disp('Open Loop Transfer Function G(s) = Y(s)/Theta(s) of the plant is:'); 
G = Y/Theta 