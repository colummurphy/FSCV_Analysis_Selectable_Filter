function plotcor(corrmat,cortypes,plotparam,varargin)
cor=corrmat;
fscvchs=find(~cellfun(@isempty,corrmat));
lfpchs=plotparam.lfpchs;
pathsave=plotparam.savepath;
argnum=1;
while argnum<=1
    switch varargin{argnum}
        case ischar
            filename=varargin{argnum};
    end
    argnum=argnum+1;
end
figcorr=figure('visible','off');
if ~ispc
    set(figcorr,'position',[0 0 1000 750],'color',[1 1 1]);
else
set(figcorr,'position',[100 100 1400 900],'color',[1 1 1]);
set(figcorr,'visible','on');
end
set(0,'CurrentFigure',figcorr);    %set figure handle to current figure
axcorr={};
for ii=1:length(fscvchs)
    axcorr{ii}=subplot(2,2,ii);
end
range=1:length(cortypes);
xticks=range;
xlabels=cortypes;
cmapp=[1 .5 0;1 .55 0; 1 .6 0; 1 .65 0; 1 .7 0; 1 .75 0; 1 .8 0; 1 .85 0; 1 .9 0];
cmapc=[1 .5 0;1 .55 0; 1 .6 0; 1 .65 0; 1 .7 0; 1 .75 0; 1 .8 0; 1 .85 0; 1 .9 0];
ranjitter=rand(1,length(lfpchs))*.3-.15;

sitep=find(contains(lfpchs,'p')==1);
sitec=find(contains(lfpchs,'c')==1);
sitecolors=zeros(length(lfpchs),3);
cmapp1=cool; 
cmapp=flipud(cmapp1(1:12:end,:))-.35;
if length(sitep)>6
    cmapp=flipud(cmapp1(1:6:end,:))-.35;
end
cmapc1=winter; 
cmapc=flipud(cmapc1(1:12:end,:))-.35;
if length(sitec)>6
    cmapc=flipud(cmapc1(1:6:end,:))-.35;
end
cmapp(cmapp<0)=0;
cmapc(cmapc<0)=0;
if ~isempty(sitep)            
    sitecolors(sitep,:)=cmapp(1:length(sitep),:);
end
if ~isempty(sitec)    
    sitecolors(sitec,:)=cmapc(1:length(sitec),:);
end
for ii=1:length(fscvchs)
    fregion=plotparam.sites{fscvchs(ii)}(1);    %get letter c or p to know region
    fc=cmapp(1,:);
    if strcmp(fregion,'c')
        fc=cmapc(1,:);
    end
    axis(axcorr{ii},'square')
    set(axcorr{ii},'xlim',[0 max(xticks)])
    set(axcorr{ii},'XTick',xticks)
    set(axcorr{ii},'xticklabel',xlabels,'xticklabelrotation',270)
    set(axcorr{ii},'ylim',[0 max(xticks)])
    set(axcorr{ii},'yTick',xticks)
    set(axcorr{ii},'yticklabel',xlabels)    
    ylabel(axcorr{ii},plotparam.sites{fscvchs(ii)})
    title(axcorr{ii},[trialname ' | comod | da-' plotparam.sites{fscvchs(ii)} ', beta lfp'],...
        'color',fc);
    hold(axcorr{ii},'on');
    if ~isfield(cor{fscvchs(ii)},'corrdata')
        continue
    end
    curdata=cor{fscvchs(ii)}.corrdata;
            divisions{1}=find(contains(cortypes,'fix')==1);
        divisions{2}=find(contains(cortypes,'targ')==1);
        divisions{2}=[divisions{2} find(contains(cortypes,'rewpre')==1)];
        if ~isempty(divisions{2})
        divisions{3}=find(contains(cortypes,'rew')==1 & ...
            ~contains(cortypes,'rewpre'));
        aa=plot(axcorr{ii},[divisions{2}(1) divisions{2}(1)], ...
            [0 max(xticks)],'linewidth',1,'color',[0 0 0]);
        aa.Color(4)=.2;
        aa=plot(axcorr{ii},[divisions{3}(1) divisions{3}(1)], ...
            [0 max(xticks)],'linewidth',1,'color',[0 0 0]);
        aa.Color(4)=.2;
        aa=plot(axcorr{ii},[0 max(xticks)],...
            [divisions{2}(1)-.5 divisions{2}(1)-.5], ...
            'linewidth',1,'color',[0 0 0]);
        aa.Color(4)=.2;
        aa=plot(axcorr{ii},[0 max(xticks)],...
            [divisions{3}(1)-.5 divisions{3}(1)-.5], ...
            'linewidth',1,'color',[0 0 0]);
        aa.Color(4)=.2;        
        end

    for irow=1:size(curdata,2)
        if contains(curdata(irow).type1,'task') ||...
            contains(curdata(irow).type2,'task')
        continue
        end
        %get x,y coord to plot based on type labels
        ycord=find(ismember(cortypes,curdata(irow).type1)==1);
        xcord=find(ismember(cortypes,curdata(irow).type2)==1)-0.25;
        eregion=curdata(irow).d2site(1);
        m='+';
        %c=[1 0 0];
        siteidx=strcmp(lfpchs,curdata(irow).d2site);
        pval=curdata(irow).p;
        c=sitecolors(siteidx,:);
        fsize=50*log10(1/pval);
        if curdata(irow).r<0
            m='o';
            %c=[0 0 1];
        end
a=scatter(axcorr{ii},xcord+ranjitter(siteidx),ycord+ranjitter(siteidx),...
    fsize,m,'markeredgecolor',c,'MarkerEdgeAlpha',.5,'linewidth',1.5);

    end
    if ii==length(fscvchs)
        yy1=13;
        for ilfp=1:length(lfpchs)
            c=sitecolors(ilfp,:);
            text(axcorr{ii},13,yy1,lfpchs{ilfp},'fontsize',10,'color',c);
            yy1=yy1-2;
        end
    end
    hold(axcorr{ii},'off');
end
savefig(figcorr,[pathsave filename]);
saveas(figcorr,[pathsave filename],'jpg')