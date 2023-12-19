clc(), clear(), close('all');

%%Adatok
h0 = 5.9; %m
a = 1.5;%m
b = 4.0;%m
c = 3.0;%m
r = 2.5E-02; %m
g = 9.81; %m/s^2
t0 = 0; %s
tv = 5650; %s

%%Megoldas
dhdt = @(t, h) (r ^ 2 * sqrt(2*g*h))./ (a * b * (-1 + ((h-c).^2)./(c^2)));

[ido, magassag] = ode45( dhdt, [t0, tv], h0);

%%Abrazolas
plot(ido, magassag, 'b');
xlabel('t(s)');
ylabel('h(m)');




