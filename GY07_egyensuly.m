clc (), clear (), close( 'all' )

%Adatok
Kc = 0.1; %mol/dm^3
T = 340;
p = 2;
R = 0.0820;
Xe_intv = [0.1, 0.6];
CA0 = p /(R*T);

%Polinom gyokei
p = [ 4*CA0, Kc, -Kc];
gyokok = roots(p);

%FZERO - gyokkereses
fgv_Kc = @ (Xe) 4*CA0 * Xe.^2 ./ (1-Xe);
fgv_Kc_fzero = @ (Xe) 4*CA0 * Xe.^2 ./ (1-Xe) - Kc;\

[x,y]= fzero( fgv_Kc_fzero, [0.4, 0.5] )

%Abrazolas
hold('on');
fplot(fgv_Kc, Xe_intv, 'b' );
plot(x, Kc, 'ok');
plot([0.1,x ], [Kc, Kc ], '--', 'Color', "#EDB120");
plot([x,x ], [0, Kc ], '--', 'Color', "#EDB120");
hold('off');
xlabel('X_e');
ylabel('K_c (mol/L)');
legend('K_c=f(X_e)', 'Location', 'northwest');

