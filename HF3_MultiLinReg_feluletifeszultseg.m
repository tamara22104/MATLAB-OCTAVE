clc(), clear(), close('all');

%%Adatok
T = transpose([315, 356, 372.4, 397, 438, 462.6, 479, 503.6, 520, 561, 585.6]); %Kelvin
szigma = transpose([69.159, 61.973, 58.952, 54.231, 45.803, 40.403, 36.670, 30.900, 26.971, 17.092, 11.364]); %mN/m
Tc = 647.3; %Kelvin kritikus homerseklet
Tr = T./Tc; %Redulkalt homerseklet
T_intv = [300, 600];

%MEGOLDAS
%Alpont 1.
M = [ ones(length(T), 1), log(1-Tr), Tr.*log(1-Tr), (Tr.^2).*log(1-Tr)];
b = log(szigma);
eredm = mldivide(M, b);
A = exp(eredm(1));
B = eredm(2);
C = eredm(3);
D = eredm(4);

s1 = sprintf('Konstansok ertekei: A = %.3f, B = %.3f, C = %.3f, D = %.3f', A, B, C, D);
disp(s1);

%Alpont 2.
fgv_log_szigma = @(hom) log(A) + B * log(1-hom/Tc) + C*(hom./Tc).*log(1-hom./Tc) + D.*((hom./Tc).^2).*log(1-hom./Tc);

%Alpont 3 .
fgv_szigma_lsqcf = @ ( alfa, hom ) alfa(1) * (1-hom./Tc).^(alfa(2)+alfa(3).*(hom./Tc)+ alfa(4).*(hom./Tc).^2);
kezd_ertk = [100, 1, 1, 1 ];
eredm_nlin = lsqcurvefit( fgv_szigma_lsqcf, kezd_ertk, T, szigma);
A_nlin = eredm_nlin(1);
B_nlin = eredm_nlin(2);
C_nlin = eredm_nlin(3);
D_nlin = eredm_nlin(4);
fgv_szigma_nlin = @ (hom) A_nlin * (1-hom./Tc).^(B_nlin +C_nlin.*(hom./Tc)+ D_nlin.*(hom./Tc).^2);

%Alpont 4.
T_1 = [335, 415, 540];
szigma_1 = fgv_log_szigma(T_1);

%Alpont 5.
szigma_2 = [20, 50, 65 ];
fgv_szigma_fzero1 = @(T_2) fgv_szigma_nlin(T_2) - szigma_2(1);
fgv_szigma_fzero2 = @(T_2) fgv_szigma_nlin(T_2) - szigma_2(2);
fgv_szigma_fzero3 = @(T_2) fgv_szigma_nlin(T_2) - szigma_2(3);
eredm_T1 = fzero(fgv_szigma_fzero1, 400);
eredm_T2 = fzero(fgv_szigma_fzero2, 450);
eredm_T3 = fzero(fgv_szigma_fzero3, 500);

%Abrazolas
figure(1);
hold ('on');
plot(T, b, 'rp', 'MarkerFaceColor', 'r');
fplot(fgv_log_szigma, T_intv, 'b');
plot(T_1, szigma_1, 'pk', 'MarkerFaceColor', 'k');
hold('off');
xlabel('T, fok');
ylabel('log(\sigma)');
legend('Adatok', 'Illesztett fuggveny', 'Feluleti feszultseg ertekei T_1');

figure(2);
hold ('on');
plot(T, szigma, 'ob');
fplot(fgv_szigma_nlin, T_intv, 'r');
plot(eredm_T1, szigma_2(1), 'og', 'MarkerFaceColor', 'g');
plot(eredm_T2, szigma_2(2), 'og', 'MarkerFaceColor', 'g');
plot(eredm_T3, szigma_2(3), 'og', 'MarkerFaceColor', 'g');
hold('off');
xlabel('T, fok');
ylabel('\sigma, mN/m');
legend('Adatok', 'Nemlinearis illesztes', 'Homerseklet ertekei \sigma_2');

