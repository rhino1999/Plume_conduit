% load semucb
filenames = {
'conduit_major/SEMUCB/Azores_200.csv';
'conduit_major/SEMUCB/Canary_200.csv';
'conduit_major/SEMUCB/Cape_200.csv';
'conduit_major/SEMUCB/Caroline_200.csv';
'conduit_major/SEMUCB/EAR_200.csv';
'conduit_major/SEMUCB/Easter_200.csv';
'conduit_major/SEMUCB/Gala_200.csv';
'conduit_major/SEMUCB/Hawaii_200.csv';
'conduit_major/SEMUCB/Hoggar_200.csv';
'conduit_major/SEMUCB/Iceland_200.csv';
'conduit_major/SEMUCB/Juan_Fer_200.csv';
'conduit_major/SEMUCB/Kerguelen_200.csv';
'conduit_major/SEMUCB/Louisville_200.csv';
'conduit_major/SEMUCB/Mac_200.csv';
'conduit_major/SEMUCB/Marion_200.csv';
'conduit_major/SEMUCB/Marquesas_200.csv';
'conduit_major/SEMUCB/Meteor_200.csv';
'conduit_major/SEMUCB/Pitcairn_200.csv';
'conduit_major/SEMUCB/Reunion_200.csv';
'conduit_major/SEMUCB/Samoa_200.csv';
'conduit_major/SEMUCB/San_Felix_200.csv';
'conduit_major/SEMUCB/St_H_200.csv';
'conduit_major/SEMUCB/Tahiti_200.csv';
'conduit_major/SEMUCB/Trindade_200.csv';
'conduit_major/SEMUCB/Tristan_200.csv';
'conduit_major/SEMUCB/Vema_200.csv'};

% load tomographic model
tomofile = 'data/semucb-wm1.nc';% https://ds.iris.edu/ds/products/emc-semucb-wm1/
info = ncinfo(tomofile);
depth = ncread(tomofile,'depth');
lon = ncread(tomofile,'longitude');
lat = ncread(tomofile,'latitude');
dvs_raw = ncread(tomofile,'vsvoigt');
dvs = cat(1,dvs_raw(181:end,:,:),dvs_raw(1:180,:,:));

% % load glad-m25
% filenames = {
% 'conduit_major/Glad-m25/Azores_200_g.csv';
% 'conduit_major/Glad-m25/Canary_200_g.csv';
% 'conduit_major/Glad-m25/Cape_200_g.csv';
% 'conduit_major/Glad-m25/Caroline_200_g.csv';
% 'conduit_major/Glad-m25/EAR_200_g.csv';
% 'conduit_major/Glad-m25/Easter_200_g.csv';
% 'conduit_major/Glad-m25/Fernando_200_g.csv';
% 'conduit_major/Glad-m25/Gala_200_g.csv';
% 'conduit_major/Glad-m25/Hawaii_200_g.csv';
% 'conduit_major/Glad-m25/Hoggar_200_g.csv';
% 'conduit_major/Glad-m25/Iceland_200_g.csv';
% 'conduit_major/Glad-m25/Juan_Fer_200_g.csv';
% 'conduit_major/Glad-m25/JM_200_g.csv';
% 'conduit_major/Glad-m25/Kerguelen_200_g.csv';
% 'conduit_major/Glad-m25/Louisville_200_g.csv';
% 'conduit_major/Glad-m25/Mac_200_g.csv';
% 'conduit_major/Glad-m25/Marion_200_g.csv';
% 'conduit_major/Glad-m25/Marquesas_200_g.csv';
% 'conduit_major/Glad-m25/Meteor_200_g.csv';
% 'conduit_major/Glad-m25/Pitcairn_200_g.csv';
% 'conduit_major/Glad-m25/Reunion_200_g.csv';
% 'conduit_major/Glad-m25/Samoa_200_g.csv';
% 'conduit_major/Glad-m25/San_Felix_200_g.csv';
% 'conduit_major/Glad-m25/St_H_200_g.csv';
% 'conduit_major/Glad-m25/Tahiti_200_g.csv';
% 'conduit_major/Glad-m25/Tristan_200_g.csv'};

% % load tomographic model
% tomofile = 'data/glad-m25-vs-0.0-n4.nc';% https://ds.iris.edu/ds/products/emc-glad-m25/
% depth = ncread(tomofile,'depth');
% lat = ncread(tomofile,'latitude');
% lon = ncread(tomofile,'longitude');
% vsh = ncread(tomofile,'vsh');
% vsv = ncread(tomofile,'vsv');
% vs_or = sqrt(vsv.^2+vsh.^2);
% vs_mean = zeros(1,342);
% vs_sum = zeros(1,342);
% vs = zeros(721,361,342);
% d_theta = deg2rad(0.5);d_phi = deg2rad(0.5);
% for i = 1:1:342
%     cell_vs = 0.25*(vs_or(1:end-1,1:end-1,i) + ...
%         vs_or(2:end,1:end-1,i)+...
%         vs_or(1:end-1,2:end,i)+...
%         vs_or(2:end,2:end,i));
%     lonc = (lon(1:end-1)+lon(2:end))/2;
%     latc = (lat(1:end-1)+lat(2:end))/2;
% 
%     cell_weight = (cosd(latc) * ones(length(lonc),1)')';
%     vs_mean(i) = sum(sum(cell_weight .* cell_vs)) / sum(sum(cell_weight));
%     dvs_raw (:,:,i) = (vs_or(:,:,i) - vs_mean(i)) / vs_mean(i)*100; % dvs in %
% end
% dvs = cat(1,dvs_raw(361:end,:,:),dvs_raw(1:360,:,:));

% load other files
file = readmatrix('data/nuvel_1_plates.txt');
[x1,y1,z1]=grdread2('data/morvel.vx.0.25.sa.grd');
[x2,y2,z2]=grdread2('data/morvel.vy.0.25.sa.grd');

% load Steinberger model conduits
dirs = {'Steinberger_Antretter_Plumes/44_ms',...
    'Steinberger_Antretter_Plumes/12_ms'};
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

%%
% plot base map
fig1 = figure();
fig1.Position(1:4)=[200 150 1200 600];
ax1 = axes;
slice = dvs(:,:,65);% semucb 65, glad 342
[N,R] = egm96geoid;
axesm robinson
setm(ax1,"Origin",[0 140 0]) % center at # degree lon
Z = zeros(R.RasterSize);
[llon,llat] = ndgrid(lon+180,lat);
F = griddedInterpolant(llon,llat,slice);
x = linspace(0,360,1441);
y = linspace(-90,90,721);
[xq,yq] = ndgrid(x,y);
vsq = F(xq,yq);
geoshow(vsq',R,'DisplayType','surface','CData',vsq','ZData',Z);
colormap(flipud(colormap(ax1,crameri('vik'))));
caxis([-3 3])
ax1.XColor = 'none';ax1.YColor = 'none';ax1.Color = 'none';
c1 = colorbar(ax1,'Position',[.07 .15 .014 .7]);
c1.Ticks = [-3 0 3];c1.FontSize = 16;
c1.Limits = [-3 3];
c1.Label.String = '\deltaV_S(%)';c1.Label.FontSize = 20;
shading interp;
alpha(0.4)
tightmap;framem;gridm
geoshow('landareas.shp','FaceColor','none')
% title('Traced and Modeled Conduits in SEMUCB-WM1','FontSize',20)
title('Traced and Modeled Conduits in GLAD-M25','FontSize',20)
hold on

% plot plate boundaries and plate motions
X = -180:22.5:180;
Y = -90:22.5:90;
[XX,YY] = meshgrid(X,Y);
msk = x1>180;
z1_new=[z1(:,msk) z1(:,~msk)];
z2_new=[z2(:,msk) z2(:,~msk)];
East = z1_new(1:90:end,1:90:end);
North = z2_new(1:90:end,1:90:end);

plate_boundaries = {};
i1 = 1;
j=1;
for i=1:length(file)
    if isnan(file(i,1))
        plate_boundaries{j} = file(i1:i-1,1:2);
        j=j+1;
        i1 = i+1;
    end
end

for i=1:length(plate_boundaries)
    geoshow(plate_boundaries{i}(:,2),plate_boundaries{i}(:,1),linewidth=1, color='r')
end
quiverm(YY,XX,North,East,'k',0.7);hold on;

% plot traced conduits
% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
end

npts = 5;
for i = 1:26
    % interpolate data by 4 pts
    [xq,yq,zq] = interplt4(f{i},npts);
    % convert into lon, lat, depth
lonlatdep = zeros(length(xq),3);
lonlatdep(:,1) = atan2d(yq,xq);% lon in degree
lonlatdep(:,2) = atan2d(zq,sqrt(xq.^2+yq.^2));% lat in degree
lonlatdep(:,3) = abs((1-sqrt(xq.^2+yq.^2+zq.^2))*6371);% dep in km
    plume_path{i} = lonlatdep;
end

% plot Modeled conduits
pt = 200;
ax2 = axes;
linkaxes([ax1,ax2])
for i = 1:26
    if i == 4 || i==6 || i==7 || i==8 || i== 11 || i==13 || i==14 || i==16 || i==18 || i==20 || i==21 || i==23 || i==1 || i == 2 || i==3 || i==10 || i==12 || i==19 || i==25 || i==22 % SEMUCB   
%     if i == 4 || i==6 || i==8 || i==9 || i==12 || i==15 || i==16 || i==18 || i==20 || i==22 || i==23 || i==25 || i == 2 || i==3 || i==11 ||
%     i==14 || i==24 || i==26 || i==1 || i==21  % Glad
        scatter(ax2,flipud(plume_path{i}(:,1)),flipud(plume_path{i}(:,2)),ones(length(plume_path{i}(:,1)),1)*pt,flipud(plume_path{i}(:,3)),'.');
        hold on;
    end
end
ax2.Visible = 'off';
xlim([-180 180]);ylim([-90 90]);
set([ax1,ax2],'Position',[.115 .11 .75 .815]);
c2 = colorbar(ax2,'Position',[.877 .11 .0175 .815]);
c2.Label.String = 'depth (km)';c2.Label.FontSize = 14;
c2.Ticks = [410 660 1000 2000 2800];
c2.Limits = [0 2900];
colormap(ax2,'bone')
hold on

% plot hotspot location
surface_lonlatr(1,:) = [-24 15 1]; % Cape Verde
surface_lonlatr(2,:) = [-140.2 -29 1]; % Macdonald 
surface_lonlatr(3,:) = [-10 -17 1]; % St Helena
surface_lonlatr(4,:) = [-18 28 1];% Canary
surface_lonlatr(5,:) = [-138 -51 1]; % Louisville
surface_lonlatr(6,:) = [-28.4 38.5 1]; % Azores
surface_lonlatr(7,:) = [-82 -34 1]; % Juan Fernandez
surface_lonlatr(8,:) = [69 -49 1]; % Kerguelen
surface_lonlatr(9,:) = [-138 -11 1]; % Marquesas
surface_lonlatr(10,:) = [-109.3 -27.1 1]; % Easter
surface_lonlatr(11,:) = [-91.5 -0.4 1]; % Galapagos
surface_lonlatr(12,:) = [-19 65 1]; % Iceland
surface_lonlatr(13,:) = [-129 -25 1]; % Pitcairn
surface_lonlatr(14,:) = [55.7 -21.2 1]; % Reunion
surface_lonlatr(15,:) = [-168 -15 1]; % Samoa
surface_lonlatr(16,:) = [-80 -26 1]; % San Felix
surface_lonlatr(17,:) = [-11 -38 1]; % Tristan
surface_lonlatr(18,:) = [-155.58 19.90 1]; % hawaii
surface_lonlatr(19,:) = [-148.1 -17.9 1]; % Tahiti
surface_lonlatr(20,:) = [164 5 1];% Caroline

scatter(surface_lonlatr(:,1),surface_lonlatr(:,2),"Marker","diamond","MarkerFaceColor","g")
fig1.Position(1:4)=[200 150 1200 600];


% mannual interpolate function
function [xq,yq,zq] = interplt4(f,npts)
  for j=1:length(f)-1
      i = (j-1)*npts+1;
      xq(i:(i+npts)) = interp1([0 npts],[f(j,1) f(j+1,1)],0:1:npts);
      yq(i:(i+npts)) = interp1([0 npts],[f(j,2) f(j+1,2)],0:1:npts);
      zq(i:(i+npts)) = interp1([0 npts],[f(j,3) f(j+1,3)],0:1:npts);
  end
end