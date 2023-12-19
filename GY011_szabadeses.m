clc(), clear(), close('all');

%%Adatok
global g k m
m = 90; %kg
A = 0.7; %m^2
g = 9.81; %m/s^2
x0 = 0; %m
v0 = 0; %m/s
suruseg = 0.99; % kg/m^3
Cd = 1;
k = 1/2 * suruseg * A * Cd;
t_intv = [0, 20]; %s

%%Fuggveny
function eredm = szabadeses(t,y)
  global g k m
  x = y(1);
  v = y(2);
  %y1 - ut = x, y2 - v = sebesseg
  dxdt = v;
  dvdt = g - k./m * v^2;

  eredm = [dxdt; dvdt];
end

%%Megoldas
[ido, megoldas] = ode45( @szabadeses, t_intv, [x0, v0]);
ut = megoldas(:, 1);
sebesseg = megoldas(:, 2);

%%Abrazolas
figure(1);
plot(ido, sebesseg, 'g');
xlabel('t(s)'); ylabel('v(m/s)');

figure(2);
plot(ido, ut, 'm');
xlabel('t(s)'); ylabel('x(m)');
