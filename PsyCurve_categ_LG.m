


trial = SessionData.TrialTypes;
outcome = SessionData.TrialOutcome; 
ntrial = size (trial); ntrial = ntrial (2);
% % % % 
%     cut = 90;
%    outcome(:,1:cut) = [ ];
%    trial(:,1:cut) = [ ];
%        outcome(:,(size(outcome,2)- cut):(size(outcome,2))) = [ ];
%       trial(:,(size(outcome,2)- cut):(size(outcome,2))) = [ ];

d_plus10_trial= sum (trial == 1);
d_plus6_trial = sum  (trial == 2);
d_plus3_trial = sum  (trial == 3);
d_minus3_trial = sum  (trial == 5);
d_minus6_trial = sum  (trial == 6);
d_minus10_trial= sum (trial == 7);



d_plus10_Hit = trial ==1 & outcome== 1; d_plus10_Hit_perc = (sum(d_plus10_Hit))/d_plus10_trial ;
d_plus6_Hit = trial ==2 & outcome== 1; d_plus6_Hit_perc = (sum(d_plus6_Hit))/d_plus6_trial ;
d_plus3_Hit = trial ==3 & outcome== 1; d_plus3_Hit_perc = (sum(d_plus3_Hit))/d_plus3_trial ;
d_minus3_Hit = trial ==5 & outcome== 1; d_minus3_Hit_perc = (sum(d_minus3_Hit))/d_minus3_trial ;
d_minus6_Hit = trial ==6 & outcome== 1; d_minus6_Hit_perc = (sum(d_minus6_Hit))/d_minus6_trial ;
d_minus10_Hit = trial ==7 & outcome== 1; d_minus10_Hit_perc = (sum(d_minus10_Hit))/d_minus10_trial ;
% hold on;
%  figure
Hit_ax = [d_minus10_Hit_perc; d_minus6_Hit_perc; d_minus3_Hit_perc; d_plus3_Hit_perc; d_plus6_Hit_perc; d_plus10_Hit_perc];
%%
x_ax = [ 1; 2; 3; 4; 5; 6; ]; 

  plot(x_ax, Hit_ax, 'bo', 'LineWidth',2);
 
    [ffit,curve]= fitPsyche.fitPsycheCurveWH(x_ax, Hit_ax);
    
 %   [curve]= fitPsyche.fitPsycheCurveLogit(x_ax, Hit_ax);

     hold on;    
     
      plot(ffit,'k');

%  xq = 0:0.001:7;
%  vq1 = interp1(x_ax,Hit_ax ,xq,'pchip');
% plot(x_ax,Hit_ax, 'ro', xq,vq1,'r-','LineWidth',1.5);

% 
% Hit_ax = [Hit_ax7, Hit_ax8, Hit_ax9]
% avg_Hot_av = mean(Hit_ax');


  x_label ={ '-10' '-6' '-3' '+3' '+6' '+10'};
   axis([0 6 0 1.2]);
   set(gca,'XTick',x_ax)
   set(gca,'XTickLabel',x_label)

   %%
    
   