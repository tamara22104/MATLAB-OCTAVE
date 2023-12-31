clc (), clear (), close( 'all' )

%Adatok
H = [ 17.93, 36.36, 67.76, 98.10, 131.0, 169.5, 205.5, 228.3, 247.1, 250.5, 253.8, 254.5 ];
t = 7:7:84; %nap
Hmax = 255; %cm
y = log( Hmax ./ H - 1 );
t_intv = [5,85];
t1 = [25, 40, 60];

%Megoldas - Linearis
eredm_lin = polyfit( t, y, 1);
B_lin = - eredm_lin(1);
A_lin = exp(eredm_lin(2));


%Megoldas - Nemlinearis
fgv_H_lsqcf = @ (alfa, T) Hmax ./(1 + alfa(1) * exp(-alfa(2)*T));
kezd_ertk = [ 50, 1 ];
eredm_nlin = lsqcurvefit( fgv_H_lsqcf, kezd_ertk, t, H );
A_nlin = eredm_nlin(1);
B_nlin = eredm_nlin(2);

%Fuggveny
fgv_nap = @ (T) -B_lin * T + log(A_lin);
fgv_H_lin = @ (T) Hmax ./(1 + A_lin * exp(-B_lin*T));
fgv_H_nlin = @ (T) Hmax ./(1 + A_nlin * exp(-B_nlin*T));

%Szamitasok
H1 = fgv_H_nlin(t1);
H2 = 150; %cm
t2 = (log(A_nlin)- log( Hmax/H2 - 1))./B_nlin

%Abrazolas
figure('Name', 'Egyenes illesztese');
hold('on');
plot(t, y, 'o');
fplot( fgv_nap, t_intv);
hold( 'off');
xlabel( 't(nap)'); ylabel( 'Hmax/H - 1');
legend('gyakorlati adatok', 'linearis illesztes');

figure('Name', 'Gorbe illesztese');
hold('on');
plot(t, H, 'o');
plot(t1, H1, '^', 'Color', "#A2142F");
plot(t2, H2, 'sb');
plot([0,t2 ], [H2, H2 ], '--', 'Color', "#EDB120");
plot([t2,t2 ], [0, H2 ], '--', 'Color', "#EDB120");
fplot( fgv_H_lin, t_intv, 'Color', "#D95319");
fplot( fgv_H_nlin, t_intv, 'Color', "#77AC30");
hold( 'off');
xlabel( 't(nap)'); ylabel( 'H(cm)');
legend('gyakorlati adatok', 'megadott ertekekre ','linearis illesztes', 'nemlinearis illesztes', 'Location', 'southeast');




