clc(); clear(); close('all');

%Adatok
T =transpose( 219 : 10 : 309 );
viszk = [1.491, 1.266, 1.089, 0.947, 0.832, 0.737, 0.659, 0.593, 0.537, 0.489]';
T_intv = [215, 315];

%Megoldas - Linearis
log_T = log(T);
log_viszk = log(viszk);
recip_T = 1 ./ T;

M = [ ones( length( T ) , 1), recip_T, log_T ]; %egyutthatomatrix
eredm = mldivide(M, log_viszk);
A = eredm (1); B = eredm (2); C = eredm (3);

fgv_log_viszk = @ (T) A + B ./ T + C * log(T);
fgv_viszk = @ (T) exp(A + B ./ T + C * log(T));

%%Megoldas - Nemlinearis
fgv_viszk_lsqcf = @ (alfa, T) exp(alfa(1) + alfa(2) ./ T + alfa(3) * log(T));
kezd_ertk = [ -10, 1000, 0 ];
eredm_nlin = lsqcurvefit( fgv_viszk_lsqcf, kezd_ertk, T, viszk)


%Abrazolas
figure (1);
hold ('on')
plot (T, log_viszk, 'o');
fplot (fgv_log_viszk, T_intv)
hold ('off')
xlabel ('T, K'); ylabel ('\eta, mPa*s');
legend ('gyakorlati adatok', 'illesztett gorbe');
ylim ([ -.8, .6])

figure (2)
hold ('on')
plot (T, viszk, 'o');
fplot (fgv_viszk, T_intv)
hold ('off')
xlabel ('T, K'); ylabel ('\eta, mPa*s');
legend ('gyakorlati adatok', 'illesztett gorbe');
