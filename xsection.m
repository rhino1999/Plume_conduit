% cross section maker
% Load tomographic model
addpath .\plate-reference\
tomofile1 = 'semucb_vtk\semucb-wm1.nc';
info = ncinfo(tomofile1);
depth_s = ncread(tomofile1,'depth');
lon_s = ncread(tomofile1,'longitude');
lat_s = ncread(tomofile1,'latitude');
dvs_s = ncread(tomofile1,'vsvoigt');

tomofile2 = 'semucb_vtk\glad-m25-vs-0.0-n4.nc';
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
%%
% set up unchange
npts_t = 300;% lateral grid num
npts_d = 151;
depth_new = linspace(0,2850,npts_d);
% Rticks = {2850 1250 660 410 0};
pos = [3511 5121 5711 5961];
fig1 = figure();
fig1.Position(1:4)=[100 100 800 600];
a=zeros(4,4);b=zeros(4,4);
a(1,:)=[0.1,0.51,0.38,0.35];b(1,:)=[0.025,0.82,0.15,0.15];
a(2,:)=[0.55,0.51,0.38,0.35];b(2,:)=[0.475,0.82,0.15,0.15];
% lon lat for all hotspots and tracks
lon = zeros(4,2);lat = zeros(4,2);
lon(1,1)= -28;lat(1,1)= 0;lon(1,2)= -19;lat(1,2)= 45;
%%
for p_count = 1:2
    line_num = fix((p_count+1)/2);
% generate track of great circle
lat1 = lat(line_num,1);lon1 = lon(line_num,1);
lat2 = lat(line_num,2);lon2 = lon(line_num,2);
[lattrk,lontrk] = track2(lat1,lon1,lat2,lon2,wgs84Ellipsoid,"degrees",npts_t);
[arclen,az] = distance(lat1,lon1,lat2,lon2);
if arclen > 180
    arclen = 360-az;
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
    if line_num ==1
        title("SEMUCB-WM1")
    end
else
    [~,c,size] = polarPcolor(ax1,radius,arctrk,vs_g,'circlesPos',pos,'Nspokes',2);
    if line_num == 1
        title("GLAD-M25")
    end
end
% colormap(flipud(colormap(crameri('vik'))));
colormap(crameri('roma'))
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
geoshow('landareas.shp','FaceColor',[0.5 0.5 0.5],'FaceAlpha',0.2)
framem;tightmap;
geoshow(lattrk,lontrk,"DisplayType","line","LineWidth",0.5,"Color","k")
geoshow(arcmark(2,2:5),arcmark(1,2:5),"DisplayType","point","marker","o","MarkerSize",3,'MarkerEdgeColor','k')
geoshow(arcmark(2,1),arcmark(1,1),"DisplayType","point","marker","o","MarkerSize",3,'MarkerEdgeColor','k',"MarkerFaceColor",[0.5 0 0.5])
ax1.XColor = 'none';ax1.YColor = 'none';ax1.Color = 'none';
ax2.XColor = 'none';ax2.YColor = 'none';ax2.Color = 'none';
ax1.Position=a(p_count,:);
ax2.Position=b(p_count,:);
hold on
end