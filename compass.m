tspan = (0:1:7200); 
p1 = 0.45*101325; %Pressure of CH4
p5 = 0.1*101325; %Pressure of Na
vi = 0.001; %initial volume
R = 8.314; %universal gas constant
T = 973; %Temperature
n1o = (p1*vi)/(R*T); %initial number of moles of CH4
n5o = (p5*vi)/(R*T); %initial number of moles of Na
nin = p1*vi/(R*T); %initial number of moles of inert
ni = n1o+n5o+nin;
z =[n1o 0 0 0 n5o 0 0 0 0 0 0 0 0 0 0 0]; %initial condition
[tspan,n] = ode15s(@odefun,tspan,z);

NA = 6.023E23; %Avagadro Number

% rate constants of forward reactions
kf1 = 1.1*10.^(-8); 
kf2 = 2.2*10.^(9);
kf3 = 1.5*10.^(11);
kf4 = 2.2*10.^(-21)*((10.^(-6)*NA));
kf5 = 3.2*10.^(-22)*((10.^(-6)*NA));
kf6 = 1.0*10.^(-23)*((10.^(-6)*NA));
kf7 = 9.4*10.^(-27)*((10.^(-6)*NA));
kf8 = 2.3*10.^(-23)*((10.^(-6)*NA));
kf9 = 3.1*10.^(-21)*((10.^(-6)*NA));
kf10 = 6.9*10.^(-13)*((10.^(-6)*NA));
kf11 = 9.9*10.^(-24)*((10.^(-6)*NA));
kf12 = 9.5*10.^(9);
kf13 = 8.7*10.^(10);
kf14 = 6.8*10.^(3);
kf15 = 8.4*10.^(5);
kf16 = 7.1*10.^(3);
kf17 = 5.0*10.^(9);
kf18 = 5.8*10.^(8);
kf19 = 4.4*10.^(-1);
kf20 = 1.4*10.^(8);
kf21 = 2.4*10.^(1);
kf22 = 4.7*10.^(6);
kf23 = 1.9*10.^(-10)*((10.^(-6)*NA));
kf24 = 2.8*10.^(-10)*((10.^(-6)*NA));

kf = [kf1 kf2 kf3 kf4 kf5 kf6 kf7 kf8 kf9 kf10 kf11 kf12 kf13 kf14 kf15 kf16 kf17 kf18 kf19 kf20 kf21 kf22 kf23 kf24];

% rate constants of backward reactions
kb1 = 4.1*10.^(-10)*((10.^(-6)*NA));
kb2 = 1.5*10.^(-9);     
kb3 = 4.4*10.^(-9)*((10.^(-6)*NA));
kb4 = 1.9*10.^(-10)*((10.^(-6)*NA));
kb5 = 4.1*10.^(9);   
kb6 = 1.9*10.^(-12)*((10.^(-6)*NA));
kb7 = 6.6*10.^(-11)*((10.^(-6)*NA));
kb8 = 3.9*10.^(2);
kb9 = 4.7*10.^(4);
kb10 = 5.7*10.^(-15)*((10.^(-6)*NA));
kb11 = 3.8*10.^(-19)*((10.^(-6)*NA));
kb12 = 3.3*10.^(-9)*((10.^(-6)*NA));
kb13 = 7.3*10.^(-9)*((10.^(-6)*NA));
kb14 = 3.0*10.^(-9)*((10.^(-6)*NA));
kb15 = 2.3*10.^(-10)*((10.^(-6)*NA));
kb16 = 1.4*10.^(-9)*((10.^(-6)*NA));
kb17 = 1.5*10.^(-9)*((10.^(-6)*NA));
kb18 = 3.1*10.^(-9)*((10.^(-6)*NA));
kb19 = 3.7*10.^(-12)*((10.^(-6)*NA));
kb20 = 5.1*10.^(-10)*((10.^(-6)*NA));
kb21 = 5.0*10.^(-10)*((10.^(-6)*NA));
kb22 = 3.9*10.^(-11)*((10.^(-6)*NA));
kb23 = 1.8*10.^(-10);
kb24 = 2.7*10.^(-4);

kb = [kb1 kb2 kb3 kb4 kb5 kb6 kb7 kb8 kb9 kb10 kb11 kb12 kb13 kb14 kb15 kb16 kb17 kb18 kb19 kb20 kb21 kb22 kb23 kb24];

% Changing reaction rate constants. Given in question increase by 1%
kfnew = 1.01 .* kf; 
keq = kf ./ kb;
kbnew = kf ./ keq;

%total number of moles at time t
nf=n(:,1)+n(:,2)+n(:,3)+n(:,4)+n(:,5)+n(:,6)+n(:,7)+n(:,8)+n(:,9)+n(:,10)+n(:,11)+n(:,12)+n(:,13)+n(:,14)+n(:,15)+n(:,16)+nin;
v = vi*nf/ni;

% 1 = CH4
% 2 = CH3*
% 3 = H*
% 4 = Na2
% 5 = Na
% 6 = Na3
% 7 = NaH
% 8 = HNaCH3
% 9 = Na2H
% 10 = Na2CH3
% 11 = HNa2CH3
% 12 HNa3CH3
% 13 = H2
% 14 = C2H68
% 15 = NaCH3
% 16 = Na3H
r1 = (kf1.*(n(:,1)./v) - kb1.*(n(:,2)./v).*(n(:,3)./v)).*v;
r2 = (kf2.*(n(:,4)./v) - kb2.*((n(:,5)./v).*(n(:,5)./v))).*v;
r3 = (kf3.*(n(:,6)./v) - kb3.*(n(:,4)./v).*(n(:,5)./v)).*v;
r4 = (kf4.*(n(:,1)./v).*(n(:,5)./v) - kb4.*(n(:,7)./v).*(n(:,2)./v)).*v;
r5 = (kf5.*(n(:,1)./v).*(n(:,5)./v) - kb5.*(n(:,8)./v)).*v;
r6 = (kf6.*(n(:,1)./v).*(n(:,4)./v) - kb6.*(n(:,9)./v).*(n(:,2)./v)).*v;
r7 = (kf7.*(n(:,1)./v).*(n(:,4)./v) - kb7.*(n(:,10)./v).*(n(:,3)./v)).*v;
r8 = (kf8.*(n(:,1)./v).*(n(:,4)./v) - kb8.*(n(:,11)./v)).*v;
r9 = (kf9.*(n(:,1)./v).*(n(:,6)./v) - kb9.*(n(:,12)./v)).*v;
r10 = (kf10.*(n(:,1)./v).*(n(:,3)./v) - kb10.*(n(:,2)./v).*(n(:,13)./v)).*v;
r11 = (kf11.*(n(:,1)./v).*(n(:,2)./v) - kb11.*(n(:,14)./v).*(n(:,3)./v)).*v;
r12 = (kf12.*(n(:,8)./v) - kb12.*(n(:,15)./v).*(n(:,3)./v)).*v;
r13 = (kf13.*(n(:,8)./v) - kb13.*(n(:,7)./v).*(n(:,2)./v)).*v;
r14 = (kf14.*(n(:,7)./v) - kb14.*(n(:,5)./v).*(n(:,3)./v)).*v;
r15 = (kf15.*(n(:,15)./v) - kb15.*(n(:,5)./v).*(n(:,2)./v)).*v;
r16 = (kf16.*(n(:,9)./v) - kb16.*(n(:,4)./v).*(n(:,3)./v)).*v;
r17 = (kf17.*(n(:,9)./v) - kb17.*(n(:,5)./v).*(n(:,7)./v)).*v;
r18 = (kf18.*(n(:,10)./v) - kb18.*(n(:,4)./v).*(n(:,2)./v)).*v;
r19 = (kf19.*(n(:,10)./v) - kb19.*(n(:,5)./v).*(n(:,15)./v)).*v;
r20 = (kf20.*(n(:,16)./v) - kb20.*(n(:,4)./v).*(n(:,7)./v)).*v;
r21 = (kf21.*(n(:,16)./v) - kb21.*(n(:,6)./v).*(n(:,3)./v)).*v;
r22 = (kf22.*(n(:,16)./v) - kb22.*(n(:,9)./v).*(n(:,5)./v)).*v;
r23 = ((kf23.*(n(:,3)./v).*(n(:,3)./v)) - kb23.*(n(:,13)./v)).*v;
r24 = ((kf24.*(n(:,2)./v).*(n(:,2)./v)) - kb24.*(n(:,14)./v)).*v;

%rates of individual components
d1dt = -r1-r4-r5-r6-r7-r8-r9-r10-r11;
d2dt = r1+r4+r6+r10-r11+r13+r15+r18-(2*r24);
d3dt = r1+r7-r10+r11+r12+r14+r16+r21-(2*r23);
d4dt = (-2*r2)+r3-r6-r7-r8+r16+r18+r20;
d5dt = (2*r2)+r3-r4-r5+r14+r15+r17+r19+r22;
d6dt = -r3-r9+r21;
d7dt = r4+r13-r14+r17+r20;
d8dt = r5-r12-r13;
d9dt = r6-r16-r17+r22;
d10dt = r7-r18-r19;
d11dt = r8;
d12dt = r9;
d13dt = r10+(r23);
d14dt = r11+(r24);
d15dt = r12-r15+r19;
d16dt = -r20-r21-r22; 

% Calculate the degree of rate control
x1= (-kfnew(1).*(n(:,1)./v) + kbnew(1).*(n(:,2)./v).*(n(:,3)./v)).*(v./d1dt);
x2=0;
x3=0;
x4=(-kfnew(4).*(n(:,1)./v).*(n(:,5)./v) + kbnew(4).*(n(:,7)./v).*(n(:,2)./v)).*(v./d1dt);
x5=(-kfnew(5).*(n(:,1)./v).*(n(:,5)./v) + kbnew(5).*(n(:,8)./v)).*(v./d1dt);
x6=(-kfnew(6).*(n(:,1)./v).*(n(:,4)./v) + kbnew(6).*(n(:,9)./v).*(n(:,2)./v)).*(v./d1dt);
x7=(-kfnew(7).*(n(:,1)./v).*(n(:,4)./v) + kbnew(7).*(n(:,10)./v).*(n(:,3)./v)).*(v./d1dt);
x8=(-kfnew(8).*(n(:,1)./v).*(n(:,4)./v) + kbnew(8).*(n(:,11)./v)).*(v./d1dt);
x9=(-kfnew(9).*(n(:,1)./v).*(n(:,6)./v) + kbnew(9).*(n(:,12)./v)).*(v./d1dt);
x10=(-kfnew(10).*(n(:,1)./v).*(n(:,3)./v) + kbnew(10).*(n(:,2)./v).*(n(:,13)./v)).*(v./d1dt);
x11=(-kfnew(11).*(n(:,1)./v).*(n(:,2)./v) + kbnew(11).*(n(:,14)./v).*(n(:,3)./v)).*(v./d1dt);
disp(size(tspan));
disp(size(n));

t1 = 0:1:14;

% Plot CH4 concentration
figure
plot(tspan,n(:,1))
title('Conc. vs Time plot of CH4 at 973K');
xlabel('time_t');
ylabel('moles of CH4');

% Sensitivity analysis plot
figure
plot(t1,x1(1:15))
hold on
plot(t1,x4(1:15),'Red')
plot(t1,x5(1:15),'Green')
plot(t1,x6(1:15))
plot(t1,x7(1:15))
plot(t1,x8(1:15))
plot(t1,x9(1:15))
plot(t1,x10(1:15))
plot(t1,x11(1:15))
xlabel('Time(s)')
ylabel('X')
legend('R1','R4','R5','R6','R7','R8','R9','R10','R11')
title('Sensitivity Analysis')

