t = out.tout;

m = squeeze(out.yout{1}.Values.Data);
plot(t, m, LineWidth=2)
ylabel('M, N\cdotm', 'FontSize', 14)
legend('M(t)')

% omega = squeeze(out.yout{2}.Values.Data);
% plot(t, omega, LineWidth=2)
% ylabel('\omega, rad/s', 'FontSize', 14)
% legend('\omega(t)')

grid on
xlabel('t, с', 'FontSize', 16)

ax = gca;
ax.FontSize = 16; 
