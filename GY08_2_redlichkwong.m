clc(), clear(), close('all');

%%Adatok
pC = 4600; %kPa
TC = 191; %K
R = 8.31446; %kJ/(kg K)
T = -40 + 273.15; %K
p = 65000; %kPa
V_tartaly = 3 %m^3
M_CH4 = 16.04; % kg/kmol CH4

a = 0.42748* R^2 * TC^2.5 ./pC;
b = 0.0866* R * TC ./pC;

fgv_p = @ (Vm) R*T ./ (Vm-b) - a./(Vm .* (Vm + b)* sqrt(T));

Vm_realis = R * T/p; %%kezetibecsles
fgv_p_fzero = @ (Vm) R*T  - a*(Vm - b)./ (Vm .* (Vm + b)* sqrt(T)) - p*(Vm - b);
Vm = fzero(fgv_p_fzero, Vm_realis);

m_CH4 = M_CH4 * V_tartaly/Vm;

%%Polinom
polinom_RK = [1, ]

%%Abrazolas
%%fplot(fgv_p, [0.01, 0.05]);

