clc(), clear(), close('all')

global KC1 KC2 cA0 cB0 cC0 cD0 cE0
KC1 = 2.667; KC2 = 3.20;
cA0 = 2.0; cB0 = 1.0; %mol/L
cC0 = 0; cD0 = 0; cE0 = 0;

function egyenletek = fgv_egyensuly( bemenet )
  global KC1 KC2 cA0 cB0 cC0 cD0 cE0

  x1 = bemenet( 1 );
  x2 = bemenet( 2 );

  e1 = KC1 * (cA0 - x1 - 0.5 * x2) * (cB0 - x1) - (cC0 + x1 - 0.5 * x2) * (cD0 + x1);
  e2 = KC2 * (cA0 - x1 - 0.5 * x2) * (cC0 + x1 - 0.5 * x2) - (cE0 + x2).^2;
  egyenletek = [e1, e2];

end

%Megoldas
kezd_ertek = [0.5, 1]; %x1 = 0.5, x2 = 1
eredm = fsolve( @fgv_egyensuly, kezd_ertek );

x1 = eredm(1); x2 = eredm(2);
cAe = cA0 - x1 - 0.5 * x2;
cBe = cB0 - x1;
cCe = cC0 + x1 - 0.5 * x2;
cDe = cD0 + x1;
cEe = cE0 + x2;

pie( [cAe, cBe, cCe,cDe, cEe] );
legend('cAe', 'cBe', 'cCe','cDe', 'cEe');

