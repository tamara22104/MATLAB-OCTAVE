clc(), clear(), close('all');

%% Adatok
L = [0.5 1.2, 1.7, 2.2, 4.5, 6.0] * 1e-2; %%cm
IT = [4.2, 4.0, 3.8, 3.6, 2.9, 2.5]; %%watt/m2
I0 = 5; %%watt/m2
L_intv = [0, 7]*1e-2; %%cm

%%Megoldas - Linearis
y = log(IT/I0);
eredm_lin = polyfit( L, y, 1);
beta_lin = -eredm_lin(1);
R_lin = 1 - exp(eredm_lin(2)/2);

fgv_IT = @ (L) I0 * (1-R_lin)^2 * exp(-beta_lin*L);
fgv_log_y = @(L) 2*log(1-R_lin) - beta_lin * L;

%%Megoldas - Neminearis
fgv_IT_lsqcf = @( alfa, L ) I0 * (1-alfa(1))^2 * exp(-alfa(2)*L);
kezd_ertk = [0.5, 10];
eredm_nlin = lsqcurvefit( fgv_IT_lsqcf, kezd_ertk, L, IT);
beta_nlin = eredm_nlin(2);
R_nlin = eredm_nlin(1);

fgv_IT_nlin = @ (L) I0 * (1-R_nlin)^2 * exp(-beta_nlin*L);

%%Megoldas - toresmtato
n1 = 2/(1 - sqrt(R_lin)) - 1;
n2 = 2/(1 + sqrt(R_lin)) - 1;
s1 = sprintf('A toresmutato n = %.3f', n1);
disp(s1);

%%Gyokkereses
IT1 = 2.7;
IT2 = 3.3;
fgv_IT1_fzero = @ (L) fgv_IT_nlin( L ) - IT1;
fgv_IT2_fzero = @ (L) fgv_IT_nlin( L ) - IT2;

L1 = fzero(fgv_IT1_fzero, 0.03 );
L2 = fzero(fgv_IT2_fzero, 0.03 );

%%Abrazolas
figure('Name', 'Eredmeny illesztese');
hold on;
plot(L, y, 'ok');
fplot(fgv_log_y, L_intv, 'm');
hold off
xlabel('L(m)');  ylabel('log(I_T/I_0) ');
legend('Adatok', 'illesztett gorbe');

figure('Name', 'Gorbeillesztes')
hold on;
plot(L,IT, 'ok');
fplot(fgv_IT, L_intv, 'rg');
fplot(fgv_IT_nlin, L_intv, 'y' );
plot( [L1,L2], [IT1,IT2], 'bx');
hold off;
xlabel('L(m)');  ylabel('I_T(watt/m^2) ');
legend('Adatok', 'linearis illesztes', 'nemlinearis illesztes');






