clc(), clear(), close('all');

fuggv1 = @ (x)cos(3*pi*x)./x;
fuggv2 = @ (x) (-1)*fuggv1;
fplot(fuggv1, [0.1,1.1]);
min1 = fminbnd(fuggv1, 0.1, 1.1);
[x1,y2] = fminbnd(fuggv2, 0.4,0.9);

hold('on');
fplot(fuggv1, [0.1,1.1]);
fplot(fuggv2, [0.1,1.1]);
plot(x2, -y2, 'k^');
hold('off');
legend('f(x)', '-f()', 'max');

%%KERDOJEL NEM TUDOM MI VAN ITTTTT?????
