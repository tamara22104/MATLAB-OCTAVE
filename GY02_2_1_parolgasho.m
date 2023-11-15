clc ( ), clear ( ), close ( 'all' )

%% Adatok
global A B C D E R Tc
A = 6.1687 ; B = 7.2719 ; C = -4.8247 ; D = 1.379 ; E = 0.97596;
Tc = 562.1; %%Kelvin
homerseklet = [ 350, 450 ];
R = 8.314; %% J* K-1*mol-1

%%Fuggveny
function H_vap = parolgasho(T)
  global A B C D E R Tc
  tau = 1 - T / Tc ; %%nevezoben egy szam van
  H_vap = R * Tc .* ( A * tau .^ (1 ./3) + B * tau .^ (2 ./3) + C * tau + D * tau .^ 2 + E * tau .^ 6) ; %% J/mol

end
%%Abrazolas
figure ( 'Name', 'Benzol parolgasho valtozasa' )
fplot ( @parolgasho, homerseklet, 'b-');
xlabel ( 'T(K) ');
ylabel ( 'H_{vap} (J/mol)');
legend ( 'parolgasho' )

