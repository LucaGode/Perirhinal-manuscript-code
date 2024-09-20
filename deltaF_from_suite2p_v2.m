% dffmat = m9_dffmat; 
%%

freqAcq = 30;                         %freq of acquisition
preStim = 2;                          % define duration of baseline/prestim
stimOn = round(freqAcq * preStim); 
nRois = size(dffmat,2); 
nTrials= size(dffmat{1},1);
     
  framecut = 30;
  
   for j = 1:nRois
       
    for t = 1:nTrials;   
    
       
    ftrace = dffmat{1,j}{t,1};   
if size(ftrace,2) > 2
    ftrace(1:framecut) = [];

   
    fo = double(median(ftrace(1:stimOn)));    
    df = double(ftrace - fo);

    dff= sgolayfilt((df./fo),1,13);    %   (df./fo);%             %calculates df/f and apply smoothing filter
    
                   %structure with all the traces: column are Rois, rows are trials
     dffmat2{t} = dff;
     

end
    end
     all_dffmat{j}= dffmat2';
   end
%%
trial = SessionData.TrialTypes;

outcome = SessionData.TrialOutcome; 

ntrial = size (trial); ntrial = ntrial (2);
% % 
%  cut = 20;
%  outcome(:,1:cut) = [ ];
%  trial(:,1:cut) = [ ];
%  outcome(:,(size(outcome,2)- cut):(size(outcome,2))) = [ ];
%  trial(:,(size(outcome,2)- cut):(size(outcome,2))) = [ ];

d_plus10_trial= sum(trial == 1);
d_plus6_trial = sum(trial == 2);
d_plus3_trial = sum(trial == 3);
% d_0_trial = sum(trial == 4);
d_minus3_trial = sum(trial == 5);
d_minus6_trial = sum(trial == 6);
d_minus10_trial= sum(trial == 7);  

% 
% d_plus10 = trial == 1 & outcome == 1; ind_d_plus10= find(d_plus10)';
% d_plus6 = trial == 2 & outcome == 1; ind_d_plus6= find(d_plus6)';
% d_plus3 = trial == 3 & outcome == 1; ind_d_plus3= find(d_plus3)';
% d_plus3miss = trial == 3 & outcome == 3; ind_d_plus3miss= find(d_plus3miss)';
% 
% d_minus3fa = trial == 5 & outcome == 1; ind_d_minus3fa= find(d_minus3fa)';
% d_minus3 = trial == 5 & outcome == 3; ind_d_minus3= find(d_minus3)';
% d_minus6 = trial == 6 & outcome == 3; ind_d_minus6= find(d_minus6)';
% d_minus10 = trial == 7 & outcome == 3; ind_d_minus10= find(d_minus10)';
% % 
 d_plus10 = trial == 1; ind_d_plus10= find(d_plus10)';
 d_plus6 = trial == 2; ind_d_plus6= find(d_plus6)';
 d_plus3 = trial == 3; ind_d_plus3= find(d_plus3)';
 
 d_minus3 = trial == 5; ind_d_minus3= find(d_minus3)';
 d_minus6 = trial == 6; ind_d_minus6= find(d_minus6)';
 d_minus10 = trial == 7; ind_d_minus10= find(d_minus10)';


%%
%% d_plus10 (GoHit)
u =(1:size(ind_d_plus10))';
refind_d_plus10 = [ind_d_plus10 u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_d_plus10,1)       
     k = refind_d_plus10(i, 1);     
  d_plus10_trial = all_dffmat{1,j}{k,1};
  d_plus10_DF{i} = d_plus10_trial; 
 end
  alld_plus10_DF{:,j} = (d_plus10_DF);
end

nTrials=size(refind_d_plus10,1);

for j = 1:nRois
  for i = 1 : nTrials;
     plus10_dfmat{i,j} = (alld_plus10_DF{1,j}{1,i});   
  end 
end

%%
%% d_plus6 (Hit)
u =(1:size(ind_d_plus6))';
refind_d_plus6 = [ind_d_plus6 u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_d_plus6,1)       
     k = refind_d_plus6(i, 1);     
  d_plus6_trial = all_dffmat{1,j}{k,1};
  d_plus6_DF{i} = d_plus6_trial; 
 end
  alld_plus6_DF{:,j} = (d_plus6_DF);
end

nTrials=size(refind_d_plus6,1);

for j = 1:nRois
  for i = 1 : nTrials;
     plus6_dfmat{i,j} = (alld_plus6_DF{1,j}{1,i});   
  end 
end

%%
%% d_plus3 (Hit)
u =(1:size(ind_d_plus3))';
refind_d_plus3 = [ind_d_plus3 u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_d_plus3,1)       
     k = refind_d_plus3(i, 1);     
  d_plus3_trial = all_dffmat{1,j}{k,1};
  d_plus3_DF{i} = d_plus3_trial; 
 end
  alld_plus3_DF{:,j} = (d_plus3_DF);
end

nTrials=size(refind_d_plus3,1);

for j = 1:nRois
  for i = 1 : nTrials;
     plus3_dfmat{i,j} = (alld_plus3_DF{1,j}{1,i});   
  end 
end

% %% MISS d_plus3 (Hit)
% u =(1:size(ind_d_plus3miss))';
% refind_d_plus3miss = [ind_d_plus3miss u];
% % dfmat = zeros(size(ind_TacMiss,1), nRois);
% 
% for j = 1:nRois    
%  for i = 1 : size(refind_d_plus3miss,1)       
%      k = refind_d_plus3miss(i, 1);     
%   d_plus3miss_trial = all_dffmat{1,j}{k,1};
%   d_plus3miss_DF{i} = d_plus3miss_trial; 
%  end
%   alld_plus3miss_DF{:,j} = (d_plus3miss_DF);
% end
% 
% nTrials=size(refind_d_plus3miss,1);
% 
% for j = 1:nRois
%   for i = 1 : nTrials;
%      plus3miss_dfmat{i,j} = (alld_plus3miss_DF{1,j}{1,i});   
%   end 
% end
%% d_minus3 (CR)
u =(1:size(ind_d_minus3))';
refind_d_minus3 = [ind_d_minus3 u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_d_minus3,1)       
     k = refind_d_minus3(i, 1);     
  d_minus3_trial = all_dffmat{1,j}{k,1};
  d_minus3_DF{i} = d_minus3_trial; 
 end
  alld_minus3_DF{:,j} = (d_minus3_DF);
end

nTrials=size(refind_d_minus3,1);

for j = 1:nRois
  for i = 1 : nTrials;
     minus3_dfmat{i,j} = (alld_minus3_DF{1,j}{1,i});   
  end 
end

% %% FA d_minus3 (CR)
% u =(1:size(ind_d_minus3fa))';
% refind_d_minus3fa = [ind_d_minus3fa u];
% % dfmat = zeros(size(ind_TacMiss,1), nRois);
% 
% for j = 1:nRois    
%  for i = 1 : size(refind_d_minus3fa,1)       
%      k = refind_d_minus3fa(i, 1);     
%   d_minus3fa_trial = all_dffmat{1,j}{k,1};
%   d_minus3fa_DF{i} = d_minus3fa_trial; 
%  end
%   alld_minus3fa_DF{:,j} = (d_minus3fa_DF);
% end
% 
% nTrials=size(refind_d_minus3fa,1);
% 
% for j = 1:nRois
%   for i = 1 : nTrials;
%      minus3fa_dfmat{i,j} = (alld_minus3fa_DF{1,j}{1,i});   
%   end 
% end
%% d_minus6 (CR)
u =(1:size(ind_d_minus6))';
refind_d_minus6 = [ind_d_minus6 u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_d_minus6,1)       
     k = refind_d_minus6(i, 1);     
  d_minus6_trial = all_dffmat{1,j}{k,1};
  d_minus6_DF{i} = d_minus6_trial; 
 end
  alld_minus6_DF{:,j} = (d_minus6_DF);
end

nTrials=size(refind_d_minus6,1);

for j = 1:nRois
  for i = 1 : nTrials;
     minus6_dfmat{i,j} = (alld_minus6_DF{1,j}{1,i});   
  end 
end
%% d_minus10 (NoGoCR)
u =(1:size(ind_d_minus10))';
refind_d_minus10 = [ind_d_minus10 u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_d_minus10,1)       
     k = refind_d_minus10(i, 1);     
  d_minus10_trial = all_dffmat{1,j}{k,1};
  d_minus10_DF{i} = d_minus10_trial; 
 end
  alld_minus10_DF{:,j} = (d_minus10_DF);
end

nTrials=size(refind_d_minus10,1);

for j = 1:nRois
  for i = 1 : nTrials;
     minus10_dfmat{i,j} = (alld_minus10_DF{1,j}{1,i});   
  end 
end

%%
%% plot

%  df2plot = plus10_dfmat;
% hold on
% for j= 1:nRois
%     figure(j);
%     for i = 1:nTrials;
%         plot(df2plot{i,j},'Color','r','LineWidth',1.5 );    
%         hold on;
%     end;  
% end
%%
% framecut = 169;       % set from where (starting from which frame) it cuts
% nRois = size(df2plot,2); 
% nTrials = size(df2plot,1); 
% nFrames =  size(df2plot{1},2); 
%  
% 
%     for i = 1:nTrials
%         for j = 1:nRois;  
%             n =  size(df2plot{i,j},2);
%            df2plot{i,j}(:,framecut:n)=[];
%         end
%     end  
%     
%    nFrames =  size(df2plot{1},2);  
% %%
%  for j = 1:nRois;
%  f=figure(j);
% hold on;
% all_trial = zeros(nTrials, nFrames); 
%           for  i = 1:nTrials; 
%               single_trial = df2plot{i,j}; 
%               all_trial(i,:) = single_trial;
%           end;
%           
% avg_all_Roi_trace = (mean(all_trial));
% shadedErrorBar([],avg_all_Roi_trace, std((all_trial))/sqrt(size(((all_trial)),1)),'red',1);
% u=f.Renderer
% f.Renderer = 'painters'
% set(gca,'XTick',0:30:nFrames+30);
% set(gca,'XTickLabel',0:1:nFrames/30+30);
%  axis([0 200 -0.5 3]);
% % 
%  end

