clc(), clear(), close('all');

%%Adatok
t_intv = [0, 15, 30, 45, 60, 75, 90]; %%min

c_1 = [0.750, 0.648, 0.562, 0.514, 0.460, 0.414, 0.385]; %%mol/L
c_2 = [0.750, 0.622, 0.530, 0.467, 0.410, 0.378, 0.336]; %%mol/L
c_3 = [0.750, 0.590, 0.490, 0.410, 0.365, 0.315, 0.290]; %%mol/L
c_4 = [0.750, 0.556, 0.440, 0.365, 0.315, 0.275, 0.243]; %%mol/L
c_5 = [0.750, 0.520, 0.400, 0.324, 0.270, 0.235, 0.205]; %%mol/L

t_fok = [25,30,35,40,45]; %%Celsius
T = t_fok + 273.15; %%Kelvin
Trec = 1./T;

%%1 alpont
y_1 = log(c_4);
y_2 = 1./c_4;
%%2 alpont
rec_c_1 = 1 ./c_1;
rec_c_2 = 1 ./c_2;
rec_c_3 = 1 ./c_3;
rec_c_4 = 1 ./c_4;
rec_c_5 = 1 ./c_5;

%% 1.ALPONT - MEGOLDAS
eredm_elsod = polyfit(t_intv, y_1, 1);
c0_elsod = exp(eredm_elsod(2));
k_elsod = -eredm_elsod(1);

eredm_masod = polyfit(t_intv, y_2, 1);
c0_masod = 1./eredm_masod(2);
k_masod = eredm_masod(1);


%% 1.ALPONT - FUGGVENYEK
f_elsod = @ (t) c0_elsod * exp(-k_elsod * t);
f_masod = @(t) c0_masod ./ (1+ k_masod * c0_masod * t);

%% 1.ALPONT - ABRAZOLAS

figure('Name','Elsorendu reakcio');
hold('on');
plot(t_intv, c_4, 'sm--');
fplot( f_elsod, [t_intv(1),t_intv(end)]);
hold('off');
xlabel('t (min)'); ylabel('c (mol/L)');
legend('adatok 40 fokra', 'illesztett gorbe');

figure('Name','Masodrendu reakcio ')
hold('on');
plot(t_intv, c_4, 'sm--');
fplot( f_masod, [t_intv(1),t_intv(end)]);
hold('off');
xlabel('t (min)'); ylabel('c (mol/L)');
legend('adatok 40 fokra', 'illesztett gorbe');

%% 2.ALPONT - MEGOLDAS
eredm_masod_25 = polyfit(t_intv, rec_c_1, 1);
c0_masod_25 = 1./eredm_masod_25(2);
k25 = eredm_masod_25(1);
f_masod_25= @(t) c0_masod_25 ./ (1+ k25 * c0_masod_25 * t);

eredm_masod_30 = polyfit(t_intv, rec_c_2, 1);
c0_masod_30 = 1./eredm_masod_30(2);
k30 = eredm_masod_30(1);
f_masod_30= @(t) c0_masod_30 ./ (1+ k30 * c0_masod_30 * t);

eredm_masod_35 = polyfit(t_intv, rec_c_3, 1);
c0_masod_35 = 1./eredm_masod_35(2);
k35 = eredm_masod_35(1);
f_masod_35= @(t) c0_masod_35 ./ (1+ k35 * c0_masod_35 * t);

eredm_masod_40 = polyfit(t_intv, rec_c_4, 1);
c0_masod_40 = 1./eredm_masod_40(2);
k40 = eredm_masod_40(1);
f_masod_40= @(t) c0_masod_40 ./ (1+ k40 * c0_masod_40 * t);

eredm_masod_45 = polyfit(t_intv, rec_c_5, 1);
c0_masod_45 = 1./eredm_masod_45(2);
k45 = eredm_masod_45(1);
f_masod_45= @(t) c0_masod_45 ./ (1+ k45 * c0_masod_45 * t);

k = [k25, k30,k35, k40, k45];

%% 2.ALPONT - ABRAZOLAS
figure('Name', 'Reakciosebessegi allandok');
hold('on');
plot(t_intv, c_1,'bo', 'MarkerFaceColor', 'b');
fplot(f_masod_25,[t_intv(1),t_intv(end)], 'b');
plot(t_intv, c_2,'ro', 'MarkerFaceColor', 'r');
fplot(f_masod_30,[t_intv(1),t_intv(end)], 'r' );
plot(t_intv, c_3,'go', 'MarkerFaceColor', 'g');
fplot(f_masod_35,[t_intv(1),t_intv(end)], 'g');
plot(t_intv, c_4,'yo','MarkerFaceColor', 'y');
fplot(f_masod_40,[t_intv(1),t_intv(end)], 'y' );
plot(t_intv, c_5,'mo', 'MarkerFaceColor', 'm');
fplot(f_masod_45,[t_intv(1),t_intv(end)], 'm' );
hold('off');
xlabel('t (min)'); ylabel('C (mol/L)');
legend('Adatok 25 C', 'Illesztett gorbe 25 C','Adatok 30 C', 'Illesztett gorbe 30 C','Adatok 35 C', 'Illesztett gorbe 35 C','Adatok 40 C', 'Illesztett gorbe 40 C','Adatok 45 C', 'Illesztett gorbe 45 C' );

%% 3.ALPONT - MEGOLDAS
R=8.3145e-03;
y_lin = log(k);
x_lin = 1./T;

eredm_lin = polyfit(x_lin, y_lin, 1);
Ea = -eredm_lin(1) * R;
A = exp(eredm_lin(2));
f_arh = @(T) A*exp(-Ea./(R*T));

%% 3.ALPONT - ABRAZOLAS
figure('Name', 'Gorbeillesztes')
hold('on');
plot(T, k, 'pb')
fplot(f_arh, [T(1),T(end)], 'r');
hold('off');
xlabel('T (K)'), ylabel('k (mol/L*perc)')
legend( 'Adatok', 'Illesztett gorbe', 'Location', 'Southeast');

%% 4.ALPONT - MEGOLDAS
s1 = sprintf('Aktivalasi energia: E1 = %.3f kJ, Utkozesi tenyezo: A = %.2f, Masodrendu reakcio: n = 2 ', Ea, A);
disp(s1);


