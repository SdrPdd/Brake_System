clear all 
close all
clc

%% FORCES

% INPUT
% m  = vehicle mass         [Kg]
% v1 = initial velocity
% a  = deceleration         [linspace es. a=linspace(1.8,4.5,20)]
% Af = car front area [m^2]
% Cd = drag coefficient 
% lr ,lf , h , haer          [scalar]

% OUTPUT
% v             = velocity as the time varies for a given deceleration
% Faer          = aerodinamic force in t - fixed Cd
% Fzf Fzr       = vertical force on front wheel and back wheel considering the variation
% of the deceleration
% Fzfmed Fzrmed = average values of Fzf and Fzr

m=20000
v1=200
a=linspace(1.8,4.5,20)
Af=52
Cd=0.05
lr=2
lf=3
h=1
hear=0.5


% as many braking times as there are decelerations
tf=(v1*ones(1,length(a)))./a ;

for k=1:length(a),
t(k,:)=linspace(0,tf(k));
end

for k1=1:length(a),
v(k1,:)=v1*ones(1,100)-a(1,k1)*t(k1,:);
Faer(k1,:)=0.5*1.225*Af*Cd*(v(k1,:).^2);
end
figure(1) 
plot(t(1,:),v(1,:))
grid
hold
plot(t(length(a),:),v(length(a),:),'r')
xlabel('time sec ')
ylabel('velocity ms^-1');
legend('a=amin ','a=amax')
title('Velocity through time')
for k2=2:length(a)-1
plot(t(k2,:),v(k2,:),'k')
end
%%%%%
figure(2) 
plot(t(1,:),Faer(1,:))
grid
hold
plot(t(length(a),:),Faer(length(a),:),'r')
xlabel('time s')
ylabel('Faer N ')
title('Aerodynamic resistance over time')
legend('a=amin ','a=amax')
for k3=2:length(a)-1
plot(t(k3,:),Faer(k3,:),'k')
end


%% CALCULATION OF ANTERIOR AND POSTERIOR VERTICAL REACTIONS
g=9.81; % gravity acceleration' ms^-2
for k4=1:length(a)
Fzf(k4,:)=(m*(g*lr*ones(1,100)+a(k4)*h*ones(1,100))-Faer(k4,:)*hear)/(lr+lf);
Fzr(k4,:)=(m*0.5*(-a(k4)*h*ones(1,100)+g*lf*(ones(1,100)))+Faer(k4,:)*hear)/(lr+lf);
Fzfmed(k4)=mean(Fzf(k4,:));
Fzrmed(k4)=mean(Fzr(k4,:));
end

figure(3) 
plot(t(1,:),Fzf(1,:))
grid
hold
plot(t(length(a),:),Fzf(length(a),:),'r')
xlabel('time sec ')
ylabel('Fzf forward N ')
title('Vertical force front wheel')
legend('a=amin ','a=amax')
for k5=2:length(a)-1
plot(t(k5,:),Fzf(k5,:),'k')
end
figure(4) 
plot(t(1,:),Fzr(1,:))
grid
hold
plot(t(length(a),:),Fzr(length(a),:),'r')
xlabel('time sec ')
ylabel('Fzr rearward N ')
title('Vertical force back wheel')
legend('a=amin ','a=amax')
for k6=2:length(a)-1
plot(t(k6,:),Fzr(k6,:),'k')
end