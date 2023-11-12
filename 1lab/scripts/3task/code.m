%% initial data

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

J_1 = 0.0021;
J_2 = 0.14; 
J_3 = 0.3236;
J_4 = 0.0809;
J_5 = 0.2690;
J_6 = 0.1047;
J_7 = 0.4685;
J_8 = 0.1213;
J_9 = 0.3329;

d_1 = 0.1025;  % m
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

%% preparation calcs

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

%% calculations of J_s and c_s

J_1s = J_1;
J_2s = J_2;
J_3s = J_3 / j_12^2;
J_4s = J_4 / j_12^2;
J_5s = J_5 / j_12^2 / j_23^2;
J_6s = J_6 / j_12^2 / j_23^2;
J_7s = J_7 / j_12^2 / j_23^2 / j_34^2;
J_8s = J_8 / j_12^2 / j_23^2 / j_34^2;
J_9s = J_9 / j_12^2 / j_23^2 / j_34^2 / j_45^2;
J_10_1s = m_load / 2 * r_load_wave^2 / j_12^2 / j_23 ^2 / j_34^2 / j_45^2;
J_10_2s = J_10_1s;

c_1s = c_sl;
c_2s = c_belt / j_12^2;
c_3s = c_sl / j_12^2 / j_23^2 / j_34^2;
c_4s = c_chain / j_12^2 / j_23^2 / j_34^2 / j_45^2;

%% 5-mass system

J_37s = J_3s + J_4s + J_5s + J_6s + J_7s;
J_810s = J_8s + J_9s + J_10_1s;

A_5_mass = [0 0 0 0 0 -1/J_1s 0 0 0;
            0 0 0 0 0 1/J_2s -1/J_2s 0 0;
            0 0 0 0 0 0 1/J_37s -1/J_37s 0;
            0 0 0 0 0 0 0 1/J_810s -1/J_810s;
            0 0 0 0 0 0 0 0 1/J_10_2s;
            c_1s -c_1s 0 0 0 0 0 0 0;
            0 c_2s -c_2s 0 0 0 0 0 0;
            0 0 c_3s -c_3s 0 0 0 0 0;
            0 0 0 c_4s -c_4s 0 0 0 0];

eig_values_5_mass = eig(A_5_mass) / 2 / pi;
res_freq_5_mass = imag(eig(A_5_mass))/ 2 / pi;
res_freq_5_mass = sort(res_freq_5_mass(res_freq_5_mass > 0));

%% 3-mass system

J_17s = J_1s + J_2s + J_3s + J_4s + J_5s + J_6s + J_7s;
J_810s = J_8s + J_9s + J_10_1s;

A_3_mass = [0 0 0 -1/J_17s 0;
            0 0 0 1/J_810s -1/J_810s;
            0 0 0 0 1/J_10_2s;
            c_3s -c_3s 0 0 0;
            0 c_4s -c_4s 0 0];

eig_values_3_mass = eig(A_3_mass) / 2/ pi
res_freq_3_mass = imag(eig(A_3_mass)) / 2 / pi;
res_freq_3_mass = sort(res_freq_3_mass(res_freq_3_mass > 0));
%% 2-mass system

J_17s = J_1s + J_2s + J_3s + J_4s + J_5s + J_6s + J_7s;
J_810sx2 = J_8s + J_9s + J_10_1s + J_10_2s;
c_34s = 1 / (1 / c_3s + 1/ c_4s);

A_2_mass = [0 0 -1/J_17s;
            0 0 1/J_810sx2;
            c_34s -c_34s 0];

res_freq_2_mass = imag(eig(A_2_mass)) / 2 / pi;
res_freq_2_mass = sort(res_freq_2_mass(res_freq_2_mass > 0));
