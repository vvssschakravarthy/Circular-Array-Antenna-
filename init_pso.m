function [guess]=init_pso(n,Lb,Ub)
ndim=length(Lb);
for i=1:n,
guess(i,1:ndim)=Lb+rand(1,ndim).*(Ub-Lb);
end