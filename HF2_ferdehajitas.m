clc(), clear(), close('all');

%%Adatok
y0 = 1.8; %m
v0 = 20; %m/s
g = 9.81; %m/s^2
x =40; %m tavolsag
y = 1; %m magassag

%Megoldas 1 & 2 alpont
fgv_y = @(theta) x*tand(theta) - g./ (2 * v0^2 * cosd(theta).^2) *x^2 + y0;
fgv_y_fzero = @(theta) fgv_y(theta) - y;

theta0_1 = fzero(fgv_y_fzero, 40);
theta0_2 = fzero(fgv_y_fzero, 50);

s1 = sprintf( 'Hajitasi szog erteke: theta1 = %.2f theta2 = %.3f' , theta0_1, theta0_2);
disp(s1);

%%Megoldas  3 alpont
fgv_y_x_1 = @(x) x.*tand(theta0_1) - g./ (2 * v0.^2 * cosd(theta0_1).^2) *x.^2 + y0;
fgv_y_x_2 = @(x) x.*tand(theta0_2) - g./ (2 * v0.^2 * cosd(theta0_2).^2) *x.^2 + y0;

%%Megoldas 4 alpont
fgv_y_x_1_min = @(x) -fgv_y_x_1(x);
fgv_y_x_2_min = @(x) -fgv_y_x_2(x);

[y1, x1] = fminbnd(fgv_y_x_1_min, 10, 30);
max1 = - x1;
[y2, x2] = fminbnd(fgv_y_x_2_min, 10, 30);
max2 = - x2;

s2 = sprintf( 'Legmagasabb pontok: max1 = %.2f max2 = %.2f' , max1, max2);
disp(s2);

%Megoldas 5 alpont
theta0 = 45; %fok
polinom_y = [ -g/(2*v0.^2*cosd(theta0).^2), tand(theta0), y0];
gyokok = roots(polinom_y)


%Abrazolas
figure(1);
hold ('on');
fplot(fgv_y, [33,55], 'm');
plot([theta0_1, theta0_2], [y,y], 'pk');
hold ('off');
xlabel('\theta (fok)'); ylabel('y (m)');
legend('y=f(\theta_0)')

figure(2);
hold ('on');
fplot(fgv_y_x_1, [0,x], 'y');
fplot(fgv_y_x_2, [0,x], 'r');
plot( [y1, y2],[max1, max2], 'pb');
plot( gyokok(1), y, 'sr', 'MarkerFaceColor', 'r');
plot([ 1,gyokok(1)], [y, y], 'k--');
plot([ gyokok(1),gyokok(1)], [0, y], 'k--');
%fplot(fgv_polinom, gyokok);%??????
hold ('off');
xlabel('x (m)'); ylabel('y (m)');
legend('y1 = f(x1)', 'y2 = f(x2).', 'Max pontok', 'Ekkor jut a felszinre')
axis( [ 0, 44, 0, 15 ] );
