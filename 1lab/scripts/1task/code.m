%% initials

G_load = 5000;  % kg * m / s^2
g = 9.8;  % gravity constant
m_load = G_load / g;
v_load = 1 / 100;  % m / s

n_eng = 725;  %
w_eng = n_eng / 60 * (2 * pi);  % rad / s

eta_scr = 0.7;
eta_tooth = 0.9;

j_max = 5;
s = 12 * 10^(-3);  % m

J_1 = 0.005;  % kg * m^2
J_2 = 0.02;  % kg * m^2
J_3 = J_2;

%% calculation

w_scr = 2 * pi * v_load /  s;  % rad / s
j = w_eng / w_scr;
deg_red = log(j) / log(5);

%% results

j_12 = j_max;
j_23 = j / j_max;

%% calculation

M_load = G_load * v_load / w_scr;
M_load_s = M_load / (j_12 * j_23 * eta_tooth^2 * eta_scr);
P_eng = M_load_s * w_eng;

J_1_s = J_1;
J_2_s = J_2 / j_12^2;
J_3_s = J_3 / j_12^2 / j_23^2;
J_load_s = m_load * (v_load / w_eng)^2;
J_sum_s = J_1_s + J_2_s + J_3_s + J_load_s;