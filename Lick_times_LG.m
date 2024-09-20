%% LOAD SESSION DATA
% clear all
% close all
% load('L2_M1_LG_TactileGo_Phase4_Image_Mar19_2018_Session2')
lick_trials = SessionData.RawEvents.Trial;


%% GET STIMULUS DELIVERY TIMES
for i = 1:length(lick_trials),
    test1 = SessionData.RawEvents.Trial{1,i}.States;
    field = isfield(test1, 'DeliverStimulus');
%     field = isfield(test1, 'DeliverStimulus1');
    if field == 0,
        stim_times {1,i} = NaN;
    else
        stim_times {1,i} = SessionData.RawEvents.Trial{1,i}.States.DeliverStimulus;
%         stim_times {1,i} = SessionData.RawEvents.Trial{1,i}.States.DeliverStimulus1;
    end
end

stim_times = stim_times';

for i = 1:length(lick_trials)
    V = stim_times {i,1};
    nstim_times {i,1} = stim_times {i,1} - V(1,1);
end

%% GET PORT1IN LICK TIMES
for i = 1:length(lick_trials),
    test = SessionData.RawEvents.Trial{1,i}.Events;
    field = isfield(test, 'Port1In');                          %% FOR JAY: you will have to change 'Port2In' to the number of port you used
    if field == 0,
        lick_times {1,i} = NaN;
    else
        lick_times {1,i} = SessionData.RawEvents.Trial{1,i}.Events.Port1In;     %% FOR JAY: you will have to change 'Port2In' to the number of port you used
    end
%     
end

lick_times  = lick_times';

for i = 1:length(lick_trials)
    V = stim_times {i,1};
    nlick_times {i,1} = lick_times {i,1} - V(1,1);
    spont {i,1} = nlick_times {i,1}(find(nlick_times{i,1}>=0&nlick_times{i,1}<=2));
    spont_lick_rate (i,1) = (length(spont{i,1})/3);
    
    
end

avg_spont_lick_rate = (mean(spont_lick_rate(:,1)));

%% GET REWARD DELIVERY TIMES

for i = 1:length(lick_trials),
    test1 = SessionData.RawEvents.Trial{1,i}.States;
    field = isfield(test1, 'DeliverReward');
    if field == 0,
        reward_times {1,i} = NaN;
    else
        reward_times {1,i} = SessionData.RawEvents.Trial{1,i}.States.DeliverReward;
    end
end

reward_times = reward_times';

for i = 1:length(lick_trials)
    V = stim_times {i,1};
    nreward_times {i,1} = reward_times {i,1} - V(1,1);
end

%% GET ITI TIMES

for i = 1:length(lick_trials),
    test1 = SessionData.RawEvents.Trial{1,i}.States;
    field = isfield(test1, 'ITI');
    if field == 0,
        ITI_times {1,i} = NaN;
    else
        ITI_times {1,i} = SessionData.RawEvents.Trial{1,i}.States.ITI;
    end
end

ITI_times = ITI_times';

for i = 1:length(lick_trials)
    V = stim_times {i,1};
    nITI_times {i,1} = ITI_times {i,1} - V(1,1);
end


%% PLOT FIGURE

figure;  
for i=1:length(lick_trials);
   hold on 
plot(cell2mat(nlick_times(i)),i,'.k','MarkerSize',2);
% %plotSpikeRaster(lick_times,'PlotType','scatter','XLimForCell',[-2 10]);
end

% for i=1:length(reward_freq);
%    hold on 
% plot(cell2mat(reward_freq(i,2)),i,'.k','MarkerSize',2);
% % %plotSpikeRaster(lick_times,'PlotType','scatter','XLimForCell',[-2 10]);
% end
% title('Dots (Scatterplot)');
%  set(gca,'XTick',[-5:10]);

%stim_times=cellfun(@(x) x-2, stim_times,'UniformOutput',false);

%hold on
LineFormatVert1.Color = 'r';
%plotSpikeRaster(stim_times,'PlotType','vertline','LineFormat', LineFormatVert1, 'XLimForCell',[-2 10]);
plotSpikeRaster(nstim_times,'PlotType','vertline','LineFormat', LineFormatVert1, 'XLimForCell',[-5 10]);

%hold on
LineFormatVert2.Color = 'b';
% plotSpikeRaster(reward_times,'PlotType','vertline','LineFormat', LineFormatVert2, 'XLimForCell',[-2 10]);
plotSpikeRaster(nreward_times,'PlotType','vertline','LineFormat', LineFormatVert2, 'XLimForCell',[-5 10]);
xlabel('Time (s)');
% 
% 
% hold on
% LineFormatVert3.Color = 'c';
% % plotSpikeRaster(ITI_times,'PlotType','vertline','LineFormat', LineFormatVert3, 'XLimForCell',[-2 10]);
% plotSpikeRaster(nITI_times,'PlotType','vertline','LineFormat', LineFormatVert3, 'XLimForCell',[-5 10]);

%%

% Trialfreq = SessionData.Thissesfreq';
Trialcond = SessionData.TrialTypes';
% freq = unique(Trialfreq);
freq = [1 2]% 3 4 5 6 7];

for u = 1:length(freq)
%     freq1 = find(Trialfreq==freq(u));
    freq1 = find(Trialcond==freq(u));
    
    for t = 1:length(freq1)
%         reward_freq(t,u)= nreward_times(freq1(t,:,:));
%         punish_freq(t,u)= npunish_times(freq1(t,:,:));
         reward_freq(t,u)= nlick_times(freq1(t,:,:));
%          lat(t,u)= cellfun(@(v) v(1), reward_freq(t,1));
    end
end

[m n] = size(reward_freq);

for c = 1:n
    for d = 1:m
        new = cell2mat(reward_freq(d,c));
        if isnan(new)
            new1{d,c} = NaN;
        else
            new1{d,c} = new(new>0);
        end
    end
end

% 
for c = 1:n
%     lat_freq = reward_freq(:,c);
    lat_freq = reward_freq(:,c);
    for z = 1:length(lat_freq)
        if isempty (reward_freq{z,c})
            reward_freq{z,c}=NaN;
        end
        lat1(z,c)= cellfun(@(v) v(1), reward_freq(z,c));

    end
%     clear lat_freq
end

% wstim_start = 0;   % stim time is 0 
% wstim_end = 1 ; %duration of the stim window in sec
% wrew_start = 0; %start of the reward window (time relative to stim onset)
% wrew_end = 3; %end of the reward window
% 
% for i = 1:length(reward_freq)
%     stim {i,1} = reward_freq {i,2}(find(reward_freq{i,2}>=wstim_start&reward_freq{i,2}<=wstim_end));
%     stim_lick_rate (i,1) = (length(stim{i,1})/3);
%     reward {i,1} = reward_freq {i,2}(find(reward_freq{i,2}>=wrew_start&reward_freq{i,2}<=wrew_end));
%     reward_lick_rate (i,1) = (length(reward{i,1})/3);
% 
%     T_avg_stim_lick_rate = (mean(stim_lick_rate(:,1)));
%     T_avg_reward_lick_rate = (mean(reward_lick_rate(:,1)));
% 
    
% end


% 
% for i = 1:length(reward_freq)
%     stim {i,1} = reward_freq {i,3}(find(reward_freq{i,3}>=wstim_start&reward_freq{i,3}<=wstim_end));
%     stim_lick_rate (i,1) = (length(stim{i,1})/3);
%     reward {i,1} = reward_freq {i,3}(find(reward_freq{i,3}>=wrew_start&reward_freq{i,3}<=wrew_end));
%     reward_lick_rate (i,1) = (length(reward{i,1})/3);
%     
%     AT_avg_stim_lick_rate = (mean(stim_lick_rate(:,1)));
%     AT_avg_reward_lick_rate = (mean(reward_lick_rate(:,1)));
% end

% ADATA_lick_freq = [T_avg_stim_lick_rate AT_avg_stim_lick_rate ; T_avg_reward_lick_rate AT_avg_reward_lick_rate];
% 
% for c = 1:n
% %     lat_freq = punish_freq(:,c);
%     for z = 1:length(lat_freq)
%         if isempty (punish_freq{z,c})
%             punish_freq{z,c}=NaN;
%         end
%         lat1(z,c)= cellfun(@(v) v(1), punish_freq(z,c));
% 
%     end
% end


for c = 1:n
    lat_freq = new1(:,c);
    for z = 1:length(lat_freq)
        if isempty (new1{z,c})
            new1{z,c}=NaN;
        end
        lat1(z,c)= cellfun(@(v) v(1), new1(z,c));     
    end
end

figure;
for s = 1:n
X = ones(m,1) .* s;
Y = lat1(:,s);
scatter(X,Y)
hold on;
end
% meanlats = [meanlat1 meanlat2];
% hold on
% plot (meanlats)


% %%
% %FREQ 1
% Null1 = cellfun(@(V) any(isnan(V(:))), reward_freq1);
% Miss1 = find(Null1==1);
% Hit1 = find(Null1==0);
% perc_hit1 = (length(Hit1)/length(freq1))*100;
% 
% %FREQ2
% Null2 = cellfun(@(V) any(isnan(V(:))), reward_freq2);
% Miss2 = find(Null2==1);
% Hit2 = find(Null2==0);
% perc_hit2 = (length(Hit2)/length(freq2))*100;
% %FREQ3
% Null3 = cellfun(@(V) any(isnan(V(:))), reward_freq3);
% Miss3 = find(Null3==1);
% Hit3 = find(Null3==0);
% perc_hit3 = (length(Hit3)/length(freq3))*100;
% %FREQ4
% Null4 = cellfun(@(V) any(isnan(V(:))), reward_freq4);
% Miss4 = find(Null4==1);
% Hit4 = find(Null4==0);
% perc_hit4 = (length(Hit4)/length(freq4))*100;
% %FREQ5
% Null5 = cellfun(@(V) any(isnan(V(:))), reward_freq5);
% Miss5 = find(Null5==1);
% Hit5 = find(Null5==0);
% perc_hit5 = (length(Hit5)/length(freq5))*100;
% %FREQ6
% Null6 = cellfun(@(V) any(isnan(V(:))), reward_freq6);
% Miss6 = find(Null6==1);
% Hit6 = find(Null6==0);
% perc_hit6 = (length(Hit6)/length(freq6))*100;
% 

%% FINDING FIRST RESPONSE LATENCY

latfreq1 = lat1(:,1);
latfreq1(any(isnan(latfreq1),2),:)=[];
latfreq1(latfreq1 > 1) = []; 
meanlat1 = mean(latfreq1);
latfreq2 = lat1(:,2);
latfreq2(any(isnan(latfreq2),2),:)=[];
latfreq2(latfreq2 > 1) = [];
meanlat2 = mean(latfreq2);
% latfreq3 = lat1(:,3);
% latfreq3(any(isnan(latfreq3),2),:)=[];
% latfreq3(latfreq3 > 1) = [];
% meanlat3 = mean(latfreq3);
% latfreq4 = lat1(:,4);
% latfreq4(any(isnan(latfreq4),2),:)=[];
% latfreq4(latfreq4 > 1) = [];
% meanlat4 = mean(latfreq4);
% latfreq5 = lat1(:,5);
% latfreq5(any(isnan(latfreq5),2),:)=[];
% latfreq5(latfreq5 > 1) = [];
% meanlat5 = mean(latfreq5);
% latfreq6 = lat1(:,6);
% latfreq6(any(isnan(latfreq6),2),:)=[];
% latfreq6(latfreq6 > 1) = [];
% meanlat6 = mean(latfreq6);
% latfreq7 = lat1(:,7);
% latfreq7(any(isnan(latfreq7),2),:)=[];
% latfreq7(latfreq7 > 1) = [];
% meanlat7 = mean(latfreq7);

% amean_lat = [  meanlat1; meanlat2; meanlat3; meanlat5; meanlat6; meanlat7 ];
%  
% 
%all_lat =[latfreq1; latfreq2; latfreq3; latfreq4; latfreq5; latfreq6]
 %meanlats =  [[meanlat1; meanlat2; meanlat3; meanlat4; meanlat5; meanlat6;];
% hold on; plot (meanlats); hold off;


%% GET % HITS AND MISSES FOR T2 level

% Null = cellfun(@(V) any(isnan(V(:))), nreward_times);
% Miss = find(Null==1);
% Hit = find(Null==0);
% perc_hit = (length(Hit)/length(nreward_times))*100;