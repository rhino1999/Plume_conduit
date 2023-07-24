pt = 20;
ax3 = axes;
linkaxes([ax1,ax3])
%%
% load Steinberger model conduits
dirs = {'Steinberger_Antretter_Plumes\Steinberger_Antretter_Plumes\44_ms',...
    'Steinberger_Antretter_Plumes\Steinberger_Antretter_Plumes\12_ms'};
idxplume=1;
for idir=1:2
    % load all of the plumes in this directory
    file_list = dir([dirs{idir} '/*_ms']);
    for i=1:length(file_list)
        fh = fopen([dirs{idir} '/' file_list(i).name],'r');
        line=1;
        while(~feof(fh))
           l = fgetl(fh);
           tmp = sscanf(l,'%f');
           plumes_model(idxplume).lon(line) = tmp(2);
           plumes_model(idxplume).lat(line) = tmp(3);
           plumes_model(idxplume).r(line) = tmp(4);
           plumes_model(idxplume).shortname = file_list(i).name(1:4);
           line=line+1;
        end       
        fclose(fh);
        idxplume = idxplume+1;
    end
end
indx_p = 26;
indx_m = [11 33 35 44 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 31 30 42 6 5 1 17];% semucb(26)
% indx_m = [11 33 35 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 30 42 6 5 1 18 17 14];% glad(26)
%%
j=1;
for i=1:indx_p
    j=indx_m(i);
%     if i == 12 || i==2 || i==7 || i== 8 || i==9 || i==10 || i==6 ...
%             || i==11 || i==4 || i==5 || i == 3 || i==22 || i==21 || i==20 || i==13
    if i == 2 || i==7 || i== 8 || i==9 || i==10 || i==11 || i == 12 || i == 13 || i == 3 || i==22 || i==23 || i==24
        scatter(ax3,fliplr(plumes_model(j).lon),fliplr(plumes_model(j).lat),ones(length(plumes_model(j).lat),1)*pt,fliplr(6371*(1-plumes_model(j).r)),'filled');
        hold on
    end
end

ax3.Visible = 'off';
ax3.XTick = [];
ax3.YTick = [];
xlim([-180 180]);ylim([-90 90]);
set([ax1,ax3],'Position',[.115 .11 .75 .815]);
c3 = colorbar(ax3,'Position',[.9 .11 .0175 .815]);
c3.Ticks = [410 660 1000 2000 2800];
c3.Limits = [0 2900];
colormap(ax3,'default')
hold on