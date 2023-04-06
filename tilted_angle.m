% tilted angle calculation
clear all
% load glad-m25
filenames = {
'conduit_major\Glad-m25\EAR_200_g.csv';
'conduit_major\Glad-m25\Easter_200_g.csv';
'conduit_major\Glad-m25\Iceland_200_g.csv';
'conduit_major\Glad-m25\Tristan_200_g_2.csv';
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
'conduit_major\Glad-m25\Vema_200_g.csv';
'conduit_major\Glad-m25\Trindade_200_g.csv';
'conduit_major\Glad-m25\St_H_200_g.csv';
'conduit_major\Glad-m25\Cape_200_g.csv';
'conduit_major\Glad-m25\Canary_200_g.csv';
'conduit_major\Glad-m25\Azores_200_g.csv';
'conduit_major\Glad-m25\JM_200_g.csv';
'conduit_major\Glad-m25\Hoggar_200_g.csv';
'conduit_major\Glad-m25\Fernando_200_g.csv'};

% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
    [ang{i},dep{i}] = cal_angle(f{i}(:,1),f{i}(:,2),f{i}(:,3));
end
%%
clear all
% load semucb
filenames = {
'conduit_major/SEMUCB/EAR_200.csv';
'conduit_major/SEMUCB/Easter_200.csv';
'conduit_major/SEMUCB/Iceland_200.csv';
'conduit_major/SEMUCB/Tristan_200.csv';
'conduit_major/SEMUCB/Louisville_200.csv';
'conduit_major/SEMUCB/Reunion_200.csv';
'conduit_major/SEMUCB/Hawaii_200.csv';
'conduit_major/SEMUCB/Samoa_200.csv';
'conduit_major/SEMUCB/Tahiti_200.csv';
'conduit_major/SEMUCB/Mac_200.csv';
'conduit_major/SEMUCB/Pitcairn_200.csv';
'conduit_major/SEMUCB/Gala_200.csv';
'conduit_major/SEMUCB/Marquesas_200.csv';
'conduit_major/SEMUCB/Kerguelen_200.csv';
'conduit_major/SEMUCB/Caroline_200.csv';
'conduit_major/SEMUCB/Juan_Fer_200.csv';
'conduit_major/SEMUCB/San_Felix_200.csv';
'conduit_major/SEMUCB/Marion_200.csv';
'conduit_major/SEMUCB/Meteor_200.csv';
'conduit_major/SEMUCB/Vema_200.csv';
'conduit_major/SEMUCB/Trindade_200.csv';
'conduit_major/SEMUCB/St_H_200.csv';
'conduit_major/SEMUCB/Cape_200.csv';
'conduit_major/SEMUCB/Canary_200.csv';
'conduit_major/SEMUCB/Azores_200.csv';
% fn26 = 'conduit_major/JM_200_g.csv';
'conduit_major/SEMUCB/Hoggar_200.csv'};
% fn28 = 'conduit_major/SEMUCB/Fernando_200.csv';

% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
    [ang{i},dep{i}] = cal_angle(f{i}(:,1),f{i}(:,2),f{i}(:,3));
end
%%
plume_name = {
    'EAR';'Easter';'Iceland';'Tristan';'Louisville';'Reunion';'Hawaii';'Samoa';'Tahiti';
    'Macdonald';'Pitcairn';'Galapagos';'Marquesas';'Kerguelen';'Caroline';'Juan Fer';'San Felix';
    'Marion';'Meteor';'Vema';'Trindade';'St Helena';'Cape Verde';'Canary';'Azores';'Jan Mayen';
    'Hoggar';'Fernando'};
indx_m = [11 33 35 44 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 31 30 42 6 5 1 17];
y = linspace(0,3000,100);
% pacific
figure(1)
j=1;
for i=1:26
    if i == 2 || i==7 || i==8 || i==9 || i==10 || i==11 || i==13 || i==12 
    subplot(2,4,j)
    plot(tilt(indx_m(i)).ang,tilt(indx_m(i)).dep,'Marker','o','MarkerSize',2,'MarkerFaceColor','#0072BD')
    hold on
    plot(ang{i},dep{i},'Marker','diamond','MarkerSize',2,'MarkerFaceColor','#D95319')
    hold on
    plot(ones(length(y))*60,y,'Color',[.7 .7 .7])
    if j==1 || j==5
       ylabel('depth (km)');
    elseif j==8
       legend('model','picked')
    end
    title(plume_name(i))
    xlabel('tilted angle')
    ylim([0 3000])
    xlim([0 100])
    xticks([0 25 50 75 100])
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end
% atlantic
figure(2)
j=1;
for i=1:26
    if i == 3 || i==22 || i==23 || i==24
    subplot(1,4,j)
    plot(tilt(indx_m(i)).ang,tilt(indx_m(i)).dep,'Marker','o','MarkerSize',2,'MarkerFaceColor','#0072BD')
    hold on
    plot(ang{i},dep{i},'Marker','diamond','MarkerSize',2,'MarkerFaceColor','#D95319')
    hold on
    plot(ones(length(y))*60,y,'Color',[.7 .7 .7])
    if j==1
       ylabel('depth (km)');
    elseif j==4
       legend('model','picked')
    end
    title(plume_name(i))
    xlabel('tilted angle')
    ylim([0 3000])
    xlim([0 100])
    xticks([0 25 50 75 100])
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end
%%
% load Steinberger model conduits
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
% calculate angles
for i=1:length(plumes_model)
    [t(i).x,t(i).y,t(i).z]=sph2cart(plumes_model(i).lon/180*pi,plumes_model(i).lat/180*pi,plumes_model(i).r);
    [tilt(i).ang,tilt(i).dep] = cal_angle(t(i).x,t(i).y,t(i).z);
    tilt(i).name = plumes_model(i).shortname;
end
%%
figure(1)
for i = 1:length(tilt)
    if i<2 || i<8 && i>3 || i==11 || i<20 && i>13 || i>20 && i<25 || i>29 && i<39 || i>39 
scatter(tilt(i).ang,tilt(i).dep,'Marker','.','SizeData',100);
hold on
    end
end
x=60*ones(30,1);y=linspace(-500,3000,30);
plot(x,y,'k-')
axis ij
% legend(tilt.name)
xlabel('Tilted Angle (deg)','FontSize',14);ylabel('Depth (km)','FontSize',14);
ylim([0 3000])

k = 0;
for i = 1:length(tilt)
    for j = 1:length(tilt(i).ang)
        k = k + 1;
        tilt_ang(k) = tilt(i).ang(j);
    end
end
figure(2)
% histogram(tilt_ang+1e-6,14,'Normalization','probability')
% hold on
[N,edges] = histcounts(tilt_ang+1e-6,14);
% pd = fitdist((tilt_ang+1e-6)','Logistic');
% y = pdf(pd,tilt_ang');
% plot(tilt_ang',y)
histfit_normalized(tilt_ang,14,'logistic')
xlim([0 180])

%%
% calculate distance from vertical plume
% input the lon, lat of surface location of plumes
plume_name = {
    'EAR';'Easter';'Iceland';'Tristan';'Louisville';'Reunion';'Hawaii';'Samoa';'Tahiti';
    'Macdonald';'Pitcairn';'Galapagos';'Marquesas';'Kerguelen';'Caroline';'Juan Fer';'San Felix';
    'Marion';'Meteor';'Vema';'Trindade';'St Helena';'Cape Verde';'Canary';'Azores';'Jan Mayen';
    'Hoggar';'Fernando'};
h = {};j=1;
for i=1:26
    [h{i}.lon(:),h{i}.lat(:),h{i}.r(:)] = cart2sph(f{i}(:,1),f{i}(:,2),f{i}(:,3));
    lon_ver = ones(length(f{i}(:,1)),1)*h{i}.lon(1);
    lat_ver = ones(length(f{i}(:,1)),1)*h{i}.lat(1);
    [x_ver,y_ver,z_ver] = sph2cart(lon_ver,lat_ver,h{i}.r(:));
    % angle between two vectors
    dot_pro = x_ver.*f{i}(:,1) + y_ver.*f{i}(:,2) + z_ver.*f{i}(:,3);
    magnitude = sqrt(x_ver.^2+y_ver.^2+z_ver.^2) .* sqrt(f{i}(:,1).^2+f{i}(:,2).^2+f{i}(:,3).^2);
    theta = acos(dot_pro./magnitude);% in radians
    h{i}.distance(:) = h{i}.r(:) * 6371 .* theta;
%     if i == 3 || i==7 || i==8 || i==9 || i==10 || i==11 || i==13 || i==23 || i==24
%         subplot(2,5,j)
%         plot(h{i}.distance,(1-h{i}.r)*6371,'Marker','o','MarkerSize',2,'MarkerFaceColor','#0072BD')
%         title(plume_name(i))
%         xlabel('Distance (km)')
%         if j==1 || j==6
%            ylabel('depth (km)');
%         end
%         ylim([0 3000])
%         xlim([0 1500])
%         set(gca,'Ydir','reverse');
%         j=j+1;
%     end
end
%%
% plot distance and tilted angle in one diagram
j=1;
indx_m = [11 33 35 44 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 31 30 42 6 5 1 17];
y = linspace(0,3000,100);
 
for i=1:7
    if i == 3 || i==7 || i==8 || i==9 || i==10 || i==11 || i==13 || i==23 || i==24
        subplot(2,5,j);
        ax1 = gca;
        plot(h{i}.distance,(1-h{i}.r)*6371,'Marker','o','MarkerSize',2,'MarkerFaceColor','#77AC30','Color','#77AC30','Parent',ax1)
        xlabel('Distance (km)')
        ylim(ax1,[0 3000])
        xlim(ax1,[0 1500])
        set(gca,'Ydir','reverse');
        set(gca, 'XAxisLocation', 'top')
        set(gca, 'YColor', 'none')
        title(ax1,plume_name(i))
        hold on
        ax1_pos = ax1.Position; % position of first axes
        ax2 = axes('Position',ax1_pos,...
                    'XAxisLocation','bottom',...
                    'YAxisLocation','left',...
                    'Color','none');
        plot(ax2,tilt(indx_m(i)).ang,tilt(indx_m(i)).dep,'Marker','o','MarkerSize',2,'MarkerFaceColor','#0072BD')
        hold on
        plot(ax2,ang{i},dep{i},'Marker','diamond','MarkerSize',2,'MarkerFaceColor','#D95319')
        hold on
        plot(ax2,ones(length(y))*60,y,'Color',[.7 .7 .7])
        xlabel('Tilted angle')
        if j==1 || j==6
           ylabel('depth (km)');
        end
        ylim(ax2,[0 3000])
        xlim(ax2,[0 100])
        xticks(ax2,[0 25 50 75 100])
        set(gca,'Ydir','reverse');
        j=j+1;
    end
end

% function to calculate tilted angles at the midpoint of two control points
function [angle,depth] = cal_angle(x,y,z)
    angle = zeros(length(x),1);
    depth = zeros(length(x),1);
    depth(1) = (1-sqrt(x(1)^2+y(1)^2+z(1)^2))*6371;
    for i = 2:length(x)
        % angle = acos(X(i) dot Y(i)/|X||Y|)
        angle(i) = acosd((x(i)*(x(i-1)-x(i))+y(i)*(y(i-1)-y(i))+z(i)*(z(i-1)-z(i)))/...
            (sqrt(x(i)^2+y(i)^2+z(i)^2)*sqrt((x(i-1)-x(i))^2+(y(i-1)-y(i))^2+(z(i-1)-z(i))^2)));
        a = (x(i)+x(i-1))/2;
        b = (y(i)+y(i-1))/2;
        c = (z(i)+z(i-1))/2;
        depth(i) = (1-sqrt(a^2+b^2+c^2))*6371;
    end
end