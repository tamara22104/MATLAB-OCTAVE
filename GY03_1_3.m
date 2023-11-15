clc ( ), clear ( ), close ( 'all' )

%% Adatok
t = [-50, -25, 0, 50, 100, 200, 300, 500, 750, 1000]; %%Celsius
T = t + 273.15; %%Kelvin
mu = [14.56, 15.88, 17.15, 19.53, 21.74, 25.73, 29.28, 35.47, 42.10, 47.88];
T_intv = [200,1300];
T1 = [ 75, 400, 800] + 273.15;


%%Regresszio
y = T .^ (3/2)./ mu;
eredmeny = polyfit( T, y, 1 );
C = 1/ eredmeny(1);
S = eredmeny(2)* C;

fgv_mu = @ (T) C * T .^ (3/2) ./ (T + S);
fgv_y = @ (T) 1/C * T + S/C;

mu1 = fgv_mu(T1);

%% Abrazolas
figure ( 'Name', 'Gorbeillesztes' )
hold ('on');
plot ( T, mu, 'or');
plot(T1, mu1, 'pk');
fplot ( fgv_mu, T_intv, 'b');
hold ('off');
xlabel ( 'T(K) ');
ylabel ( '\mu(Pa*s)');
legend ('gyakorlati adatok','kulonb homersekleten a viszkozitas','illesztett gorbe ', 'Location', 'southeast');


figure ( 'Name', 'Egyenes illesztese' )
hold ('on');
plot ( T, y, 's');
fplot ( fgv_y, T_intv);
hold ('off');
xlabel ( 'T(K) ');
ylabel ( 'T^{3/2}/\mu');
legend ('gyakorlati adatok','illesztett gorbe ', 'Location', 'southeast');

