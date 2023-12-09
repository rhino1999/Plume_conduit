% clear all
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

% x, y, z [0,1]
% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
end

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

for i=1:length(plumes_model)
    xyz = plumes_model(i);
    depth = 6371*(1.0-xyz.r);
    plumes_stn{i} = PlumeConduit(xyz.lon,xyz.lat,depth);
end

semucb = TomographicModel(); % load SEMUCB-WM1/GLAD-M25 as a tomographic model object
%%
% calculate average slowness for conduits
indx_p = 26;
indx_m = [1 5 6 7 11 33 15 34 17 35 19 36 37 21 38 22 23 24 40 41 26 42 43 30 44 31];% semucb(26)
% indx_m = [1 5 6 7 11 33 14 15 34 17 35 19 18 36 37 21 38 22 23 24 40 41 26 42 43 44];% glad(26)

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
    % SEMUCB
    % 20 conduits
    if i == 4 || i==6 || i==7 || i==8 || i== 11 || i==13 || i==14 || i==16 || i==18 || i==20 || i==21 || i==23 || i==1 || i == 2 || i==3 || i==10 || i==12 || i==19 || i==25 || i==22
%     % 12 Pacific
%     if i == 4 || i==6 || i==7 || i==8 || i== 11 || i==13 || i==14 || i==16 || i==18 || i==20 || i==21 || i==23    
%     % 8 African
%     if i==1 || i == 2 || i==3 || i==10 || i==12 || i==19 || i==25 || i==22

%   % GLAD
%   % 20 conduits
%     if i == 4 || i==6 || i==8 || i==9 || i==12 || i==15 || i==16 || i==18 || i==20 || i==22 || i==23 || i==25 || i == 2 || i==3 || i==11 || i==14 || i==24 || i==26 || i==1 || i==21
%   % 12 Pacific
%     if i == 4 || i==6 || i==8 || i==9 || i==12 || i==15 || i==16 || i==18 || i==20 || i==22 || i==23 || i==25
%   % 8 African
%     if i == 2 || i==3 || i==11 || i==14 || i==24 || i==26 || i==1 || i==21

    % traced plumes
    interpolation_depths = linspace(depth_upper,depth_lower,n);
    plume_Vs(i,:) = plumes{i}.calculateVs(semucb,interpolation_depths);
    for i_depth=1:length(interpolation_depths)     
        x = linspace(-179.5,179.5);
        y = linspace(-90,90);
        [xx,yy] = meshgrid(x,y);
        zz = interpolation_depths(i_depth)*ones(size(xx));
        vs = semucb.evaluate(xx,yy,zz);
    end
    % sum up all Vs
    plume_Vs_sum = plume_Vs_sum + plume_Vs(i,:);

    % vertical
    lon = ones(n,1)*plumes{i}.lon(1);
    lat = ones(n,1)*plumes{i}.lat(1);
    plumes_vertical{i} = PlumeConduit(lon,lat,interpolation_depths);
    vsver(i,:) = plumes_vertical{i}.calculateVs(semucb,interpolation_depths);
    plume_Vs_sum_vertical = plume_Vs_sum_vertical + vsver(i,:);

    % steinberger
    plume_Vs_stn(i,:) = plumes_stn{j}.calculateVs(semucb,interpolation_depths);
    plume_Vs_sum_stn = plume_Vs_sum_stn + plume_Vs_stn(i,:);
    end
    i=i+1;
end
plume_Vs_sum = plume_Vs_sum/20;% divided by the number of conduits
plume_Vs_sum_stn = plume_Vs_sum_stn/20;
plume_Vs_sum_vertical = plume_Vs_sum_vertical/20;
%%
% ploting average slowness
fig1 = figure(1);
fig1.Position = [200 150 260 580];
a = axes;
plot(plume_Vs_sum_stn,interpolation_depths,'Marker','diamond','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD')
hold on
plot(plume_Vs_sum,interpolation_depths,'Marker','o','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319')
hold on
plot(plume_Vs_sum_vertical,interpolation_depths,'Marker','o','MarkerSize',4,'MarkerIndices',1:10:200,'MarkerFaceColor','#EDB120')
% legend('model','picked','vertical',"FontSize",12)
% title('Average \delta Vs of 15 plumes from GLAD-M25 in SEMUCB-WM1')
% xlabel('Avg \deltaVs/|\deltaVs_{min}|',"FontSize",13)
xlabel('Avg \deltaVs(%)',"FontSize",13)
% ylabel('depth (km)','FontSize',13)
xlim([-1.75 0.25]);ylim([0 3000])
a.FontSize = 12;
yticks([0 410 660 1250 2500 3000]);
xticks([-1.5 -1.25 -1 -.75 -.5 -.25 0]);
a.YTickLabel="";
a.XTickLabel=[-1.5,"",-1,"",-0.5,"",0];
set(gca,'Ydir','reverse');
%%
plume_name = {
    'Azores';'Canary';'Cape Verde';'Caroline';'EAR';'Easter';'Galapagos';
    'Hawaii';'Hoggar';'Iceland';'Juan Fernandez';'Kerguelen';'Louisville';
    'Macdonald';'Marion';'Marquesas';'Meteor';'Pitcairn';'Reunion';
    'Samoa';'San Felix';'St Helena';'Tahiti';'Trindade';'Tristan';'Vema'};% semucb

% plume_name = {
%     'Azores';'Canary';'Cape Verde';'Caroline';'EAR';'Easter';'Fernando';'Galapagos';
%     'Hawaii';'Hoggar';'Iceland';'Juan Fernandez';'Jan Mayen';'Kerguelen';'Louisville';
%     'Macdonald';'Marion';'Marquesas';'Meteor';'Pitcairn';'Reunion';
%     'Samoa';'San Felix';'St Helena';'Tahiti';'Tristan'};% glad

% load referenve dlnVs
ref = readmatrix("data/referenVs.csv");
v = [ref([4,1],:) fliplr(ref([5,1],:))]';
dVsdT = ref(2,:);dtrue = ref(1,:);%dnew
face = 1:1:360;

% load Tex ref
tex = readmatrix("data/Tex.csv");
% calculate dVs above 660 km
for i=1:20
    dVs(:,i) = tex(i,2).*ones(length(dVsdT),1).*dVsdT';% dVs_raw
%     dVs(:,i) = interp1(dnew',dVs_raw,dtrue','linear','extrap');
end

fig2 = figure(2);
fig2.Position = [71.4,100,1000,620];
j=1;
ww = linspace(-3.5,1.5,100);dd = ones(1,100);
[han,pos] = tight_subplot(2,5,[0.14 0.02],0.08,0.08);
for i=1:26
    if i == 1 || i==2 || i==3 || i==4 || i==6 || i==7 || i==8 || i==10 || i==11 || i==12 % semucb
%     if i==1 || i==2 || i==3 || i==4 || i==6 || i==8 || i==9 || i==11 || i==12 || i==14 % glad
    axes(han(j));
    a = han(j);
    patch("Faces",face,"Vertices",v, "FaceColor",'#4DBEEE', "EdgeColor",'none',"FaceAlpha",0.5)
    hold on
    plot(plume_Vs_stn(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD',"LineWidth",1)
    hold on
    plot(plume_Vs(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319',"LineWidth",1)
    hold on
    plot(vsver(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#EDB120',"LineWidth",1)
    hold on
    plot(ww,410*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(ww,660*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)    
    hold on
    plot(ww,1250*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    plot(ww,2500*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    if j~=5
        plot(dVs(:,j),dtrue,"LineStyle","-",'color',[0.5 0.5 0.5],'LineWidth',1)
    end
    yticks([0 410 660 1250 2500 3000])
    a.YTickLabel = '';
    if j==1 || j==6 
       ylabel('depth (km)',"FontSize",14);
       a.YTickLabel = [0 410 660 1250 2500 3000];
%     elseif j==3
%        legend('','model','picked','vertical')
%        a.Legend.Orientation = 'horizontal';
%        a.Legend.Position= [0.4 0.03 0.2 0.02];
%        a.Legend.FontSize = 13;
    end
    title(plume_name(i),"FontSize",16)
    xlabel('\delta Vs%',"FontSize",14)
    a.Box = "on";
    a.TickLength = [0.02,0.025];a.FontSize = 12;
    xlim([-3.5 1.5]);xticks([-3 -2 -1 0 1])
    a.XTickLabel = [-3 -2 -1 0 1];
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end

fig3 = figure(3);
fig3.Position = [71.4,100,1000,620];
j=1;
[han1,pos1] = tight_subplot(2,5,[0.14 0.02],0.08,0.08);
for i=1:26
    if i==13 || i ==14 || i==16 || i==18 || i==19 || i==20 || i==21 || i==22 || i==23 || i==25 % semucb
%     if i==15 || i ==16 || i==18 || i==20 || i==21 || i==22 || i==23 || i==24 || i==25 || i==26 % glad
    axes(han1(j));
    a = han1(j);
    patch("Faces",face,"Vertices",v, "FaceColor",'#4DBEEE', "EdgeColor",'none',"FaceAlpha",0.5)
    hold on
    plot(plume_Vs_stn(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD',"LineWidth",1)
    hold on
    plot(plume_Vs(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319',"LineWidth",1)
    hold on
    plot(vsver(i,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#77AC30',"LineWidth",1)
    hold on
    plot(ww,410*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(ww,660*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)    
    hold on
    plot(ww,1250*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    plot(ww,2500*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    if j ~= 2 && j ~= 7
        plot(dVs(:,j+10),dtrue,'color',[0.5 0.5 0.5],'LineWidth',1)
    end
    yticks([0 410 660 1250 2500 3000])
    a.YTickLabel = '';
    if j==1 || j==6
       ylabel('depth (km)',"FontSize",14);
       a.YTickLabel = [0 410 660 1250 2500 3000];
%     elseif j==3
%        legend('','model','picked','vertical')
%        a.Legend.Orientation = 'horizontal';
%        a.Legend.Position= [0.4 0.03 0.2 0.02];
%        a.Legend.FontSize = 13;
    end
    title(plume_name(i),"FontSize",16)
    a.Box = "on";
    xlabel('\delta Vs%',"FontSize",14)
    a.TickLength = [0.02,0.025];a.FontSize = 12;
    xlim([-3.5 1.5]);xticks([-3 -2 -1 0 1])
    a.XTickLabel = [-3 -2 -1 0 1];
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end
%% extract figures
exportgraphics(fig1,'figure\Vs\slow_8_gins.pdf')
exportgraphics(fig2,'figure\Vs\prim_Vs_1_s.pdf')
exportgraphics(fig3,'figure\Vs\prim_Vs_2_s.pdf')