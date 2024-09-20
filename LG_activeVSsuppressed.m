dffmat = norm_all_Roi;
dffmat = all_RoiSes; % data input here is a matrix with trial averaged activity for each ROI (rows). So each row in the matrix is the average of all trials for a single ROI 
nRois = size(dffmat,1);
nFrames= size(dffmat,2);
%% SET YOUR PARAMETERS HERE
freqAcq = 30;

stimOn = 2 *freqAcq;                              % define stimulus onset 
stimOff = 3 *freqAcq;                             % define stimulus offset . This is the time window where the calcium events are counted.
peakdetect = 4 *freqAcq;                          % define offset for peak detection window
eventduration = 0 *freqAcq;                        % define minimum event duration for detection
peakDistance = 0.5 *freqAcq;                         % define minPeakDistance in the findpeak function
peakWidth = 0;
baseline = (0.1*freqAcq):(2*freqAcq);                       % define the baseline over which the threshold is calculated
sd_value = 1.5;
nbins = 2*freqAcq;
roll_wind = 2*freqAcq; 

%%
for i = 1:nRois
   ampl = [];
   ampl2 = [];
   w = [];
   w2 = [];
   locs = [];
   locs2 = [];
   trace_integral = [];
   
    ftrace = dffmat(i,:) ;  
    
%    for k = 1:roll_wind
%      baseline_integral{1,k} = trapz((ftrace(k:nbins+k)));       
%      int_threshold = sd_value* std((cell2mat(baseline_integral))); 
%    end
% % %   
     baseline_integral = trapz((ftrace(baseline)));
      int_threshold = sd_value * (((baseline_integral)));         
   
      peak_threshold = sd_value * (mean(ftrace(baseline))); 
      trace_integral = trapz((ftrace(stimOn:peakdetect)));  % this is the bit that actually measure th integral
   
   mean_f = [];
   
   if trace_integral > int_threshold    
       active_log{1,i} = 1;
        [ampl,locs, w] = findpeaks((ftrace(stimOn:peakdetect)),'MinPeakheight',peak_threshold,'MinPeakDistance',peakDistance,'MinPeakWidth',peakWidth, 'Annotate','extents','WidthReference','halfheight');
        mean_f = mean(ftrace(stimOn:stimOff));
   elseif trace_integral < (int_threshold/sd_value)/2
        active_log{1,i} = 2;
        [ampl2,locs2, w2] = findpeaks((-ftrace(stimOn:peakdetect)),'MinPeakDistance',peakDistance,'MinPeakWidth',peakWidth, 'Annotate','extents','WidthReference','halfheight');
   else
        active_log{1,i} = NaN;
   end  
     
%      
  %% plot
%           figure(i);             
%            findpeaks(ftrace,'MinPeakheight',peak_threshold, 'MinPeakDistance',peakDistance,'MinPeakWidth',peakWidth,'Annotate','extents','WidthReference','halfheight');                           hold on;                          
%            plot (locs+ stimOn , ampl +0.1 ,'o','MarkerSize',10,'MarkerFaceColor','b');
%            hold on;
%            plot (locs2+ stimOn , (-ampl2) +0.1 ,'o','MarkerSize',10,'MarkerFaceColor','r');   
%            axis([0 nFrames -1 3 ]);
%            set(gca,'XTick',0:freqAcq:nFrames)
%            set(gca,'XTickLabel',0:1:nFrames/freqAcq)
%            title(['Roi ', num2str(i)]);
           
%%
           
    if max(ampl)<0.1
         ampl=NaN;
    end
%%
  
     all_Roi_ampl{i} =  max(ampl');                       % GIVES mean AMPLITUDES OF CALCIUM EVENTS FOR EACH ROIS
     all_Roi_ampl2{i} =  max(ampl2');                     %ampl of inhibited dendrites 
     all_Roi_integral{i} = trace_integral;   
     all_Roi_meanF{i} = mean_f;
     
     all_Roi_width {i} = (max(w)')/30; 
     all_Roi_width2 {i} = (max(w2)')/30; %duration of inhibited dendrites
     all_Roi_locs {i} = (max(locs)')/ 30; % gives location of the peaks 
     all_Roi_locs2 {i} = (max(locs2)')/ 30; % gives location of the peaks of inhibited dendrites
 %% data output

  AADATA = [ all_Roi_ampl' all_Roi_ampl2'  all_Roi_integral' all_Roi_meanF' all_Roi_locs'  ];
  
  inhibited = (sum(cell2mat(active_log)==2))/nRois;
  excited = (sum(cell2mat(active_log)==1))/nRois;
  nonResp = (sum(cell2mat(active_log)==0))/nRois;
  
  AAPercentage = [excited inhibited nonResp]; 



end;

%% PLOT

% nRois=size(all_RoiSes,1);
% nFrames=size(all_RoiSes,2);
%   
%  for r = 1:nRois;
%  f=figure(r);
%        hold on; 
% plot(dffmat(r,:),'g','LineWidth',1.5)
% u=f.Renderer;
% f.Renderer = 'painters'
% set(gca,'XTick',0:30:nFrames+30);
% set(gca,'XTickLabel',0:1:nFrames/30+30);
%  axis([0 170 -1 2]);
% % 
%  end

%
sort_mat_Roi =[dffmat cell2mat(active_log')];
sort_col = size(sort_mat_Roi,2);
sorted_all_Roi = sortrows(sort_mat_Roi,sort_col);
dendrite_color_ID = sorted_all_Roi (:,size(sorted_all_Roi,2));
sorted_all_Roi (:,size(sorted_all_Roi,2)) = [];

%%

 all_dend = dffmat;
 
for k=1:nRois
   
    if cell2mat(active_log(k)) == 1 
        active_dend_v{k} =  all_dend(k,:);
        integral_active{k} = cell2mat(AADATA(k,3));
    elseif cell2mat(active_log(k)) == 2
        inh_dend_v{k} =  all_dend(k,:);
        integral_active{k} = [];
    else
        nr_dend_v{k} =  all_dend(k,:); 
        integral_active{k} = [];
    end
end

inh_dend=cell2mat(inh_dend_v');
active_dend=cell2mat(active_dend_v');
nr_dend=cell2mat(nr_dend_v');
integral_active= (integral_active')
sorttoheat = [inh_dend;active_dend; nr_dend];

dendrite_color_ID = flip(dendrite_color_ID); 

%%

    
% % 
%%  plot heatmap
  f=figure(1);
 clims=([0 1]); imagesc(active_dend,clims);
%           colormap jet %        colorbar
         set(gca,'XTick',0:30:nFrames)
         set(gca,'XTickLabel',0:1:nFrames/30)

 u=f.Renderer; f.Renderer = 'painters'
 axis([0 270 0 300]);

%
 f=figure(2);
 clims=([0 2]);
 imagesc(dendrite_color_ID,clims); 
 u=f.Renderer;
 f.Renderer = 'painters'

%%

faulty_id_log = active_dend<-0.5;

faulty_id_logsum = sum(faulty_id_log ,2);

faulty_id = find(faulty_id_logsum);

active_dend(faulty_id,:)=[];
% %%
%   figure
% clustercategory = clustervis(active_dend,2);
% 
% re_active = [active_dend clustercategory];
% 
% cluster1 = active_dend(find(re_active(:,size(re_active,2)) == 1),:);
% for g = 1:size(cluster1,1)
%     ftrace=cluster1(g,:);
%  [ampl1] = findpeaks((ftrace(stimOn:peakdetect)),'MinPeakheight',peak_threshold,'MinPeakDistance',peakDistance,'MinPeakWidth',peakWidth, 'Annotate','extents','WidthReference','halfheight');
% cluster1_amplitues{g} = max(ampl1);
% end
% 
% cluster2 = active_dend(find(re_active(:,size(re_active,2)) == 2),:);
% [ampl2] = findpeaks((cluster1(stimOn:peakdetect)),'MinPeakheight',peak_threshold,'MinPeakDistance',peakDistance,'MinPeakWidth',peakWidth, 'Annotate','extents','WidthReference','halfheight');
% for e = 1:size(cluster2,1)
%     ftrace=cluster2(e,:);
%  [ampl2] = findpeaks((ftrace(stimOn:peakdetect)),'MinPeakheight',peak_threshold,'MinPeakDistance',peakDistance,'MinPeakWidth',peakWidth, 'Annotate','extents','WidthReference','halfheight');
% cluster2_amplitues{e} = max(ampl2);
% end

%%
%%  %% plot mean trace with shade bar (std)
%
f=figure(2222);
hold on;
trace = active_dend;
avg_all_Roi_trace = mean((trace));
shadedErrorBar([],avg_all_Roi_trace, std((trace))/sqrt(size((trace),1)),'red',1);
u=f.Renderer
f.Renderer = 'painters'
set(gca,'XTick',0:30:nFrames+30);
set(gca,'XTickLabel',0:1:nFrames/30+30);
 axis([0 270 -0.1 1]);
 
% f=figure(22222);
% hold on;
% trace = cluster2;
% avg_all_Roi_trace = mean((trace));
% shadedErrorBar([],avg_all_Roi_trace, std((trace))/sqrt(size((trace),1)),'r',1);
% u=f.Renderer
% f.Renderer = 'painters'
% set(gca,'XTick',0:30:nFrames+30);
% set(gca,'XTickLabel',0:1:nFrames/30+30);
%  axis([0 170 -0.1 3]);
% 



