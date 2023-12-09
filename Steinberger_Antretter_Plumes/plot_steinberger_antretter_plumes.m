% load and plot Bernhard Steinberger's plume conduits.
% clear
% close all

dirs = {'44_ms','12_ms'};
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
           plumes(idxplume).lon(line) = tmp(2);
           plumes(idxplume).lat(line) = tmp(3);
           plumes(idxplume).r(line) = tmp(4);
           plumes(idxplume).shortname = file_list(i).name(1:4);
           line=line+1;
        end       
        fclose(fh);
        idxplume = idxplume+1;
    end
end
%% plot the plumes
% figure;
% h=gcf;
% h.Position(3:4) = [800 800];
% subplot(2,1,1);

for i=1:length(plumes)
    scatter(fliplr(plumes(i).lon),fliplr(plumes(i).lat),[],fliplr(6371*(1-plumes(i).r)),'filled');
    hold on
end
axis equal tight
set(gca,'XLim',[-180 180]);
set(gca,'YLim',[-90 90]);
hcb=colorbar
hcb.Label.String = 'Depth (km)';
hcb.Label.FontSize = 13;
load shorelines.mat
plot([shorelines(:).Lon],[shorelines(:).Lat],'k')
title('Steinberger and Antretter (2006) Plumes','FontSize',14);
text(-175,73,'A','FontSize',18);
set(gca,'FontSize',12)
set(gca,'Box','on');
set(gcf,'Color','w');
%%
subplot(2,1,2);
% load ../for_curtis/results_v2/case1-0_time_dependent_moving_closest_u0_2.2_tmax_45conduits.mat
load ../steinberger/figures/case1-660_time_dependent_moving_closest_u0_2.2_tmax_68conduits.mat

% steinberger hotspots
for i=1:length(plumes)
    stein_hslat(i) = plumes(i).lat(1);
    stein_hslon(i) = plumes(i).lon(1);
end

for i=1:length(plume_store)
    this_lat = plume_store(i).lat(end);
    this_lon = plume_store(i).lon(end);
    dlat = abs(this_lat-stein_hslat);
    dlon = abs(this_lon-stein_hslon);
    
    if( min(dlat) < 1 && min(dlon)<1)
    scatter(plume_store(i).lon,plume_store(i).lat,[],plume_store(i).depth,'filled');
    hold on   
    end
end
hcb=colorbar;
hcb.Label.String = 'Depth (km)';
hcb.Label.FontSize = 13;
axis equal tight
set(gca,'XLim',[-180 180]);
set(gca,'YLim',[-90 90]);
plot([shorelines(:).Lon],[shorelines(:).Lat],'k')
text(-175,73,'B','FontSize',18);
title('This work, case1-660, 68 Myr advection, 2.2 cm/yr rise speed','FontSize',14);
set(gca,'FontSize',12)
set(gca,'Box','on');
export_fig('comparison_rudolph_steinberger_plumes.eps');