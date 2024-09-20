
%% Get performance (hit and FA) for AudGONOGO 

trial = SessionData.TrialTypes;
outcome = SessionData.TrialOutcome; 
ntrial = size (trial); ntrial = ntrial (2);

%        outcome(:,1:50) = [ ];
%       trial(:,1:50) = [ ];
%              outcome(:,300:ntrial) = [ ];
%             trial(:,300:ntrial) = [ ];


NoGo_trial= sum (trial == 1);
Go_trial= sum (trial == 2);



GoHit = trial ==2 & outcome==1; 
GoHit_perc = (sum(GoHit))/Go_trial * 100;
NoGoCR = trial==1 & outcome==3; 
NoGoCR_perc = (sum(NoGoCR))/NoGo_trial*100; 




% Hit = Go_trial & outcome==1; GoHit_perc = (sum(Hit))/sum(Go_trial) * 100;
% NoGoFA = NoGo_trial & outcome == 1 ; NoGoFA_perc = (sum(NoGoFA))/sum(NoGo_trial)*100 ;
% CR = NoGo_trial & outcome==3; NoGoCR_perc = (sum(CR))/sum(NoGo_trial)*100; 
% GoMiss = Go_trial & outcome==3; GoMiss_perc = (sum(GoMiss))/sum(Go_trial)*100;



corr_perc = (GoHit_perc + NoGoCR_perc)/2
% ALL= [GoHit_perc/100;GoMiss_perc/100; NoGoCR_perc/100; NoGoFA_perc/100;]

% AUD GoNoGo x dF.m
% 
% ind_GoHit = find(Hit);
% ind_GoMiss = find(GoMiss);
% ind_NoGoCR = find(CR);
% ind_NoGoFA = find(NoGoFA);
% 
% 
% GoMiss = roimeans(ind_GoMiss);
% GoHit = roimeans(ind_GoHit);
% NoGoCR = roimeans(ind_NoGoCR);
% NoGoFA =  roimeans(ind_NoGoFA);
% 
% for i = 1:size(GoHit,2);  n =  size(GoHit{i},2); GoHit{i}(:,380:n)=[];end
% for i = 1:size(NoGoFA,2);  n =  size(NoGoFA{i},2); NoGoFA{i}(:,380:n)=[];end
% 
%% session binned performance 
% perf={};
% 
% nbins = 30;
% 
% for i = 1:nbins:ntrial
% binned_outcome = outcome(i:(i+nbins));
% binned_trial = trial(i:(i+nbins));
% GoBinTrial = sum(binned_trial == 2);
% NoGoBinTrial = sum(binned_trial ==1);
% Hitb = binned_trial == 2 & binned_outcome==1; Hit_perc = (sum(Hitb))/GoBinTrial;
% CRb = binned_trial == 1 & binned_outcome==3; CR_perc = (sum(CRb))/NoGoBinTrial; 
% binned_perf = (Hit_perc+CR_perc)/2;
% 
% perf{i} = binned_perf;
% 
% % display(i)
% 
% end
% %%
% hold on
% 
% plot(cell2mat(perf),'o-','LineWidth',1);
% 
