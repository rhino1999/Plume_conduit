clear all
% note - this is the path to the plume-discovery files:
addpath ../
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
%%
clear all
addpath ../
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
% 'conduit_major\Glad-m25\St_H_200_g.csv';
'conduit_major\Glad-m25\Cape_200_g.csv';
'conduit_major\Glad-m25\Canary_200_g.csv';
'conduit_major\Glad-m25\Azores_200_g.csv';
'conduit_major\Glad-m25\JM_200_g.csv';
'conduit_major\Glad-m25\Hoggar_200_g.csv';
'conduit_major\Glad-m25\Fernando_200_g.csv'};
%%
% x, y, z [0,1]
% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
end
%%
% convert each plume from xyz to lon,lat,depth.
% store each plume as a PlumeConduit object for later use.
plumes = {}; % cell array to hold plumes
for i=1:length(filenames)
    xyz = f{i};
    r = sqrt(xyz(:,1).^2+xyz(:,2).^2+xyz(:,3).^2);
    lon = atan2d(xyz(:,2),xyz(:,1));
    lat = asind(xyz(:,3)./r);
    depth = 6371*(1.0-r);
    plumes{i} = PlumeConduit(lon,lat,depth);
end

% load Steinberger model conduits
dirs = {'Steinberger_Antretter_Plumes (1)\Steinberger_Antretter_Plumes\44_ms',...
    'Steinberger_Antretter_Plumes (1)\Steinberger_Antretter_Plumes\12_ms'};
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

for i=1:length(plumes_model)
    xyz = plumes_model(i);
    depth = 6371*(1.0-xyz.r);
    plumes_stn{i} = PlumeConduit(xyz.lon,xyz.lat,depth);
end
semucb = TomographicModel(); % load SEMUCB-WM1 as a tomographic model object
%% Calculate Vs along a plume conduit:
i = 11; %hawaii = 7
j = 24;
interpolation_depths = linspace(plumes_stn{j}.depth(1),plumes_stn{j}.depth(end),200);
plume_Vs = plumes{i}.calculateVs(semucb,interpolation_depths);
interpolation_depths_stn = linspace(plumes_stn{j}.depth(1),plumes_stn{j}.depth(end),200);
plume_Vs_stn = plumes_stn{j}.calculateVs(semucb,interpolation_depths_stn);
% plot Vs vs. depth for this plume conduit
figure, plot(plume_Vs,interpolation_depths);
xlabel('Vs');
ylabel('depth (km)');
set(gca,'Ydir','reverse');
hold on
% steinberger plume under hawaii
plot(plume_Vs_stn,interpolation_depths_stn)
legend('picked','model')
%% Boschi et al., 2007
% calculate slowness for all (picked-model)/model Vs
indx_p = 26;
indx_m = [11 33 35 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 30 6 5 1 18 17 14];
% indx_m = [11 33 35 44 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 31 30 42 6 5 1 18 17 14];
% indx_m = [11 33 35 44 37 40 34 41 43 21 24 15 22 36 7 19 26 38 23 31 30 42 6 5 1 17];
i=1;
n = 200;% interpolate points
depth_upper = 250;% in km
depth_lower = 2619;% in km
plume_Vs_avg = zeros(indx_p,1);
plume_Vs_stn_avg = zeros(indx_p,1);
plume_Vs_sum = zeros(1,200);
plume_Vs_sum_stn = zeros(1,200);
plume_Vs_sum_vertical = zeros(1,200);
while i <= indx_p
    j=indx_m(i);
    % picked plumes
    interpolation_depths = linspace(depth_upper,depth_lower,n);
    plume_Vs(i,:) = plumes{i}.calculateVs(semucb,interpolation_depths);
    for i_depth=1:length(interpolation_depths)     % normalized
        x = linspace(-179.5,179.5);
        y = linspace(-90,90);
        [xx,yy] = meshgrid(x,y);
        zz = interpolation_depths(i_depth)*ones(size(xx));
        vs = semucb.evaluate(xx,yy,zz);
        vsmin(i_depth) = min(vs(:));
    end
    plume_Vs_norm(i,:) = -plumes{i}.calculateVs(semucb,interpolation_depths)./vsmin;
    plume_Vs_avg(i) = sum(plume_Vs_norm(i,:))/n;
    % calculate Fig 13 in Boschi et al., 2007
    plume_Vs_sum = plume_Vs_sum + plume_Vs_norm(i,:);

    % vertical
    lon = ones(n,1)*plumes{i}.lon(1);
    lat = ones(n,1)*plumes{i}.lat(1);
    plumes_vertical{i} = PlumeConduit(lon,lat,interpolation_depths);
    vsver(i,:) = plumes_vertical{i}.calculateVs(semucb,interpolation_depths);
    vsver_norm(i,:) = -plumes_vertical{i}.calculateVs(semucb,interpolation_depths)./vsmin;
    plume_Vs_sum_vertical = plume_Vs_sum_vertical + vsver_norm(i,:);

    % steinberger
    plume_Vs_stn_norm(i,:) = -plumes_stn{j}.calculateVs(semucb,interpolation_depths)./vsmin;
    plume_Vs_stn(i,:) = plumes_stn{j}.calculateVs(semucb,interpolation_depths);
    plume_Vs_stn_avg(i) = sum(plume_Vs_stn_norm(i,:))/n;
    plume_Vs_sum_stn = plume_Vs_sum_stn + plume_Vs_stn_norm(i,:);
    i=i+1;
end
plume_Vs_sum = plume_Vs_sum/indx_p;
plume_Vs_sum_stn = plume_Vs_sum_stn/indx_p;
plume_Vs_sum_vertical = plume_Vs_sum_vertical/indx_p;
%%
figure(2)
plot(plume_Vs_stn_avg)
hold on
plot(plume_Vs_avg)
legend('model','picked')
title('Average \delta Vs of 26 plumes')
ylabel('Average \delta Vs%')

figure(3)
plot(plume_Vs_sum_stn,interpolation_depths,'Marker','diamond','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD')
hold on
plot(plume_Vs_sum,interpolation_depths,'Marker','o','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319')
hold on
plot(plume_Vs_sum_vertical,interpolation_depths,'Marker','o','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#77AC30')
legend('model','picked','vertical')
title('Average \delta Vs of 26 plumes along mantle')
xlabel('Mean \delta Vs%')
ylabel('depth (km)');
set(gca,'Ydir','reverse');

%%
plume_name = {
    'EAR';'Easter';'Iceland';'Tristan';'Louisville';'Reunion';'Hawaii';'Samoa';'Tahiti';
    'Macdonald';'Pitcairn';'Gala';'Marquesas';'Kerguelen';'Caroline';'Juan_Fer';'San_Felix';
    'Marion';'Meteor';'Vema';'Trindade';'St Helena';'Cape Verde';'Canary';'Azores';'Jan Mayon';'Hoggar'};

% plume_name = {
%     'EAR';'Easter';'Iceland';'Louisville';'Reunion';'Hawaii';'Samoa';'Tahiti';
%     'Macdonald';'Pitcairn';'Galapagos';'Marquesas';'Kerguelen';'Caroline';'Juan Fer';'San Felix';
%     'Marion';'Meteor';'Trindade';'Cape Verde';'Canary';'Azores';'Jan Mayen';
%     'Hoggar';'Fernando'};

% load referenve dlnVs
ref = readmatrix("conduit_major\foo.csv");

figure(4)
j=1;
for i=1:26
    if i == 12 || i==2 || i==7 || i== 8 || i==9 || i==10 || i==13 || i==11
    subplot(2,4,j)
    plot(plume_Vs_stn(i,:),interpolation_depths,'Marker','diamond','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD')
    hold on
    plot(plume_Vs(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319')
    hold on
    plot(vsver(i,:),interpolation_depths,'Marker','o','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#77AC30')
    hold on
    v = [ref([5,1],:) fliplr(ref([6,1],:))]';
    f = 1:1:360;
    patch("Faces",f,"Vertices",v, "FaceColor",'#4DBEEE', "EdgeColor",'none',"FaceAlpha",0.5)
    if j==1 || j==5
       ylabel('depth (km)');
    elseif j==8
       legend('model','picked','vertical')
    end
    title(plume_name(i))
    xlabel('\delta Vs%')
    xlim([-3 1])
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end

figure(5)
j=1;
for i=1:26
    if i == 3 || i==22 || i==23 || i==24
    subplot(1,4,j)
    plot(plume_Vs_stn(i,:),interpolation_depths,'Marker','diamond','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD')
    hold on
    plot(plume_Vs(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319')
    hold on
    plot(vsver(i,:),interpolation_depths,'Marker','o','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#77AC30')
    hold on
    v = [ref([5,1],:) fliplr(ref([6,1],:))]';
    f = 1:1:360;
    patch("Faces",f,"Vertices",v, "FaceColor",'#4DBEEE', "EdgeColor",'none',"FaceAlpha",0.5)
    if j==1
       ylabel('depth (km)');
    elseif j==4
       legend('model','picked','vertical')
    end
    title(plume_name(i))
    xlabel('\delta Vs%')
    xlim([-3 1])
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end
%%
% clear all
% % load glad-m25
% fn1 = 'conduit_major/Glad-m25/EAR_200_g.csv';
% fn2 = 'conduit_major/Glad-m25/Easter_200_g.csv';
% fn3 = 'conduit_major/Glad-m25/Iceland_200_g.csv';
% fn4 = 'conduit_major/Glad-m25/Tristan_200_g_2.csv';
% fn5 = 'conduit_major/Glad-m25/Louisville_200_g.csv';
% fn6 = 'conduit_major/Glad-m25/Reunion_200_g.csv';
% fn7 = 'conduit_major/Glad-m25/Hawaii_200_g.csv';
% fn8 = 'conduit_major/Glad-m25/Samoa_200_g.csv';
% fn9 = 'conduit_major/Glad-m25/Tahiti_200_g.csv';
% fn10 = 'conduit_major/Glad-m25/Mac_200_g.csv';
% fn11 = 'conduit_major/Glad-m25/Pitcairn_200_g.csv';
% fn12 = 'conduit_major/Glad-m25/Gala_200_g.csv';
% fn13 = 'conduit_major/Glad-m25/Marquesas_200_g.csv';
% fn14 = 'conduit_major/Glad-m25/Kerguelen_200_g.csv';
% fn15 = 'conduit_major/Glad-m25/Caroline_200_g.csv';
% fn16 = 'conduit_major/Glad-m25/Juan_Fer_200_g.csv';
% fn17 = 'conduit_major/Glad-m25/San_Felix_200_g.csv';
% fn18 = 'conduit_major/Glad-m25/Marion_200_g.csv';
% fn19 = 'conduit_major/Glad-m25/Meteor_200_g.csv';
% fn20 = 'conduit_major/Glad-m25/Vema_200_g.csv';
% fn21 = 'conduit_major/Glad-m25/Trindade_200_g.csv';
% fn22 = 'conduit_major/Glad-m25/St_H_200_g.csv';
% fn23 = 'conduit_major/Glad-m25/Cape_200_g.csv';
% fn24 = 'conduit_major/Glad-m25/Canary_200_g.csv';
% fn25 = 'conduit_major/Glad-m25/Azores_200_g.csv';
% fn26 = 'conduit_major/Glad-m25/JM_200_g.csv';
% fn27 = 'conduit_major/Glad-m25/Hoggar_200_g.csv';
% fn28 = 'conduit_major/Glad-m25/Fernando_200_g.csv';
% 
% f1 = readmatrix(fn1);f2 = readmatrix(fn2);
% f3 = readmatrix(fn3);f4 = readmatrix(fn4);
% f5 = readmatrix(fn5);f6 = readmatrix(fn6);
% f7 = readmatrix(fn7);f8 = readmatrix(fn8);
% f9 = readmatrix(fn9);f10 = readmatrix(fn10);
% f11 = readmatrix(fn11);f12 = readmatrix(fn12);
% f13 = readmatrix(fn13);f14 = readmatrix(fn14);
% f15 = readmatrix(fn15);f16 = readmatrix(fn16);
% f17 = readmatrix(fn17);f18 = readmatrix(fn18);
% f19 = readmatrix(fn19);f20 = readmatrix(fn20);
% f21 = readmatrix(fn21);f22 = readmatrix(fn22);
% f23 = readmatrix(fn23);f24 = readmatrix(fn24);
% f25 = readmatrix(fn25);f26 = readmatrix(fn26);
% f27 = readmatrix(fn27);f28 = readmatrix(fn28);

