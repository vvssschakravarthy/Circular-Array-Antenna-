function fitness=CAA_A_obj(I)
SLLdes=10;BWdes=80;nullDepth=50;
[AFdB,th] = CAA_A_Func(I);

% [slll, sllr, thL, thR, fnbw] = SBN(AFdB,0,th);
[slll, sllr, thL, thR, fnbw, af_nullr, af_nulll]= SBN(AFdB,0,th);

SLL=max(slll,sllr);
f1=SLLdes-abs(SLL);
f2=abs(BWdes-fnbw);
% f3=abs(nullDepth-abs(max(af_nullr,af_nulll)));

% f1=1-(abs(SLL)/SLLdes);
% f2=abs(1-(fnbw/BWdes));
if f2<0
    f2=0;
end
% f3=1-(abs(max(af_nullr,af_nulll))/nullDepth);
% if f3<0
%     f3=0;
% end
fitness=1.5*f1+f2;
