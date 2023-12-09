% cross section maker
% Load tomographic model
tomofile1 = 'semucb-wm1.nc';
info = ncinfo(tomofile1);
depth_s = ncread(tomofile1,'depth');
lon_s = ncread(tomofile1,'longitude');
lat_s = ncread(tomofile1,'latitude');
dvs_s = ncread(tomofile1,'vsvoigt');

tomofile2 = 'glad-m25-vs-0.0-n4.nc';
depth_g = ncread(tomofile2,'depth');
lat_g = ncread(tomofile2,'latitude');
lon_g = ncread(tomofile2,'longitude');
vsh = ncread(tomofile2,'vsh');
vsv = ncread(tomofile2,'vsv');
vs_or = sqrt(vsv.^2+vsh.^2);
vs_mean = zeros(1,342);
vs_sum = zeros(1,342);
dvs_g = zeros(721,361,342);
d_theta = deg2rad(0.5);d_phi = deg2rad(0.5);
for i = 1:1:342
    cell_vs = 0.25*(vs_or(1:end-1,1:end-1,i) + ...
        vs_or(2:end,1:end-1,i)+...
        vs_or(1:end-1,2:end,i)+...
        vs_or(2:end,2:end,i));
    lonc = (lon_g(1:end-1)+lon_g(2:end))/2;
    latc = (lat_g(1:end-1)+lat_g(2:end))/2;

    cell_weight = (cosd(latc) * ones(length(lonc),1)')';
    vs_mean(i) = sum(sum(cell_weight .* cell_vs)) / sum(sum(cell_weight));
    dvs_g (:,:,i) = (vs_or(:,:,i) - vs_mean(i)) / vs_mean(i)*100; % dvs in %
end

[llons,llats,dds] = ndgrid(lon_s,lat_s,depth_s);
Fs = griddedInterpolant(llons,llats,dds,dvs_s);
[llong,llatg,ddg] = ndgrid(lon_g,lat_g,depth_g);
Fg = griddedInterpolant(llong,llatg,ddg,dvs_g);

file = readmatrix('data/nuvel_1_plates.txt');
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
%%
% load semucb
filenames1 = {
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

% load glad-m25
filenames2 = {
'conduit_major/Glad-m25/Azores_200_g.csv';
'conduit_major/Glad-m25/Canary_200_g.csv';
'conduit_major/Glad-m25/Cape_200_g.csv';
'conduit_major/Glad-m25/Caroline_200_g.csv';
'conduit_major/Glad-m25/EAR_200_g.csv';
'conduit_major/Glad-m25/Easter_200_g.csv';
'conduit_major/Glad-m25/Fernando_200_g.csv';
'conduit_major/Glad-m25/Gala_200_g.csv';
'conduit_major/Glad-m25/Hawaii_200_g.csv';
'conduit_major/Glad-m25/Hoggar_200_g.csv';
'conduit_major/Glad-m25/Iceland_200_g.csv';
'conduit_major/Glad-m25/Juan_Fer_200_g.csv';
'conduit_major/Glad-m25/JM_200_g.csv';
'conduit_major/Glad-m25/Kerguelen_200_g.csv';
'conduit_major/Glad-m25/Louisville_200_g.csv';
'conduit_major/Glad-m25/Mac_200_g.csv';
'conduit_major/Glad-m25/Marion_200_g.csv';
'conduit_major/Glad-m25/Marquesas_200_g.csv';
'conduit_major/Glad-m25/Meteor_200_g.csv';
'conduit_major/Glad-m25/Pitcairn_200_g.csv';
'conduit_major/Glad-m25/Reunion_200_g.csv';
'conduit_major/Glad-m25/Samoa_200_g.csv';
'conduit_major/Glad-m25/San_Felix_200_g.csv';
'conduit_major/Glad-m25/St_H_200_g.csv';
'conduit_major/Glad-m25/Tahiti_200_g.csv';
'conduit_major/Glad-m25/Tristan_200_g.csv'};
%%
% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames1)
    f1{i} = readmatrix(filenames1{i});
end
for i = 1:length(filenames2)
    f2{i} = readmatrix(filenames2{i});
end

npts = 20;
for i = 1:26
    % interpolate data by 4 pts
    [xqq,yqq,zqq] = interplt4(f1{i},npts);
    % convert into lon, lat, depth
lonlatdep = zeros(length(xqq),3);
lonlatdep(:,1) = atan2d(yqq,xqq);% lon in degree
lonlatdep(:,2) = atan2d(zqq,sqrt(xqq.^2+yqq.^2));% lat in degree
lonlatdep(:,3) = abs((1-sqrt(xqq.^2+yqq.^2+zqq.^2))*6371);% dep in km
    plume_path1{i} = lonlatdep;
end
for i = 1:26
    % interpolate data by 4 pts
    [xqq,yqq,zqq] = interplt4(f2{i},npts);
    % convert into lon, lat, depth
lonlatdep = zeros(length(xqq),3);
lonlatdep(:,1) = atan2d(yqq,xqq);% lon in degree
lonlatdep(:,2) = atan2d(zqq,sqrt(xqq.^2+yqq.^2));% lat in degree
lonlatdep(:,3) = abs((1-sqrt(xqq.^2+yqq.^2+zqq.^2))*6371);% dep in km
    plume_path2{i} = lonlatdep;
end
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
%%
clear path
pt = 300;
% set up unchange
npts_t = 300;% lateral grid num
npts_d = 151;
depth_new = linspace(0,2850,npts_d);
% Rticks = {2850 1250 660 410 0};
pos = [3511 5121 5711 5961];
% figure position
fig1 = figure();
fig1.Position(1:4)=[100 100 1300 600];
a=zeros(4,4);b=zeros(4,4);
a(1,:)=[0.25,0.56,0.25,0.3];b(1,:)=[-0.08,0.52,0.45,0.45];
a(2,:)=[0.73,0.56,0.25,0.3];b(2,:)=[0.4,0.52,0.45,0.45];
a(3,:)=[0.25,0.1,0.25,0.3];b(3,:)=[-0.08,0.01,0.45,0.45];
a(4,:)=[0.73,0.1,0.25,0.3];b(4,:)=[0.4,0.01,0.45,0.45];
% lon lat for all hotspots and tracks + conduit
lon = zeros(2,2);lat = zeros(2,2);

% choose different cross sections
path(1,1:4)=[2 3 14 18];
path(2,1:4)=[2 3 16 20];
lon(2,1)= -22.5;lat(2,1)= 0;lon(2,2)= -11.5;lat(2,2)= 43; % CC
lon(1,1)= -160;lat(1,1)= -32.5;lon(1,2)= -112;lat(1,2)= -12;% MP

% path(1,1:2)=[22 20];
% path(2,1:2)=[24 22];
% lon(2,1)= -36.5;lat(2,1)= -19;lon(2,2)= 12;lat(2,2)= -13.5;% St_H
% lon(1,1)= -168;lat(1,1)= 5;lon(1,2)= -176;lat(1,2)= -45;% Samoa

% path(1,1:2)=[19 6];
% path(2,1:2)=[21 6];
% lon(1,1)= 34;lat(1,1)= -44.8;lon(1,2)= 64.5;lat(1,2)= -8.5;% Reunion
% lon(2,1)= -128;lat(2,1)= -35.5;lon(2,2)= -86;lat(2,2)= -2;% Easter

% path(1,1:2)=[10 8];
% path(2,1:2)=[11 9];
% lon(1,1)= -54;lat(1,1)= 58;lon(1,2)= 42;lat(1,2)= 57.2;% Iceland
% lon(2,1)= -160;lat(2,1)= 34;lon(2,2)= -149;lat(2,2)= -9;% Hawaii

% path(1,1:2)=[23 20];
% path(2,1:2)=[25 22];
% lon(1,1)= -180;lat(1,1)= -10;lon(1,2)= -123;lat(1,2)= -20;% Tahiti
% lon(2,1)= -150;lat(2,1)= 7;lon(2,2)= -146;lat(2,2)= -45;% Tahiti

% path(1,1:2) = [4 13];
% path(2,1:2)= [4 15];
% lon(1,1)= 172;lat(1,1)= 35;lon(1,2)= 161;lat(1,2)= -24;% Caroline
% lon(2,1)= -135;lat(2,1)= -25;lon(2,2)= -160;lat(2,2)= -78;% Louisville

% path = [7;8];
% lon(1,1)= -120;lat(1,1)= 11;lon(1,2)= -78;lat(1,2)=-8;% Gala
% lon(2,2)= -85;lat(2,2)= 10;lon(2,1)= -116.5;lat(2,1)=-33.5;% Gala

% path = [25;26];
% lon(1,1)= -20.5;lat(1,1)= -20;lon(1,2)= 8;lat(1,2)= -62;% Tristan
% lon(2,1)= -37;lat(2,1)= -29;lon(2,2)= 26.5;lat(2,2)= -31.5;% Tristan

% path = [16;18];
% lon(1,1)= -155;lat(1,1)= 10;lon(1,2)= -119;lat(1,2)= -30;% Marquesas
% lon(2,1)= -169;lat(2,1)= -21;lon(2,2)= -120;lat(2,2)= -4;% Marquesas

% path = [1;1];
% lon(1,1)= -60;lat(1,1)= 42;lon(1,2)= 0;lat(1,2)= 27;% Azores
% lon(2,1)= -23;lat(2,1)= 10;lon(2,2)= -29;lat(2,2)= 60;% Azores

% path = [12;14];
% lon(1,1)= 30;lat(1,1)= -36;lon(1,2)= 95;lat(1,2)= -50;% Azores
% lon(2,1)= 62;lat(2,1)= -25;lon(2,2)= 80;lat(2,2)= -70;% Azores

% path(1,1:2) = [11 21];
% path(2,1:2)= [12 23];
% lon(1,1)= -122;lat(1,1)= -39;lon(1,2)= -65;lat(1,2)= -17;% Juan Fernandez
% lon(2,1)= -128;lat(2,1)= -38;lon(2,2)= -60;lat(2,2)= -22.5;% San Felix

% path(1,1:2) = [11 21];
% path(2,1:2)= [12 23];
% lon(1,1)= -78;lat(1,1)= -5;lon(1,2)= -108;lat(1,2)= -55;% JF+SF
% lon(2,1)= -92;lat(2,1)= -5;lon(2,2)= -81;lat(2,2)= -55;% JF+SF

% path(1,1:2) = [7 23];
% path(2,1:2) = [8 25];
% lon(1,1)= -98;lat(1,1)= 20;lon(1,2)= -90;lat(1,2)=-40;% Gala
% lon(2,1)= -180;lat(2,1)= -22;lon(2,2)= -123;lat(2,2)= -8;% Tahiti
%%
for p_count = 1:4
    line_num = fix((p_count+1)/2);
% generate track of great circle
lat1 = lat(line_num,1);lon1 = lon(line_num,1);
lat2 = lat(line_num,2);lon2 = lon(line_num,2);
[lattrk,lontrk] = track2(lat1,lon1,lat2,lon2,wgs84Ellipsoid,"degrees",npts_t);
[arclen,az] = distance(lat1,lon1,lat2,lon2);
if arclen > 180
    arclen = 360-arclen;
end
arctrk = linspace(-arclen/2,arclen/2,npts_t);

plane = zeros(npts_t,3,npts_d);
for i = 1:npts_d % 0:19:2850 depth
    plane(:,:,i) = [lontrk lattrk ones(npts_t,1)*depth_new(i)];
end
plane_vs_s = reshape(Fs(plane(:,1,:),plane(:,2,:),plane(:,3,:)),[npts_t,npts_d]);
plane_vs_g = reshape(Fg(plane(:,1,:),plane(:,2,:),plane(:,3,:)),[npts_t,npts_d]);
vs_s = flipud(plane_vs_s');
vs_g = flipud(plane_vs_g');
radius = fliplr(6371-depth_new);

% Plotting
ax1 = axes;
subplot(2,2,p_count,ax1)
if rem(p_count,2)==1
    [~,c,size] = polarPcolor(ax1,radius,arctrk,vs_s,'circlesPos',pos,'Nspokes',2);% ,'Rticklabel',Rticks
%     if line_num == 1
%         title("SEMUCB-WM1","FontSize",14)
%     end
else
    [~,c,size] = polarPcolor(ax1,radius,arctrk,vs_g,'circlesPos',pos,'Nspokes',2);
%     if line_num == 1
%         title("GLAD-M25","FontSize",14)
%     end
end
% colormap(flipud(colormap(crameri('vik'))));
colormap(ax1,crameri('roma',20))
%ylabel(c,'\deltaVs(%)','FontSize',14);set(c,'location','WestOutside');
hold on

mark =zeros(3,5);
arctrkr = arctrk/180*pi;
arcmark = zeros(2,5);
j=fix(npts_t/6);
for i = 1:5
    arcmark(1,i) = lontrk(j*i);
    arcmark(2,i) = lattrk(j*i);
    mark(1,i) = size*sin(arctrkr(j*i));
    mark(2,i) = size*cos(arctrkr(j*i));
end
scatter3(mark(1,2:5),mark(2,2:5),mark(3,2:5),'filled','MarkerFaceColor','w',"MarkerEdgeColor",'k')
scatter3(mark(1,1),mark(2,1),mark(3,1),'filled','MarkerFaceColor',[0.5 0 0.5],"MarkerEdgeColor",'k')
hold on

% plot track on a hemisphere inserted plot
ax2=axes;
axesm vperspec
center = zeros(2,1);
center(1) = (lat1+lat2)/2;center(2) = (lon1+lon2)/2;
setm(ax2,"Origin",[center(1) center(2) 0])
geoshow('landareas.shp','FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2,"LineStyle",'none')
framem;tightmap;
for i=1:length(plate_boundaries)
    geoshow(plate_boundaries{i}(:,2),plate_boundaries{i}(:,1),linewidth=1, color='r')
end
for i=1:length(path(1,:))
    if rem(p_count,2)==1
        scatterm(ax2,flipud(plume_path1{path(1,i)}(:,2)),flipud(plume_path1{path(1,i)}(:,1)),ones(length(plume_path1{path(1,i)}(:,1)),1)*pt,flipud(plume_path1{path(1,i)}(:,3)),'.');
        hold on
    else
        scatterm(ax2,flipud(plume_path2{path(2,i)}(:,2)),flipud(plume_path2{path(2,i)}(:,1)),ones(length(plume_path2{path(2,i)}(:,1)),1)*pt,flipud(plume_path2{path(2,i)}(:,3)),'.');
    end
end
colormap(ax2,crameri('imola',6));
caxis(ax2,[0 3000])
geoshow(surface_lonlatr(:,2),surface_lonlatr(:,1),"DisplayType","point","Marker","diamond","MarkerSize",5,'MarkerEdgeColor','g',"MarkerFaceColor","g")
geoshow(lattrk,lontrk,"DisplayType","line","LineWidth",1,"Color","k")
geoshow(arcmark(2,2:5),arcmark(1,2:5),"DisplayType","point","marker","o","MarkerSize",5,'MarkerEdgeColor','k')
geoshow(arcmark(2,1),arcmark(1,1),"DisplayType","point","marker","o","MarkerSize",5,'MarkerEdgeColor','k',"MarkerFaceColor",[0.5 0 0.5])
ax1.XColor = 'none';ax1.YColor = 'none';ax1.Color = 'none';
ax2.XColor = 'none';ax2.YColor = 'none';ax2.Color = 'none';
ax1.Position=a(p_count,:);
ax2.Position=b(p_count,:);
hold on
end
% c2 = colorbar();
% set(c2,'location','SouthOutside');c2.Position = [0.4 0.47 0.2 0.02];
% c2.Label.String = 'Depth (km)';c2.Label.FontSize = 14;
%%
exportgraphics(fig1,"figure\xsection\MP+CC.jpg","Resolution",600)

% mannual interpolate function
function [xq,yq,zq] = interplt4(f,npts)
  for j=1:length(f)-1
      i = (j-1)*npts+1;
      xq(i:(i+npts)) = interp1([0 npts],[f(j,1) f(j+1,1)],0:1:npts);
      yq(i:(i+npts)) = interp1([0 npts],[f(j,2) f(j+1,2)],0:1:npts);
      zq(i:(i+npts)) = interp1([0 npts],[f(j,3) f(j+1,3)],0:1:npts);
  end
end