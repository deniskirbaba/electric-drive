%% initial data

J_1 = 5.8;
J_2 = 36.8;
K_12 = 10^6;
b_12 = 100;
M_L1 = 2;
M_L2 = 10;
M = 20;

%% evaluate the system

A = [-b_12/J_1 b_12/J_1 -1/J_1;
     b_12/J_2 -b_12/J_2 1/J_2;
     K_12 -K_12 0];
B = [1/J_1;
    0;
    0];

sys = ss(A, B, [1 0 0], 0);
syms p
W = [1 0 0] * inv(1i * p * eye(3) - A) * B;

W_real = real(W);
W_imag = imag(W);
amp_freq_char = sqrt(W_real^2 + W_imag^2);
diff_amp_freq_char = diff(amp_freq_char);
answer = double(solve(diff_amp_freq_char == 0, p, Real=true));

for p = 1:600
    W(p) = [1 0 0] * inv(1i * p * eye(3) - A) * B;
    W_real(p) = real(W(p));
    W_imag(p) = imag(W(p));
    amp_freq_char(p) = sqrt(W_real(p)^2 + W_imag(p)^2);
end

fig = figure;
plot(amp_freq_char);
hold on
title('АЧХ')
xlabel('Гц')
ylabel('Амплитуда')
grid on
