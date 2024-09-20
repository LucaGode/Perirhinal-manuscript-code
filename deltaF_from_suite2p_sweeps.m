%% calc dff

freqAcq = 30;                         %freq of acquisition
preStim = 10;                          % define duration of baseline/prestim
stimOn = round(freqAcq * preStim); 
nRois = size(dffmat,2); 
nTrials= size(dffmat{1},1);
     
%framecut = 30;    % Sometimes I cut the first 30 frames of each trials cause weird stuff can happen there

   for j = 1:nRois
       
    for t = 1:nTrials;   
        
    ftrace = dffmat{1,j}{t,1};   
  if size(ftrace,2) > 2
    ftrace(1:framecut) = [];
   
    fo = double(median(ftrace(1:stimOn)));    
    df = double(ftrace-fo);

    dff= sgolayfilt((df./fo),1,13);    %   (df./fo);%             %calculates df/f and apply smoothing filter    
                   %structure with all the traces: column are Rois, rows are trials
    dffmat2{t} = dff; 
end
     end
    all_dffmat{j}= dffmat2';
   end
  
 %% plot
% 
% for j= 1:nRois
%     figure(j);
%     for t = 1:nTrials;
%         plot((all_dffmat{1,j}{t,1}),'Color','b','LineWidth',1.5 );    
% 
%         hold on;
%     end;
% end

    
%     plot(mean_map,'Color','r','LineWidth',2)
    
%     xbars= [60 75];%; 180 195 210 225 240 255 270 285]; % Define onset and offset of the stimulus . 
%          patch([xbars(1) xbars(1), xbars(2) xbars(2)], [min(-0.5) max(2) max(2) min(-0.5)], [0 0 0],'LineStyle','none','FaceAlpha',0.25);
         %axis([0 210 -2 120 ]);
% end
 
%% perf behavior and sort trials type
trial = SessionData.TrialTypes;
trial(r) = [];
outcome = SessionData.TrialOutcome; 
outcome(r)=[];
ntrial = size (trial); ntrial = ntrial (2);

NoGo_trial= sum (trial == 1);
Go_trial= sum (trial == 2);



GoHit = trial ==2 & outcome==1; 
GoHit_perc = (sum(GoHit))/Go_trial * 100;
NoGoCR = trial==1 & outcome==3; 
NoGoCR_perc = (sum(NoGoCR))/NoGo_trial*100; 
GoMiss = trial==2 & outcome==3;
NoGoFa = trial==1 & outcome==0;

ind_GoHit = find(GoHit)';
ind_NoGoCR = find(NoGoCR)';
ind_GoMiss = find(GoMiss)';
ind_NoGoFa = find(NoGoFa)';

% GoHit = trial ==2 ;
% NoGoCR = trial==1 ;
% 
% 
% ind_GoHit = find(GoHit)';
% ind_NoGoCR = find(NoGoCR)';


%% GoMiss trials

u =(1:size(ind_GoMiss))';
refind_GoMiss = [ind_GoMiss u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_GoMiss,1)       
     k = refind_GoMiss(i, 1);     
  GoMiss_trial = all_dffmat{1,j}{k,1};
  GoMiss_DF{i} = GoMiss_trial; 
 end
  allGoMiss_DF{:,j} = (GoMiss_DF);
end

nTrials=size(refind_GoMiss,1);

for j = 1:nRois
  for i = 1 : nTrials;
     Miss_dfmat{i,j} = (allGoMiss_DF{1,j}{1,i});   
  end 
end
 
%% NoGoFA
u =(1:size(ind_NoGoFa))';
refind_NoGoFa = [ind_NoGoFa u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_NoGoFa,1)       
     k = refind_NoGoFa(i, 1);     
  NoGoFa_trial = all_dffmat{1,j}{k,1};
  NoGoFa_DF{i} = NoGoFa_trial; 
 end
  allNoGoFa_DF{:,j} = (NoGoFa_DF);
end

nTrials=size(refind_NoGoFa,1);

for j = 1:nRois
  for i = 1 : nTrials;
     Fa_dfmat{i,j} = (allNoGoFa_DF{1,j}{1,i});   
  end 
end

  
%% GoHit
u =(1:size(ind_GoHit))';
refind_GoHit = [ind_GoHit u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_GoHit,1)       
     k = refind_GoHit(i, 1);     
  GoHit_trial = all_dffmat{1,j}{k,1};
  GoHit_DF{i} = GoHit_trial; 
 end
  allGoHit_DF{:,j} = (GoHit_DF);
end

nTrials=size(refind_GoHit,1);

for j = 1:nRois
  for i = 1 : nTrials;
     Hit_dfmat{i,j} = (allGoHit_DF{1,j}{1,i});   
  end 
end

%% NoGoCR

u =(1:size(ind_NoGoCR))';
refind_NoGoCR = [ind_NoGoCR u];
% dfmat = zeros(size(ind_TacMiss,1), nRois);

for j = 1:nRois    
 for i = 1 : size(refind_NoGoCR,1)       
     k = refind_NoGoCR(i, 1);     
  NoGoCR_trial = all_dffmat{1,j}{k,1};
  NoGoCR_DF{i} = NoGoCR_trial; 
 end
  allNoGoCR_DF{:,j} = (NoGoCR_DF);
end

nTrials=size(refind_NoGoCR,1);

for j = 1:nRois
  for i = 1 : nTrials;
     CR_dfmat{i,j} = (allNoGoCR_DF{1,j}{1,i});   
  end 
end

%% plot

%  df2plot = all_dffmat;
% hold on
% for j= 13
%     figure(j);
%     for i = 1:nTrials;
%         plot(df2plot{i,j},'Color','r','LineWidth',1.5 );    
%         hold on;
%     end;  
% end

%% save and export 

% save(AudCR_dfmat);
% 
% save(Hit_dfmat);
% 
% save(Miss_dfmat);

%%
% framecut = 380;       % set from where (starting from which frame) it cuts
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
%  axis([0 380 -1 4]);
% % 
%  end