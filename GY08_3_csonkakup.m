clc(), clear(), close('all');

%%Adatok
global V
V = 50; %m^3
R1_intv = [0.5, 3];

%%Fuggveny
function S = csonkakup(R1)
  global V
  R2 = 2*R1;
  h = (3*V / pi) ./(R1.^2 + R2.^2 + R1 + R2);
  S = pi*(R1 + R2).*sqrt((R1 - R2).^2 + h.^2) + pi*(R1.^2 + R2.^2);

end
%%Megoldas - minimumkereses
[R1min, S1min]= fminbnd(@csonkakup, 1, 1.5)

%%Abrazolas
fplot(@csonkakup, R1_intv, 'Color', "#860A35");
hold on;
plot(R1min, S1min, 'pr');
hold off;
xlabel( 'R_1 (m)'); ylabel('S (m^2)');

