function [SLL fnbw nullDepth]=getInfo(I)
I=I/max(I);
[AFdB,th] = CAA_A_Func(I);

% [slll, sllr, thL, thR, fnbw] = SBN(AFdB,0,th);
[slll, sllr, thL, thR, fnbw, af_nullr, af_nulll]= SBN(AFdB,0,th);
SLL=max(slll,sllr);
nullDepth=max(af_nullr, af_nulll);
