%% eliminate double (merged) ROIs

for i = 1:size(stat,2); 
    
     del_vec{i} = stat{1,i}.inmerge; 
      
end

del_vec = cell2mat(del_vec);
del_ind_vec = find(del_vec > 0);

iscell(del_ind_vec,:)=[];
F(del_ind_vec,:)=[];

%% eliminates faulty trials (<2 frames) from mclog
r=[];
for n=1:size(mclog,2)

   if mclog(n).nFrames <2;
   rem_ind_vec{n} = n;
   else 
    rem_ind_vec{n}=[];
   end
   
end
r = cell2mat(rem_ind_vec);
mclog(r)=[];

%%

dend_ind =(find(iscell(:,1)==0));
soma_ind =(find(iscell(:,1)==1));

dend_F = zeros(size(dend_ind,1), size(F,2)); 

for i = 1: dend_ind; 
    dend_F = F(dend_ind,:);%- 0.7*(Fneu(dend_ind,:));
end
%%

for n = 1:size(dend_F,1);   
    predffmat{n} = [dend_F(n,:)];
      
end

for x = 1:size(mclog,2)
nFrames(1,x) = mclog(x).nFrames; %mclog(x).nFrames;
end

%%


nTrials = size(nFrames,2);
nRois = size(dend_F,1);

for k = 1:nRois
    
    v = predffmat{k}; 
    
   for t =1:nTrials;
     
   n = numel(v);
 
   b = sum(nFrames(1:t));
 
  single_trial = v(1:b);

  framecut = b - nFrames(t);

  single_trial(1:framecut) = []; 


    alltrial_dffmat{t} = single_trial;

   end

   dffmat{k} = alltrial_dffmat'; 
   
end

