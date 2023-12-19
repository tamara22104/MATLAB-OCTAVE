clc(), clear(), close('all');

%%Adatok
m = 25; %kg
mu = 0.55;
F = 130; %N
g = 9.81;
theta_intv = [0, 80];

%%Fuggveny
fgv_F = @(theta) mu*m*g ./ (cosd(theta) + mu * sind(theta));

%%Megoldas - minimuma
[theta_F_min, F_min] = fminbnd(fgv_F, 20, 40)

%Megloldas - gyokkereses
fgv_F_fzero = @ (theta) fgv_F(theta) - F;
gyok1 = fzero(fgv_F_fzero, [0, 20]);
gyok2 = fzero(fgv_F_fzero, [40, 60]);

%%Kiiratas - Kapott eredmenyek megjelenitese a parancsablakba
s1 = sprintf('Eredmenyek: Minimalis ero: F = %.2f N, Szog: %.3f fok', F_min, theta_F_min);
disp(s1);

%%Abrazolas
figure('Name', 'Elmozditasa');
fplot(fgv_F, theta_intv, 'b');
hold('on');
plot(theta_F_min, F_min, 'ok', 'MarkerFaceColor', 'r');
plot( [gyok1,gyok2], [F,F], 'pk', 'MarkerFaceColor', 'g' );
hold('off');
xlabel('\theta (fok)');
ylabel( 'F (N)' );
ylim([110,190]);
legend('F = f(\theta)', 'minimum pont', 'Location', 'NorthWest');
yticks(110:10:190);


