function [gbest,fbest,convrgnc, SLL, BW]=pso_mincon(Lb,Ub,para,tr)

% Populazation size, time steps and gamma
n=para(1); time=para(2); gamma=para(3);
% -----------------------------------------------------------------
%% Scalings
scale=abs(Ub-Lb);
% Validation constraints
if abs(length(Lb)-length(Ub))>0,
    disp('Constraints must have equal size');
    return
end
alpha=0.2; beta=0.5;

%% ------------- Start Particle Swarm Optimization -----------
% generating the initial locations of n particles
best=init_pso(n,Lb,Ub);

fbest=1.0e+100;
% ----- Iterations starts ------
% for t=1:time,
t=1;
while t<=time
    
    % Find which particle is the global best
    for i=1:n,
        fval=CAA_A_obj(best(i,:));
        % Update the best
        if fval<=fbest,
            gbest=best(i,:);
            fbest=fval;
        end
        
    end
    % -----------------------------------------------------------
    % Randomness reduction
    alpha=newPara(alpha,gamma);
    
    % Move all particles to new locations
    best=pso_move(best,gbest,alpha,beta,Lb,Ub);
    
    % Printing to console
    if(mod(t,50)==0)
        [tr t fbest]
    end
    
    convrgnc(t)=fbest;
    t=t+1;
    
    [OptSLL fnbw]=getInfo(gbest);
    SLL(t)=OptSLL; BW(t)=fnbw;
    
end  %%%%% end of main program