% load semucb
filenames = {
'conduit_major\SEMUCB\EAR_200.csv';
'conduit_major\SEMUCB\Easter_200.csv';
'conduit_major\SEMUCB\Iceland_200.csv';
'conduit_major\SEMUCB\Tristan_200.csv';
'conduit_major\SEMUCB\Louisville_200.csv';
'conduit_major\SEMUCB\Reunion_200.csv';
'conduit_major\SEMUCB\Hawaii_200.csv';
'conduit_major\SEMUCB\Samoa_200.csv';
'conduit_major\SEMUCB\Tahiti_200.csv';
'conduit_major\SEMUCB\Mac_200.csv';
'conduit_major\SEMUCB\Pitcairn_200.csv';
'conduit_major\SEMUCB\Gala_200.csv';
'conduit_major\SEMUCB\Marquesas_200.csv';
'conduit_major\SEMUCB\Kerguelen_200.csv';
'conduit_major\SEMUCB\Caroline_200.csv';
'conduit_major\SEMUCB\Juan_Fer_200.csv';
'conduit_major\SEMUCB\San_Felix_200.csv';
'conduit_major\SEMUCB\Marion_200.csv';
'conduit_major\SEMUCB\Meteor_200.csv';
'conduit_major\SEMUCB\Vema_200.csv';
'conduit_major\SEMUCB\Trindade_200.csv';
'conduit_major\SEMUCB\St_H_200.csv';
'conduit_major\SEMUCB\Cape_200.csv';
'conduit_major\SEMUCB\Canary_200.csv';
'conduit_major\SEMUCB\Azores_200.csv';
% fn26 = 'conduit_major\JM_200.csv';
'conduit_major\SEMUCB\Hoggar_200.csv'};
% fn28 = 'conduit_major\SEMUCB\Fernando_200.csv';
%%
% load glad-m25
filenames = {
'conduit_major\Glad-m25\EAR_200_g.csv';
'conduit_major\Glad-m25\Easter_200_g.csv';
'conduit_major\Glad-m25\Iceland_200_g.csv';
% 'conduit_major\Glad-m25\Tristan_200_g_2.csv';
'conduit_major\Glad-m25\Louisville_200_g.csv';
'conduit_major\Glad-m25\Reunion_200_g.csv';
'conduit_major\Glad-m25\Hawaii_200_g.csv';
'conduit_major\Glad-m25\Samoa_200_g.csv';
'conduit_major\Glad-m25\Tahiti_200_g.csv';
'conduit_major\Glad-m25\Mac_200_g.csv';
'conduit_major\Glad-m25\Pitcairn_200_g.csv';
'conduit_major\Glad-m25\Gala_200_g.csv';
'conduit_major\Glad-m25\Marquesas_200_g.csv';
'conduit_major\Glad-m25\Kerguelen_200_g.csv';
'conduit_major\Glad-m25\Caroline_200_g.csv';
'conduit_major\Glad-m25\Juan_Fer_200_g.csv';
'conduit_major\Glad-m25\San_Felix_200_g.csv';
'conduit_major\Glad-m25\Marion_200_g.csv';
'conduit_major\Glad-m25\Meteor_200_g.csv';
% 'conduit_major\Glad-m25\Vema_200_g.csv';
'conduit_major\Glad-m25\Trindade_200_g.csv';
'conduit_major\Glad-m25\St_H_200_g.csv';
'conduit_major\Glad-m25\Cape_200_g.csv';
'conduit_major\Glad-m25\Canary_200_g.csv';
'conduit_major\Glad-m25\Azores_200_g.csv';
'conduit_major\Glad-m25\JM_200_g.csv';
'conduit_major\Glad-m25\Hoggar_200_g.csv';
'conduit_major\Glad-m25\Fernando_200_g.csv'};
%%
% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
end

npts = 20;
for i = 1:26
    % interpolate data by 4 pts
    [xqq,yqq,zqq] = interplt4(f{i},npts);
    % convert into lon, lat, depth
lonlatdep = zeros(length(xqq),3);
% lon +(360-#) if center at # degree
lonlatdep(:,1) = atan2d(yqq,xqq)+220;% lon in degree
lonlatdep(:,2) = atan2d(zqq,sqrt(xqq.^2+yqq.^2));% lat in degree
lonlatdep(:,3) = abs((1-sqrt(xqq.^2+yqq.^2+zqq.^2))*6371);% dep in km
    plume_path{i} = lonlatdep;
end
%%
pt = 300;
ax2 = axes;
axesm robinson
linkaxes([ax1,ax2])
for i = 1:26
    if i == 2 || i==7 || i== 8 || i==9 || i==10 || i==11 || i == 12 || i == 13 ...
            || i == 3 || i==22 || i==23 || i==24
%     if i == 12 || i==2 || i==7 || i== 8 || i==9 || i==10 || i==6 ...
%             || i==11 || i==4 || i==5 || i == 3 || i==22 || i==21 || i==20 || i==13
        scatterm(ax2,flipud(plume_path{i}(:,2)),flipud(plume_path{i}(:,1)),ones(length(plume_path{i}(:,1)),1)*pt,flipud(plume_path{i}(:,3)),'.');
        hold on;
    end
end
ax2.Visible = 'off';
set([ax1,ax2],'Position',[.115 .11 .75 .815]);
c2 = colorbar(ax2,'Position',[0.9 .15 .014 .7]);
c2.Ticks = [410 660 1000 2000 2800];c2.FontSize = 16;
c2.Limits = [0 2900];
c2.Label.String = 'depth (km)';c2.Label.FontSize = 20;
colormap(ax2,'bone')
hold on
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
           % lon +(360-#) if center at # degree
           plumes_model(idxplume).lon(line) = tmp(2)+220;
           plumes_model(idxplume).lat(line) = tmp(3);
           plumes_model(idxplume).r(line) = tmp(4);
           plumes_model(idxplume).shortname = file_list(i).name(1:4);
           line=line+1;
        end       
        fclose(fh);
        idxplume = idxplume+1;
    end
end
%%
ax3 = axes;
axesm robinson
linkaxes([ax1,ax3])
indx_p = 26;
indx_m = [11 33 35 44 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 31 30 42 6 5 1 17];% semucb(26)
% indx_m = [11 33 35 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 30 42 6 5 1 18 17 14];% glad(26)

for i=1:indx_p
    j=indx_m(i);
    if i == 2 || i==7 || i== 8 || i==9 || i==10 || i==11 || i == 12 || i == 13 || i == 3 || i==22 || i==23 || i==24
%     if i == 12 || i==2 || i==7 || i== 8 || i==9 || i==10 || i==6 ...
%             || i==11 || i==4 || i==5 || i == 3 || i==22 || i==21 || i==20 || i==13
        scatterm(ax3,fliplr(plumes_model(j).lat),fliplr(plumes_model(j).lon),ones(length(plumes_model(j).lat),1)*pt,fliplr(6371*(1-plumes_model(j).r)),'.');
        hold on
    end
end

ax3.Visible = 'off';
set([ax1,ax3],'Position',[.115 .11 .75 .815]);
c3 = colorbar(ax3,'Position',[.838 .15 .014 .7]);
c3.Ticks = [410 660 1000 2000 2800];c3.FontSize = 16;
c3.Limits = [0 2900];
colormap(ax3,'default')
ax1.Position=[0.095,0.07,0.73,0.815];
ax2.Position=[0.095,0.07,0.73,0.815];
ax3.Position=[0.095,0.07,0.73,0.815];
hold on
%%
surface_lonlatr(1,:) = [-24 15 1]; % Cape Verde
surface_lonlatr(2,:) = [-140.2 -29 1]; % Macdonald 
surface_lonlatr(3,:) = [-10 -17 1]; % St Helena
surface_lonlatr(4,:) = [-18 28 1];% Canary
surface_lonlatr(5,:) = [-138 -51 1]; % Louisville
surface_lonlatr(6,:) = [-28.4 38.5 1]; % Azores
surface_lonlatr(7,:) = [-82 -34 1]; % Juan Fernandez
surface_lonlatr(8,:) = [69 -49 1]; % Kerguelen
surface_lonlatr(9,:) = [-138 -11 1]; % Marquesas
surface_lonlatr(10,:) = [1 -52 1]; % Meteor
surface_lonlatr(11,:) = [34 6 1]; % East Africa
surface_lonlatr(12,:) = [-109.3 -27.1 1]; % Easter
surface_lonlatr(13,:) = [-91.5 -0.4 1]; % Galapagos
surface_lonlatr(14,:) = [-19 65 1]; % Iceland
surface_lonlatr(15,:) = [-129 -25 1]; % Pitcairn
surface_lonlatr(16,:) = [37.8 -46.9 1]; % Marion
surface_lonlatr(17,:) = [55.7 -21.2 1]; % Reunion
surface_lonlatr(18,:) = [-168 -15 1]; % Samoa
surface_lonlatr(19,:) = [-80 -26 1]; % San Felix
surface_lonlatr(20,:) = [-28.8 -20.5 1]; % Trindade
surface_lonlatr(21,:) = [-11 -38 1]; % Tristan
surface_lonlatr(22,:) = [-155.58 19.90 1]; % hawaii
surface_lonlatr(23,:) = [-148.1 -17.9 1]; % Tahiti
surface_lonlatr(24,:) = [4 -33 1]; % Vema
surface_lonlatr(25,:) = [164 5 1];% Caroline
surface_lonlatr(26,:) = [6 23 1];% Hoggar

% lon +(360-#) if center at # degree
scatterm(surface_lonlatr(:,2),surface_lonlatr(:,1)+220,ones(length(surface_lonlatr(:,1)),1)*150,'filled',"diamond","g")

% mannual interpolate function
function [xq,yq,zq] = interplt4(f,npts)
  for j=1:length(f)-1
      i = (j-1)*npts+1;
      xq(i:(i+npts)) = interp1([0 npts],[f(j,1) f(j+1,1)],0:1:npts);
      yq(i:(i+npts)) = interp1([0 npts],[f(j,2) f(j+1,2)],0:1:npts);
      zq(i:(i+npts)) = interp1([0 npts],[f(j,3) f(j+1,3)],0:1:npts);
  end
end