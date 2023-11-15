clc(); clear(); close('all');

%Adatok
T =transpose( 219 : 10 : 309 );
viszk = [1.491, 1.266, 1.089, 0.947, 0.832, 0.737, 0.659, 0.593, 0.537, 0.489]';
T_intv = [215, 315];

%Megoldas - Linearis
log_viszk = log(viszk);
M = [ones( length (T) , 1), T, log_viszk]; %egyutthatomatrix
b =  T .* log_viszk;

eredm = mldivide( M, b );
A = eredm (2); C = -eredm (3); B = eredm (1) - A*C;
fgv_viszk = @(T) exp(A + B ./ (C+T));


%Megoldas - Nemlinearis
fgv_viszk_lsqcf = @(alfa,T) exp(alfa(1) + alfa(2) ./ (alfa(3)+T));
kezd_ertk = [ -5, 500, 10 ];
eredm_nlin = lsqcurvefit( fgv_viszk_lsqcf, kezd_ertk, T, viszk)
A_nlin = eredm_nlin(1);
B_nlin = eredm_nlin(2);
C_nlin = eredm_nlin(3);
fgv_log_viszk = @(T) A_nlin + B_nlin ./ (C_nlin+T);

%Abrazolas
figure (1);
hold ('on')
plot (T, viszk, 'o');
fplot (fgv_viszk, T_intv, 'b');
hold ('off')
xlabel ('T, K');
ylabel ('\eta, mPa*s');
legend ('gyakorlati adatok', 'linearis ilesztes' );

figure (2);
hold ('on')
plot (T, log_viszk, 'o');
fplot (fgv_log_viszk, T_intv, 'b');
hold ('off')
xlabel ('T, K');
ylabel ('log(\eta), mPa*s');
legend ('gyakorlati adatok',  'nemlinearis illesztes' );

