num_G = [0.2095];  
den_G = [1 0 0];  
sys_G = tf(num_G, den_G); 
step_amplitude = 0.25;  
 
K_uncomp = 10.74; 
sys_L0 = K_uncomp * sys_G; 
sys_T0 = feedback(sys_L0, 1); 
 
num_C1 = 524.6 * [1 2.5]; den_C1 = [1 1311]; 
sys_C1 = tf(num_C1, den_C1); 
sys_L1 = series(sys_C1, sys_G); sys_T1 = feedback(sys_L1, 1); 
 
num_C2 = 741 * [1 0.59]; den_C2 = [1 34.2]; 
sys_C2 = tf(num_C2, den_C2); 
sys_L2 = series(sys_C2, sys_G); sys_T2 = feedback(sys_L2, 1); 
 
num_C3 = 5354 * [1 0.2707]; den_C3 = [1 142]; 
sys_C3 = tf(num_C3, den_C3); 
sys_L3 = series(sys_C3, sys_G); sys_T3 = feedback(sys_L3, 1); 
 
[~, Pm0, ~, ~] = margin(sys_L0); info0 = stepinfo(sys_T0); 
[~, Pm1, ~, ~] = margin(sys_L1); info1 = stepinfo(sys_T1); 
[~, Pm2, ~, ~] = margin(sys_L2); info2 = stepinfo(sys_T2); 
[~, Pm3, ~, ~] = margin(sys_L3); info3 = stepinfo(sys_T3); 
 
fprintf('\nPERFORMANCE\n'); 
fprintf('%-25s | %-12s | %-12s | %-12s\n', 'Design Stage', 'Phase Margin', 'Overshoot (%)', 'Settling Time (s)'); 
fprintf('\n'); 
fprintf('%-25s | %-12.2f | %-12.2f | %-12.2f\n', 'Uncompensated Loop', Pm0, info0.Overshoot, info0.SettlingTime); 
fprintf('%-25s | %-12.2f | %-12.2f | %-12.2f\n', 'Compensator 1', Pm1, info1.Overshoot, info1.SettlingTime); 
fprintf('%-25s | %-12.2f | %-12.2f | %-12.2f\n', 'Compensator 2', Pm2, info2.Overshoot, info2.SettlingTime); 
fprintf('%-25s | %-12.2f | %-12.2f | %-12.2f\n', 'Compensator 3', Pm3, info3.Overshoot, info3.SettlingTime); 
fprintf('\n\n'); 
 
w_vec = logspace(-2, 5, 2000); 
 
[mag0, phase0] = bode(sys_L0, w_vec); 
[mag1, phase1] = bode(sys_L1, w_vec); 
[mag2, phase2] = bode(sys_L2, w_vec); 
[mag3, phase3] = bode(sys_L3, w_vec); 
 
figure(); 
subplot(2,1,1); 
loglog(w_vec, squeeze(mag0), 'k:', 'LineWidth', 2.0); 
hold on; 
loglog(w_vec, squeeze(mag1), 'b-', 'LineWidth', 1.5); 
loglog(w_vec, squeeze(mag2), 'r--', 'LineWidth', 1.5); 
loglog(w_vec, squeeze(mag3), 'g-.', 'LineWidth', 1.5); 
grid on;  
xlim([10^-2, 10^5]); 
title('Bode Diagram - Magnitude Comparison');  
ylabel('Magnitude'); 
legend('Uncompensated', 'Compensator 1', 'Compensator 2', 'Compensator 3', 'Location', 'best'); 
 
subplot(2,1,2); 
semilogx(w_vec, squeeze(phase0), 'k:', 'LineWidth', 2.0); 
hold on; 
semilogx(w_vec, squeeze(phase1), 'b-', 'LineWidth', 1.5); 
semilogx(w_vec, squeeze(phase2), 'r--', 'LineWidth', 1.5); 
semilogx(w_vec, squeeze(phase3), 'g-.', 'LineWidth', 1.5); 
grid on;  
xlim([10^-2, 10^5]); 
ylim([-190, -90]); 
title('Bode Diagram - Phase Comparison');  
xlabel('Frequency (rad/s)');  
ylabel('Phase (deg)'); 
 
figure(); 
t_axis = 0:0.002:10; 
 
[y0, ~] = step(sys_T0, t_axis); 
[y1, ~] = step(sys_T1, t_axis); 
[y2, ~] = step(sys_T2, t_axis); 
[y3, ~] = step(sys_T3, t_axis); 
 
plot(t_axis, y0 * step_amplitude, 'k:', 'LineWidth', 2.0); hold on; 
plot(t_axis, y1 * step_amplitude, 'b-', 'LineWidth', 1.5); 
plot(t_axis, y2 * step_amplitude, 'r--', 'LineWidth', 1.5); 
plot(t_axis, y3 * step_amplitude, 'g-.', 'LineWidth', 1.5); 
grid on; 
xlim([0, 10]); 
ylim([0, 0.55]); 
title('Closed-Loop Step Response Comparison (Input = 0.25)'); 
xlabel('Time (seconds)'); 
ylabel('Position (meters)'); 
legend('Uncompensated', 'Compensator 1', 'Compensator 2', 'Compensator 3', 'Location', 'best'); 