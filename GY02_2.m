clc ( ), clear ( ), close ( 'all' )

%%Adatok
A = -7.92779; B = 4313.54; C = 283.29;
homerseklet = [ 350, 500 ]; %Kelvin

Vogel = @ (T) exp( A + B ./ ( C + T ));

T1 = 360 : 20 : 480;
viszk1 = Vogel( T1 );

%%Abrazolas
figure ( 'Name', 'Benzol Viszkozitas' )
hold ( 'on' );
fplot ( Vogel, homerseklet);
plot ( T1, viszk1, 'ro');
hold ( 'off' );
xlabel ( 'T(K) ');
ylabel ( '\eta (mPa*s)');
legend ( 'Vogel', '400K' );


