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
%%
% connect data points in 3d
plot3(f7(:,1),f7(:,2),f7(:,3),'ro','LineWidth',2);
text(f7(:,1),f7(:,2),f7(:,3),[repmat('  ',15,1), num2str((1:15)')])
ax = gca;
ax.XTick = [];
ax.YTick = [];
ax.ZTick = [];
box on
hold on
fnplt(cscvn(f7'),'r',2)
hold off
%%
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

%%
pt = 200;
ax2 = axes;
linkaxes([ax1,ax2])
for i = 1:26
    if i == 2 || i==7 || i== 8 || i==9 || i==10 || i==11 || i == 12 || i == 13 ...
            || i == 3 || i==22 || i==23 || i==24
%     if i == 12 || i==2 || i==7 || i== 8 || i==9 || i==10 || i==6 ...
%             || i==11 || i==4 || i==5 || i == 3 || i==22 || i==21 || i==20 || i==13
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

scatter(surface_lonlatr(:,1),surface_lonlatr(:,2),"Marker","diamond","MarkerFaceColor","g")
fig1.Position(1:4)=[200 150 1200 600];
%%
% no interpolation
% convert into lon, lat, depth
EAR = zeros(size(f1),'like',f1);
EAR(:,1) = atan2d(f1(:,2),f1(:,1));% lon in degree
EAR(:,2) = atan2d(f1(:,3),sqrt(f1(:,1).^2+f1(:,2).^2));% lat in degree
EAR(:,3) = abs((1-sqrt(f1(:,1).^2+f1(:,2).^2+f1(:,3).^2))*6371);% dep in km

lonlatdep = zeros(size(f2),'like',f2);
lonlatdep(:,1) = atan2d(f2(:,2),f2(:,1));% lon in degree
lonlatdep(:,2) = atan2d(f2(:,3),sqrt(f2(:,1).^2+f2(:,2).^2));% lat in degree
lonlatdep(:,3) = (1-sqrt(f2(:,1).^2+f2(:,2).^2+f2(:,3).^2))*6371;% dep in km

Iceland = zeros(size(f3),'like',f3);
Iceland(:,1) = atan2d(f3(:,2),f3(:,1));% lon in degree
Iceland(:,2) = atan2d(f3(:,3),sqrt(f3(:,1).^2+f3(:,2).^2));% lat in degree
Iceland(:,3) = (1-sqrt(f3(:,1).^2+f3(:,2).^2+f3(:,3).^2))*6371;% dep in km

Tristan = zeros(size(f4),'like',f4);
Tristan(:,1) = atan2d(f4(:,2),f4(:,1));% lon in degree
Tristan(:,2) = atan2d(f4(:,3),sqrt(f4(:,1).^2+f4(:,2).^2));% lat in degree
Tristan(:,3) = (1-sqrt(f4(:,1).^2+f4(:,2).^2+f4(:,3).^2))*6371;% dep in km

Louisville = zeros(size(f5),'like',f5);
Louisville(:,1) = atan2d(f5(:,2),f5(:,1));% lon in degree
Louisville(:,2) = atan2d(f5(:,3),sqrt(f5(:,1).^2+f5(:,2).^2));% lat in degree
Louisville(:,3) = (1-sqrt(f5(:,1).^2+f5(:,2).^2+f5(:,3).^2))*6371;% dep in km

Reunion = zeros(size(f6),'like',f6);
Reunion(:,1) = atan2d(f6(:,2),f6(:,1));% lon in degree
Reunion(:,2) = atan2d(f6(:,3),sqrt(f6(:,1).^2+f6(:,2).^2));% lat in degree
Reunion(:,3) = (1-sqrt(f6(:,1).^2+f6(:,2).^2+f6(:,3).^2))*6371;% dep in km

Hawaii = zeros(size(f7),'like',f7);
Hawaii(:,1) = atan2d(f7(:,2),f7(:,1));% lon in degree
Hawaii(:,2) = atan2d(f7(:,3),sqrt(f7(:,1).^2+f7(:,2).^2));% lat in degree
Hawaii(:,3) = (1-sqrt(f7(:,1).^2+f7(:,2).^2+f7(:,3).^2))*6371;% dep in km
%%
% plotting THB-plume conduits
fn = '\hotspot_stat\conduit_cord.xlsx';
f = readmatrix(fn);

EAR_c = f(1:4,2:4);
Easter_c = f(7:9,2:4);
Iceland_c = f(12:15,2:4);
Reunion_c = f(18:20,2:4);
Tristan_c = f(23:25,2:4);
Hawaii_c = f(28:30,2:4);
Louisville_c = f(33:36,2:4);

figure(2)
pt = 200;
geoscatter(EAR_c(:,2),EAR_c(:,1),ones(length(EAR_c),1)*pt,EAR_c(:,3),'.');hold on;
geoscatter(Easter_c(:,2),Easter_c(:,1),ones(length(Easter_c),1)*pt,Easter_c(:,3),'.');hold on;
geoscatter(Iceland_c(:,2),Iceland_c(:,1),ones(length(Iceland_c),1)*pt,Iceland_c(:,3),'.');hold on;
geoscatter(Tristan_c(:,2),Tristan_c(:,1),ones(length(Tristan_c),1)*pt,Tristan_c(:,3),'.');hold on;
geoscatter(Louisville_c(:,2),Louisville_c(:,1),ones(length(Louisville_c),1)*pt,Louisville_c(:,3),'.');hold on;
geoscatter(Reunion_c(:,2),Reunion_c(:,1),ones(length(Reunion_c),1)*pt,Reunion_c(:,3),'.');hold on;
geoscatter(Hawaii_c(:,2),Hawaii_c(:,1),ones(length(Hawaii_c),1)*pt,Hawaii_c(:,3),'.');hold on;
c = colorbar;
colormap hot
c.Ticks = [410 660 1000 2000 2800];
c.Limits = [0 2900];
%%
% write vtk for steinburger plume conduit
load('Steinberger_Antretter_Plumes (1)\case1-660_v3_time_dependent_moving_closest_u0_2.2_tmax_68conduits.mat');
clear lon lat r x y z points

lon = deg2rad(plume_store(58).lon);% in radian
lat = deg2rad(plume_store(58).lat);% in radian
r = plume_store(58).r/6371e3;% dimensionless
[x,y,z] = sph2cart(lon,lat,r);
points = [x y z];
points = points';

% write vtk file
ofn = './Model_conduit/Tristan_model.vtk';

% setup cells - put each point into its own cell
cells = {};
npoints = length(x);
ncell = npoints;
for i = 1:ncell
    cells{i} = [i];
end

% Write the VTK file using the legacy VTK file format
% described here: https://kitware.github.io/vtk-examples/site/VTKFileFormats/
% 1. Write file header

ofh = fopen(ofn,'w');

fprintf(ofh,'# vtk DataFile Version 2.0\n');
fprintf(ofh,'test points\n');
fprintf(ofh,'ASCII\n');
fprintf(ofh,'DATASET POLYDATA\n');
fprintf(ofh,'POINTS  %d float\n',npoints);
% 2. Write the points
fprintf(ofh,'%f %f %f\n',points);
% write the cells
% compute the sum of numPoints and connectivity indices
cell_list_size = 0;
for i = 1:length(cells)
   cell_list_size = cell_list_size + 1 + length(cells{i}); 
end

fprintf(ofh,'VERTICES %d %d\n',length(cells),cell_list_size);
for i=1:length(cells)
    fprintf(ofh,'%d\n',length(cells{i}));
    fprintf(ofh,'\t%d\n',cells{i});
end

% mannual interpolate function
function [xq,yq,zq] = interplt4(f,npts)
  for j=1:length(f)-1
      i = (j-1)*npts+1;
      xq(i:(i+npts)) = interp1([0 npts],[f(j,1) f(j+1,1)],0:1:npts);
      yq(i:(i+npts)) = interp1([0 npts],[f(j,2) f(j+1,2)],0:1:npts);
      zq(i:(i+npts)) = interp1([0 npts],[f(j,3) f(j+1,3)],0:1:npts);
  end
end