% CAA with uniform amplitude distribution :: Suitable for Amp Only
% Technique
function [AFdB,th] = CAA_A_Func(I)
sigdir=0;
I=I/max(I);
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