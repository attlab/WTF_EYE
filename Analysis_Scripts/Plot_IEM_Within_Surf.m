%{
Plot_IEM_Within
Author: Tom Bullock, UCSB Attention Lab
Date: 11.19.19

Plot TF surface plots.
%}

clear
close all

% load 
rDir = 'C:\\Users\\BOSS-EEG\\Desktop\\WTF_EYE';
sourceDir = [rDir '\\' 'IEM_Results_TT_Within'];

% subjects
subjects = [4,5];

% set up plot
thisSR=256;
xNewTick = [1, thisSR*.5, thisSR*1,  thisSR*1.5, thisSR*2, thisSR*2.5];
xNewTickLabel = ['-500';'  0 ';' 500';'1000';'1500';'2000'];
xNewLim = [1 640];
yNewTick = [1 2 3 4 5 6 7 8];
zNewTick = [.2 .4 .6];
zNewTickLabel = zNewTick;
yNewTickLabel = ['-180';'    ';'-90 ';'    ';' 0  ';'    ';' 90 ';'    '];
yNewLim = [1 8];
colorBar = [0 .8];
thisAxisFontsize = 18;

% % disable tick labels
% xNewTickLabel = [];
% yNewTickLabel = [];
% zNewTickLabel = [];

% compile data
for iSub=1:length(subjects)
    sjNum=subjects(iSub);
    for iCond=1:4
        load([sourceDir '\\' sprintf('sj%02d_cond%02d_IEM.mat',sjNum,iCond)],'em_within')
        all_real_total(iSub,iCond,:,:,:) = em_within.tfs.total;
        all_real_evoked(iSub,iCond,:,:,:) = em_within.tfs.evoked;        
        all_perm_total(iSub,iCond,:,:,:) = em_within.tfs_perm.total;       
        all_perm_total(iSub,iCond,:,:,:) = em_within.tfs_perm.total;      
    end
end

% plot data
f=1; % alpha, theta
h=figure('units','normalized','outerposition',[0 0 1 1]);
for iCond=1:4
    
    
    if      iCond==1; mc='Spatial'; ec='Fix';
    elseif  iCond==2; mc='Color';   ec='Fix';
    elseif  iCond==3; mc='Spatial'; ec='Move';
    elseif  iCond==4; mc='Color';   ec='Move';
    end
    
    subplot(2,2,iCond);
    surf(squeeze(mean(all_real_total(:,iCond,f,:,:),1)),'linestyle','none','FaceAlpha',1); 
    title([mc ' \\ ' ec])
    view(70,30)
    zlim([0 .7])
    colormap('jet')
    pbaspect([1 2 1])
    set(gca,'yTick',xNewTick,'yticklabel',xNewTickLabel,'xTick',yNewTick,...
        'xticklabel',yNewTickLabel,'ylim',xNewLim,'fontsize',thisAxisFontsize,...
        'LineWidth',4,'ztick',zNewTick,'zticklabel',zNewTickLabel);
    grid('off')

end
