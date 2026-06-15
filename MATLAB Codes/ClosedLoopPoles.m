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

G = Y/Theta; 
 
G_cl = feedback(G, 1); 
 
p_cl = pole(G_cl); 
disp('Closed Loop Poles of the System are:'); 
disp(p_cl); 
 
figure; 
pzmap(G_cl); 
title('Pole Zero Map of the Closed Loop System'); 
grid on;