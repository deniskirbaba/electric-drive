hold on
plot(out.u.Time, out.w1.Data, 'LineWidth', 2, 'DisplayName', 'Simulink')
plot(out.u.Time, out.w1_simscape.Data, 'DisplayName', 'Simscape', 'LineWidth', 2, 'LineStyle', '--')
legend()
xlabel('Time, sec')
ylabel('\omega_1')
xlim([0 0.1])
% ylim([-51 51])
grid on