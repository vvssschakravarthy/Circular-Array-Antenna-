function ns=pso_move(best,gbest,alpha,beta,Lb,Ub)
% This scale is important as it increases the mobility of particles
n=size(best,1); ndim=size(best,2);
scale=(Ub-Lb);
for i=1:n,
ns(i,:)=best(i,:)+beta*(gbest-best(i,:))+alpha.*randn(1,ndim).*scale;
end
ns=findrange(ns,Lb,Ub);