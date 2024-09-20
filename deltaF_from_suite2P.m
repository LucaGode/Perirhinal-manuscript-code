
%% 
%calc dff

freqAcq = 30;                         %freq of acquisition
preStim = 4;                          % define duration of baseline/prestim
stimOn = round(freqAcq * preStim); 
nRois = size(dffmat,2); 
nTrials= size(dffmat{1},1);
     
 framecut = 30;

  
  
   for j = 1:nRois
       
    for t = 1:nTrials;   
    
       
    ftrace = dffmat{1,j}{t,1};   
    ftrace(1:framecut) = []; 
   
    fo = double(median(ftrace(1:stimOn)));    
    df = double(ftrace - fo);

    dff= sgolayfilt((df./fo),1,13);    %   (df./fo);%             %calculates df/f and apply smoothing filter
    
                   %structure with all the traces: column are Rois, rows are trials
     dffmat2{t} = dff; 
    end
     all_dffmat{j}= dffmat2';
   end
   
%% plot

for j= 1:nRois
    figure(j);
    for t = 1:nTrials;
        plot((all_dffmat{1,j}{t,1}),'Color','b','LineWidth',1.5 );    

        hold on;
    end;
end

    
%     plot(mean_map,'Color','r','LineWidth',2)
    
%     xbars= [60 75];%; 180 195 210 225 240 255 270 285]; % Define onset and offset of the stimulus . 
%          patch([xbars(1) xbars(1), xbars(2) xbars(2)], [min(-0.5) max(2) max(2) min(-0.5)], [0 0 0],'LineStyle','none','FaceAlpha',0.25);
         %axis([0 210 -2 120 ]);
% end
 
%% perf behavior and sort trials type
trial = SessionData.TrialTypes;
outcome = SessionData.TrialOutcome; 
ntrial = size (trial,2);

Aud_trial= sum (trial == 1);
Tac_trial= sum (trial == 2);
AudTac_trial = sum(trial == 3);


TacHit = trial ==2 & outcome==1; 
TacHit_perc = (sum(TacHit))/Tac_trial * 100
AudCR = trial ==1 & outcome==3; 
AudCR_perc = (sum(AudCR))/Aud_trial*100; 
TacMiss = trial ==2 & outcome==3;

ind_TacHit = find(TacHit)';
ind_AudCR = find(AudCR)';
ind_TacMiss = find(TacMiss)';

%% TacMiss trials

u =(1:size(ind_TacMiss))';
refind_TacMiss = [ind_TacMiss u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_TacMiss,1)       
     k = refind_TacMiss(i, 1);     
  TacMiss_trial = all_dffmat{1,j}{i,1};
  TacMiss_DF{i} = TacMiss_trial; 
 end
  allTacMiss_DF{:,j} = (TacMiss_DF);
end

nTrials=size(refind_TacMiss,1);

for j = 1:nRois
  for i = 1 : nTrials;
     Miss_dfmat{i,j} = (allTacMiss_DF{1,j}{1,i});   
  end 
end
  
%% TacHit
u =(1:size(ind_TacHit))';
refind_TacHit = [ind_TacHit u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_TacHit,1)       
     k = refind_TacHit(i, 1);     
  TacHit_trial = all_dffmat{1,j}{i,1};
  TacHit_DF{i} = TacHit_trial; 
 end
  allTacHit_DF{:,j} = (TacHit_DF);
end

nTrials=size(refind_TacHit,1);

for j = 1:nRois
  for i = 1 : nTrials;
     Hit_dfmat{i,j} = (allTacHit_DF{1,j}{1,i});   
  end 
end

%% AudCR

u =(1:size(ind_AudCR))';
refind_AudCR = [ind_AudCR u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_AudCR,1)       
     k = refind_AudCR(i, 1);     
  AudCR_trial = all_dffmat{1,j}{i,1};
  AudCR_DF{i} = AudCR_trial; 
 end
  allAudCR_DF{:,j} = (AudCR_DF);
end

nTrials=size(refind_AudCR,1);

for j = 1:nRois
  for i = 1 : nTrials;
     AudCR_dfmat{i,j} = (allAudCR_DF{1,j}{1,i});   
  end 
end

%% plot

df2plot = Miss_dfmat;

for j= 1:nRois
    figure(j);
    for t = 1:nTrials;
        plot(df2plot{j,t},'Color','b','LineWidth',1.5 );    
        hold on;
    end;  
end

%% save and export 

% save(AudCR_dfmat);
% 
% save(Hit_dfmat);
% 
% save(Miss_dfmat);

