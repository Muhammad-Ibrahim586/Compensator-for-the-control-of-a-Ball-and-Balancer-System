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
 
alpha = 0.0311; 
w_max = 1.5; 
w_d = w_max * sqrt(alpha); 
w_i = w_max / sqrt(alpha); 
 
G_mag = abs(evalfr(G, 1i * w_max)); 
D_norm = ((1i * w_max / w_d) + 1) / ((1i * w_max / w_i) + 1); 
K = 1 / (abs(D_norm) * G_mag);  
 
D_cl = K * ((s / w_d) + 1) / ((s / w_i) + 1); 
 
fprintf('Designed Lead Compensator Dcl(s):\n'); 
display(D_cl); 
 
Loop_TF = D_cl * G; 
figure(); 
margin(Loop_TF); 
grid on; 
 
[~, Pm, ~, Crossover_Freq] = margin(Loop_TF); 
 
System_CL = feedback(Loop_TF, 1); 
step_input = 0.25; 
t_axis = 0:0.01:6; 
 
figure(); 
step(step_input * System_CL, t_axis); 
grid on; 
 
perf_stats = stepinfo(System_CL, 'SettlingTimeThreshold', 0.02); 
 
[y_out, ~] = step(System_CL, t_axis); 
ess = abs((1 - y_out(end)) / 1) * 100; 
 
fprintf('\nPERFORMANCE\n'); 
fprintf('%-25s | %-12s | %-12s | %-12s | %-12s\n', 'Design Stage', 'Crossover Wc', 'Phase Margin', 'Overshoot (%)', 'Settling Time (s)'); 
fprintf('%-25s | %-12.2f | %-12.2f | %-12.2f | %-12.2f\n', 'Compensator Part (c)', Crossover_Freq, Pm, perf_stats.Overshoot, perf_stats.SettlingTime); 
fprintf('\n\n');