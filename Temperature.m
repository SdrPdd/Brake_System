clear all
close all
clc

%% TEMPERATURE
% Maximum temperature that occurs on the disc-lining interface in a single braking
% Plot of the temperature over time during braking as the set deceleration varies


% INPUT
% v1 initial velocity
% a deceleration…. è un linspace
% Ti initial temperature [Celsius]
% tf brake time = v1/a
% gamma parameter that informs us how the heat that develops
% on the disc-lining interface is shared between these
% m vehicle mass [Kg]
% k corrective factor for rotating masses
% rm average or equivalent radius
% R undeformed tire radius
% s coeff.slip ratio
% Afer area swept by lining

% OUTPUT
% T temperature over time
% Tmax maximum braking temperature

v1=20;
a=linspace(1.8,4.5,20);
Ti=30;
tf=v1\a;
gamma=1;
m=800;
k=0.3;
rm=30;
R=40;
s=0.8;
Afer=20;

tf=(v1*ones(1,length(a)))./a ;
for k1=1:length(a)
t(k1,:)=linspace(0,tf(k1));
end
for k2=1:length(a)
v(k2,:)=v1*ones(1,100)-a(1,k2)*t(k2,:);
end

for k3=1:length(a) 
qr0(k3)=(0.5*gamma*k*(1-s)*m*v1*a(1,k3))/Afer ;
end
figure(1)
plot(a,qr0)
grid
xlabel('acceleration ms^-2')
ylabel('qr(0) Wm^-2 Rotor')
title('Wm^-2 rotor ')
for k4=1:length(a) 
T(k4,:)=Ti*ones(1,100)+(8.1264e-005)*qr0(k4)*(t(k4,:).^0.5).*(ones(1,100)-0.6667*(t(k4,:)/tf(k4)));
%Tmax(k4)=Ti*ones(1,length(a))+0.5270*8.1264e-005*tf(k4)*ones(1,length(a))
end
figure(2)
plot(t(1,:),T(1,:))
grid
hold
plot(t(length(a),:),T(length(a),:),'r')
legend('a=amin','a=amax')
for k5=2:length(a)-1
plot(t(k5,:),T(k5,:),'k')
end
xlabel('time s ')
ylabel('temperature Celsius')
title('Temperature trend for single braking')