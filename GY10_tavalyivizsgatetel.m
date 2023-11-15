clc ( ), clear ( ), close ( 'all' )

%%Adatok
T = 219 : 10 : 309; %%Kelvin
viszk = [ 1.491, 1.266, 1.089, 0.947, 0.832, 0.737, 0.659, 0.593, 0.537, 0.489]; %% mPa*s
% hatarozd meg A es B parametereket, biz be hogy helyes
x = 1 ./ T;
y = log( viszk );
homerseklet = [ 215, 325 ];
recip_homerseklet = [ 1/homerseklet(2); 1/homerseklet(1)];

%%Megoldas - LINEARIS
eredm = polyfit(x, y, 1);
B1 = eredm (1);
A1 = exp( eredm(2));
fgv_viszk = @ (T) A1 * exp( B1 ./ T );
fgv_log_viszk = @ (Trec) B1*Trec + log(A1);

%%Megoldas - NEMLINEARIS
fgv_viszk_lsqcf = @ ( alfa, T ) alfa(1) * exp( alfa(2) ./ T );
kezd_ertk = [ 1, 1000 ];
eredm_nlin = lsqcurvefit( fgv_viszk_lsqcf, kezd_ertk, T, viszk);
A1_nlin = eredm_nlin(1);
B1_nlin = eredm_nlin(2);
fgv_viszk_nlin = @ (T) A1_nlin * exp( B1_nlin ./ T );


%%Abrazolas
figure ( 'Name', ' Gorbeillesztes' )
hold('on');
plot ( T, viszk, 'bo' );
fplot ( fgv_viszk, homerseklet );
fplot ( fgv_viszk_nlin, homerseklet ); %%mivel helyes a megoldas ezert az elteres minimalis es a ket gorbe egymason fekszik
hold ( 'off' );
xlabel ( 'T (K) ');
ylabel ( '\eta (mPa*s)');
legend ( 'gyakorlati adatok', 'linearis illesztes ', 'nemlinearis illesztes' );

figure ( 'Name', ' Eredmeny illesztese' )
hold('on');
plot ( x, y, 'ms' );
fplot ( fgv_log_viszk, recip_homerseklet );
hold ( 'off' );
xlabel ( '1/T (1/K) ');
ylabel ( 'log(\eta) (mPa*s)');
legend ( 'gyakorlati adatok', 'illesztett gorbe ');


