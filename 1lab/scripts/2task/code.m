%% initials

m_load = 4400;  % kg
g = 9.8;  % gravity constant, m/s^2
v_load = 0.016;  % m/s
P_load = m_load * g;  % N

z_1 = 17;
z_2 = 31;
z_3 = 22;
z_4 = 54;
z_5 = 22;
z_6 = 76;

J_2 = 0.14; 
J_3 = 0.3236;
J_4 = 0.0809;
J_5 = 0.2690;
J_6 = 0.1047;
J_7 = 0.4685;
J_8 = 0.1213;
J_9 = 0.3329;

d_1 = 0.15;  % m
d_2 = 0.2;  % m
s = 0.01;  % m

z = 1;
i = 1;

eta_belt = 0.95;
eta_tooth = 0.9;
eta_scr = 0.6;
eta_chain = 0.97;

c_sl = 15 * 10^6;  % nm/rad
c_belt = 3 * 10^6;  % nm/rad
c_chain = 12 * 10^6;  % nm/rad

%% calculations

n_scr = 60 * v_load / (z * s);  % rpm
w_scr = 2 * pi * n_scr / 60;  % rad/s

j_12 = d_2 / d_1;
j_23 = z_2 / z_1;
j_34 = z_4 / z_3;
j_45 = z_6 / z_5;
j_15 = j_12 * j_23 * j_34 * j_45;

n_eng = n_scr * j_15;  % rpm
w_eng = 2 * pi * n_eng / 60;  % rad/s

r_load_wave = v_load / w_eng;

M_c = m_load / 2 * g * r_load_wave / (eta_belt * eta_tooth^3 * eta_scr) * (1 + 1 / eta_chain);
N_eng = M_c * w_eng;

%% engine 5A80MB2 data
N_nom = 2200;
M_nom = 7.4;
n_0 = 3000;
w_0 = 2 * pi * n_0 / 60;
n_nom = 2850;
w_nom = 2 * pi * n_nom / 60;
J_eng = 0.0021;

%% recalculating the d_1
M_2 = M_nom * j_12 * eta_belt;
w_2 = w_eng / j_12;
h = M_nom / (w_0 - w_nom);
j_12_new = w_0 / 2 / w_2 * (1 + sqrt(1 - (4 * M_2 * w_2)/(eta_belt * h * w_0^2)));
d_1_new = d_2 / j_12_new;
j_15_new = j_12_new * j_23 * j_34 * j_45;

n_eng_new = n_scr * j_15_new;
w_eng_new = 2 * pi * n_eng_new / 60;
r_load_wave_new = v_load / w_eng_new;
M_c_new = m_load / 2 * g * r_load_wave_new / (eta_belt * eta_tooth^3 * eta_scr) * (1 + 1 / eta_chain);
N_eng_new = M_c_new * w_eng_new;