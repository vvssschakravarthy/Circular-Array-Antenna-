%MSGOA Code
%[gbest,fmin,convrgnc, SLL, BW]=msgofunction(pn,dim,gn,Lb,Ub)


function[gbest,fit, SLL, BW]=msgofunction(pn,dim,gn,lb,ub,func_no)

%Test_Functions(pop(i,:),func_no,dim);
pop=lb+rand(pn,dim)*(ub-lb);
c=0.2;
for i=1:pn
    f(i)=CAA_A_obj(pop(i,:));
end
[value ibest]=min(f);
% from here iteration start
fit=zeros(gn,1);

%------------------------------------------------------------------------
for g=1:gn
% improvement due to best person of the group
[value ibest]=min(f);
value;
guru=pop(ibest,:);
for i=1:pn
     for j=1:dim
     newpop(i,j)=c*pop(i,j)+rand*(guru(j)-pop(i,j));
          if((newpop(i,j)<lb))
              newpop(i,j)=lb;
          end
          if((newpop(i,j)>ub))
              newpop(i,j)=ub;
          end
     end
%CAA_A_obj(pop(i,:));
f1=CAA_A_obj(newpop(i,:));
       
     if(f1<f(i))
         pop(i,:)=newpop(i,:);
         f(i)=f1;
     end  
end
 [a b]=min(f);
  gpop=pop(b,:);
  SAP=0.7;
             
for i=1:pn
        r1=floor(1+rand*pn);
        while(r1==i)
            r1=floor(1+rand*pn);
        end
        if(f(i)<f(r1))
            if rand>SAP
                 for j=1:dim
                     popnew(i,j)=pop(i,j)+rand*(pop(i,j)-pop(r1,j))+rand*(gpop(j)-pop(i,j));
                     if(popnew(i,j)<lb)
                         popnew(i,j)=lb;
                     end
                     if(popnew(i,j)>ub)
                         popnew(i,j)=ub;
                     end
                 end
            
            else
                 for j=1:dim
                      popnew(i,:)=lb+rand*(ub-lb); 
                 end
            end
        else
            for j=1:dim
                popnew(i,j)=pop(i,j)+rand*(pop(r1,j)-pop(i,j))+rand*(gpop(j)-pop(i,j));
                if(popnew(i,j)<lb)
                     popnew(i,j)=lb;
                end
                if(popnew(i,j)>ub)
                     popnew(i,j)=ub;
                end
            end
        end
end
               
for i=1:pn
%CAA_A_obj
f2(i)=CAA_A_obj(popnew(i,:));   
    if(f2(i)<f(i))
       pop(i,:)=popnew(i,:);
       f(i)=f2(i);
    end 
end
%end of learner phase
[minvalue position]=min(f);
fit(g)=minvalue;
objvalue=fit(g)

   

end
gbest=pop(position,:)
 [OptSLL fnbw]=getInfo(gbest);
    SLL(t)=OptSLL; BW(t)=fnbw;
end
 
 







