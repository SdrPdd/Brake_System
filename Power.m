clear all
close all
clc

%% POWER
%Plot of the power absorbed in the rolling of the tires as the f 
%coefficient of roll resistance varies

%INPUT
% FZr,FZf 
% f è un linspace of roll resistance 
% es. f=linspace(0.01,0.035,5);
% a deceletion 
% v1 initial velocity
FZr=30;
FZf=50;
f=linspace(0.01,0.035,5);
a=3;
v1=20;

v(1)=v1;
tf=v1/a; %braking time
t=linspace(0,tf);
d=ones(1,length(t)); % "auxiliary" vector
i=1:length(t);
pwrollpos(1,:)=FZr*2*f(1)*(v(1)*d-a*t); % 2 back tires
figure(1) % POWER BACK TIRES
plot(t,pwrollpos(1,:),'b')
grid
hold
xlabel(' t (sec) ');
ylabel('Pw roll posterior (watt) ');
title('POWER ABSORBED IN ROLLING BY THE BACK TIRES' );
for k=2:1:length(f)
pwrollpos(k,:)=FZr*2*f(k)*(v(1)*d-a*t);% 2 front tires
plot(t,pwrollpos(k,:),'k');
end
figure(2) % POWER BACK TIRES
pwrollant(1,:)=FZf*f(1)*(v(1)*d-a*t); 
plot(t,pwrollant(1,:),'b');
grid
hold
xlabel(' t (sec) ');
ylabel('Pw roll FRONT (Watt) ');
title('POWER ABSORBED IN ROLLING BY THE FRONT TIRES' );
for k1=2:1:length(f)
pwrollant(k1,:)=FZf*f(k1)*(v(1)*d-a*t);
plot(t,pwrollant(k1,:),'k');
end
figure(3) % TOTAL POWER FRONT+BACK
pwrolltot(1,:)=pwrollpos(1,:)+pwrollant(1,:) ;
plot(t,pwrolltot(1,:),'b');
grid
hold
for k2=2:1:length(f)
pwrolltot(k2,:)=pwrollpos(k2,:)+pwrollant(k2,:) ;
plot(t,pwrolltot(k2,:),'k');
end
xlabel(' t (sec) ');
ylabel('total Pw roll back+front (Watt) ');
title('TOTAL POWER ABSORBED IN ROLLING BY TIRES' );
figure(4) % AVERAGE TOTAL POWER
pwrolltotmed(1)=max(pwrolltot(1,:))*0.5 ;
plot(f(1),pwrolltotmed(1),'ob')
grid
hold
xlabel(' f ');
ylabel('average total Pw roll back+front (Watt) ');
title('Average TOTAL POWER IN TIRES ROLLING' );
for k3=2:1:length(f)
pwrolltotmed(k3)=max(pwrolltot(k3,:))*0.5 ;
plot(f(k3),pwrolltotmed(k3),'ok');
end
Tmed=pwrolltotmed(1,:)
T(:,:)=pwrolltot(:,:)
A=pwrollant(:,:)
P(:,:)=pwrollpos(:,:)