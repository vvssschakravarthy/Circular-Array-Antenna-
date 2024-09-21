% CAA with uniform amplitude distribution :: Suitable for Amp Only
% Technique
clear all;
clc;
I=ones(1,10);
I=[0.9575, 0.5494, 0.4715, 0.9506, 0.2878, 0.9920, 0.4238, 0.5015, 1.0000, 0.3137];

sigdir=0;
N=length(I);
phnn1=zeros(1,N);
phnn=deg2rad(phnn1);
arc_len=0.50;
rad=arc_len/deg2rad(360/N);
ka=2*pi*rad;
th=linspace(-180,180,3601);
theta=deg2rad(th);
phi0=deg2rad(0);

af=0;
for n=1:N
        phin(n) = 2*pi*(n)/N;
        AF=I(n).*exp(1i*(ka.*( cos(theta-phin(n))-cos(phi0-phin(n)) )+ (phnn(n)) )   );   % This expression is correct.
        af=af+AF;
end 
AF=af./max(af);
AF=abs(AF);
AFdB=20*log10(AF);

plot(th,AFdB,'k', 'LineWidth',1.5);
xlabel('\Theta in Degrees','fontsize',14);
ylabel('|E(\Theta)| in dB','fontsize',14);
axis([-180 180 -50 0]);

[slll, sllr, thL, thR, fnbw] = SBN(AFdB,0,th)
