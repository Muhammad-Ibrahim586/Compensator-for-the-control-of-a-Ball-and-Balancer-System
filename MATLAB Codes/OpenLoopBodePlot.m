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
 
figure; 
margin(G);  
title('Bode Plot of the Open Loop System'); 
grid on; 
 
[gm, pm, wcg, wcp] = margin(G); 
fprintf('Gain Margin: %f dB\n', 20*log10(gm)); 
fprintf('Phase Margin: %f degrees\n', pm);