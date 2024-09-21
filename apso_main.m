
clear all;close all;clc;
tic;
disp('Circular Array Synthesis Started ------------>');
fileName='apso_8_a.mat';
if (exist('apso_8_a.mat'))
    delete 'apso_8_a.mat';
end
%% Lower and upper bounds
Ndvals=8;
Lb=zeros(1,Ndvals);
Ub=ones(1,Ndvals);
% Default parameters [number of particles, number of iterations]
para=[30 2000 0.99];
tnum=10;
for tr=1:tnum
    % Call the accelerated PSO optimizer
    [gbest,fmin,convrgnc, SLL, BW]=pso_mincon(Lb,Ub,para,tr);
    trConv(tr,:)=convrgnc;
    trGbest(tr,:)=gbest;
    trGbestNorm(tr,:)=gbest/max(gbest);
    trFmin(tr,:)=fmin;
    trSLL(tr,:)=SLL;
    trMeanSLL(tr,:)=mean(SLL);
    trBW(tr,:)=BW;
    [OptSLL, fnbw, fnullDepth]=getInfo( trGbestNorm(tr,:));
    trOptSLL(tr)=OptSLL;
    trFNBW(tr)=fnbw;
    trFNull(tr)=fnullDepth;
    [tr OptSLL fnbw fnullDepth]
    figure(1);
    stem(trOptSLL);
    axis([0 tnum -8 -3]);
    drawnow;
end

ti=toc;
paramMatrix=[trOptSLL' trFNBW' trFNull' trFmin];
bestIndx=find(paramMatrix(:,2)<=80);
allSLL=paramMatrix(bestIndx,1);
bestSLL=min(allSLL); wrstSLL=max(allSLL); meanSLL=mean(allSLL);stdSLL=std(allSLL);
indxSLL=find(paramMatrix(:,1)==bestSLL);
bestSol=trGbest(indxSLL,:);
bestBW=paramMatrix(indxSLL,2);
bestNullDepth=paramMatrix(indxSLL,3);
bestFitness=paramMatrix(indxSLL,4);
save(fileName);
fprintf("\n Best Fitness: %.3f;\n Beam Width: %.2f;\n Best SLL: %.3f;\n Worst SSL: %.3f;\n Mean of SLL: %.3f;\n SD of SLL: %.3f;\n Max First Null Depth: %.3f;\n Best Solution: [%s] \n",bestFitness, bestBW, bestSLL, wrstSLL, meanSLL, stdSLL, bestNullDepth, num2str(bestSol));


% An=bestSol; 
figure;
[AFdB,th] = CAA_A_Func(bestSol);
plot(th,AFdB,'k', 'LineWidth',1.5);
xlabel('\Theta in Degrees','fontsize',14);
ylabel('|E(\Theta)| in dB','fontsize',14);
axis([-180 180 -70 0]);

figure;
plot(trConv(indxSLL,:), '-k', 'LineWidth', 1.5); 
xlabel('Iteration Number'); ylabel('SLL'); title('SLL Convergence');
