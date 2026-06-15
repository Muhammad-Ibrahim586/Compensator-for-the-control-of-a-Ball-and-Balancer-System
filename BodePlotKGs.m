s = tf('s'); 

m = 0.11;        
R = 0.015;       
d = 0.03;        
g = -9.8;         

L = 1.0;         
I = 9.99e-6;     
 
num_G = -m * g * (d / L); 
den_G = (I / (R^2)) + m; 
G = num_G / (den_G * s^2); 
 
K = 10.74; 
Uncompensated_Loop = K * G; 
 
figure; 
margin(Uncompensated_Loop); 
grid on; 
 
[~, Phase_Margin, ~, Crossover_Freq] = margin(Uncompensated_Loop); 
 
fprintf('Verification Results\n'); 
fprintf('Calculated Loop Gain K: %.2f\n', K); 
fprintf('Verified Gain Crossover Frequency (w_c): %.2f rad/s\n', Crossover_Freq); 
fprintf('Measured Phase Margin (PM): %.2f degrees\n', Phase_Margin);