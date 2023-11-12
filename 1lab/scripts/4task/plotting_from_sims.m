plot(out.u.Time, out.u.Data, 'LineWidth', 2, 'DisplayName', 'u(t)')
legend()
xlabel('Time, sec')
ylabel('u')
xlim([0 0.1])
ylim([-51 51])
grid on