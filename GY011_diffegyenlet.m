clc(), clear(), close('all');

%%Adatok
global tau k cA_be
QV = 0.5; %% mol/min
V = 2.5; % L
k = 0.12; %l/min
cA_be = 2; % mol/L
tau = V / QV;
t_intv = [0, 25];
konc0 = [0, 0, 0, 0];

%%Fuggveny
function dcdt = fgv_cstr( ido, konc );
  global tau k cA_be
  cA1 = konc(1);
  cB1 = konc(2);
  cA2 = konc(3);
  cB2 = konc(4);

  dcA1_dt = (1 / tau) * (cA_be - cA1) - k * cA1;
  dcB1_dt = ((-1) / tau) * cB1 + k * cA1;
  dcC1_dt = (1 / tau) * (cA1 - cA2) - k * cA2;
  dcD1_dt = (1 / tau) * (cB1 - cB2) + k * cA2;

  dcdt = [dcA1_dt, dcB1_dt, dcC1_dt, dcD1_dt];

end

%%Megoldas
[t, c] = ode45( @fgv_cstr, t_intv, konc0 );

%%Abrazolas
cA1 = c(:, 1);
cB1 = c(:, 2);
cA2 = c(:, 3);
cB2 = c(:, 4);

figure(1);
plot(t, cA1,'m', t, cB1, 'r');
xlabel('t(perc)'); ylabel('c(M)');
legend('C_{A1}', 'C_{B1}', 'Location', 'Southeast');

figure(2);
plot(t, cA2, 'b', t, cB2, 'g');
xlabel('t(perc)'); ylabel('c(M)');
legend('C_{A2}', 'C_{B2}', 'Location', 'Southeast');


