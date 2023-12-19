clc(), clear(), close('all')

%%Adatok
N0 = 10^4;
rN = 0.58 ;%nap*-1
KN = 10^5; %egyed
alfa = 10^4;
beta = 10^4;
t0 = 1; %nap
t_adott = 60; %nap

%%Megoldas
dNdt1 = @(t, N) rN * N *(1 - (N/KN)) - beta * ( N^2 / (alfa^2 + N^2));
[ido, egyed] = ode45( dNdt1,[t0, t_adott], N0 );

dNdt2 = @(t, N) rN * N *(1 - (N/KN)) ;
[ido2, egyed2] = ode45( dNdt2,[t0, t_adott], N0 );

%%Abrazolas
hold('on');
plot( ido, egyed, 'b');
plot(ido2, egyed2, 'm');
hold ('off');
xlabel( 't (nap)'); ylabel('N (egyedszam)');
legend('Populaciodinamika predikcioval', 'Populaciodinamika predikcio hianyaban');
