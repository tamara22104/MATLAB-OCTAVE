clc ( ), clear ( ), close ( 'all' )

%%Adatok
A = 80.3682; B = 0.266457; C = 561.65; D = 0.28798;
homerseklet = [ 400, 500 ]; %Kelvin

Suruseg = @ (T) A ./ ( B .^ (1 + (1 - T/C) .^ D));

%%Abrazolas
fplot ( Suruseg, homerseklet);
xlabel ( 'T(K) ');
ylabel ( '\rho (kg/m^3)');
legend ( 'suruseg');
