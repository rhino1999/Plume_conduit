% tilted angle calculation
% load glad-m25
filenames1 = {
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

% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames1)
    f1{i} = readmatrix(filenames1{i});
    % calculate tilted angle for traced conduits
    [ang1{i},dep1{i}] = cal_angle(f1{i}(:,1),f1{i}(:,2),f1{i}(:,3));
end

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

% Load each file and save the matrix into a cell array (called f)
for i = 1:length(filenames)
    f{i} = readmatrix(filenames{i});
    % calculate tilted angle for traced conduits
    [ang{i},dep{i}] = cal_angle(f{i}(:,1),f{i}(:,2),f{i}(:,3));
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

% calculate angles along modeled conduits
for i=1:length(plumes_model)
    [t(i).x,t(i).y,t(i).z]=sph2cart(plumes_model(i).lon/180*pi,plumes_model(i).lat/180*pi,plumes_model(i).r);
    [tilt(i).ang,tilt(i).dep] = cal_angle(t(i).x,t(i).y,t(i).z);
    tilt(i).name = plumes_model(i).shortname;
end
%%
plume_name = {
    'Azores';'Canary';'Cape Verde';'Caroline';'EAR';'Easter';'Galapagos';
    'Hawaii';'Hoggar';'Iceland';'Juan Fernandez';'Kerguelen';'Louisville';
    'Macdonald';'Marion';'Marquesas';'Meteor';'Pitcairn';'Reunion';
    'Samoa';'San Felix';'St Helena';'Tahiti';'Trindade';'Tristan';'Vema'};

indx_m = [1 5 6 7 11 33 15 34 17 35 19 36 37 21 38 22 23 24 40 41 26 42 43 30 44 31];% semucb(26)
y = linspace(0,3000,100);
% pacific
fig1 = figure(1);
fig1.Position = [71.4,100,1000,620];
j=1;k=1;
ww = linspace(0,100,100);dd = ones(1,100);
[han,pos] = tight_subplot(2,5,[0.14 0.02],0.08,0.08);
for i=1:26
    if i == 1 || i==2 || i==3 || i==4 || i==6 || i==7 || i==8 || i==10 || i==11 || i==12
        % match plume order in SEMUCB and GLAD
        i_list = [1 2 3 4 6 8 9 11 12 14];
        i1 = i_list(k);
        k=k+1;
    axes(han(j));
    a = han(j);
    plot(ones(length(y))*60,y,'Color',[.7 .7 .7])
    hold on
    plot(ww,410*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(ww,660*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)    
    hold on
    plot(ww,1250*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(ww,2500*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(tilt(indx_m(i)).ang,tilt(indx_m(i)).dep,'Marker','o','MarkerSize',2,'MarkerFaceColor',[0 0.4470 0.7410],'color',[0 0.4470 0.7410],"LineWidth",1.5)
    hold on
    plot(ang{i},dep{i},'Marker','o','MarkerSize',2,'MarkerFaceColor',[0.8500 0.3250 0.0980],'Color',[0.8500 0.3250 0.0980],"LineWidth",1.5)
    hold on
    plot(ang1{i1},dep1{i1},'Marker','o','MarkerSize',2,'MarkerFaceColor','#EDB120','Color','#EDB120',"LineWidth",1.5,"LineStyle","--")    
    yticks([0 410 660 1250 2500 3000])
    a.YTickLabel = '';
    if j==1 || j==6
       ylabel('depth (km)',"FontSize",14);
       a.YTickLabel = [0 410 660 1250 2500 3000];
    end
    title(plume_name(i),"FontSize",16)
    xlabel('tilted angle',"FontSize",14)
    ylim([0 3000]);xlim([0 100])
    xticks([0 30 60 90])
    a.Box = "on";
    a.TickLength = [0.02,0.025];a.FontSize = 12;
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end

% atlantic
fig2 = figure(2);
fig2.Position = [71.4,100,1000,620];
j=1;k=1;
[han1,pos1] = tight_subplot(2,5,[0.14 0.02],0.08,0.08);
for i=1:26
    if i==13 || i ==14 || i==16 || i==18 || i==19 || i==20 || i==21 || i==22 || i==23 || i==25
        % match plume order in SEMUCB and GLAD
        i_list = [15 16 18 20 21 22 23 24 25 26];
        i1 = i_list(k);
        k=k+1;
    axes(han1(j));
    a = han1(j);
    plot(tilt(indx_m(i)).ang,tilt(indx_m(i)).dep,'Marker','o','MarkerSize',2,'MarkerFaceColor',[0 0.4470 0.7410],'Color',[0 0.4470 0.7410],"LineWidth",1.5)
    hold on
    plot(ang{i},dep{i},'Marker','o','MarkerSize',2,'MarkerFaceColor',[0.8500 0.3250 0.0980],'color',[0.8500 0.3250 0.0980],"LineWidth",1.5)
    hold on
    plot(ang1{i1},dep1{i1},'Marker','o','MarkerSize',2,'MarkerFaceColor','#EDB120','Color','#EDB120',"LineWidth",1.5,"LineStyle","--")
    hold on
    plot(ones(length(y))*60,y,'Color',[.7 .7 .7])
    hold on
    plot(ww,410*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(ww,660*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)    
    hold on
    plot(ww,1250*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    plot(ww,2500*dd,"LineStyle",":",'color',[0.5 0.5 0.5],'LineWidth',0.5)
    hold on
    yticks([0 410 660 1250 2500 3000])
    a.YTickLabel = '';
    if j==1 || j==6
       ylabel('depth (km)',"FontSize",14);
       a.YTickLabel = [0 410 660 1250 2500 3000];
%     elseif j==1
%        legend('model','SEMUCB','GLAD',"FontSize",14)
%        a.Legend.Orientation = 'horizontal';
%        a.Legend.Position= [0.4 0.03 0.2 0.02];
%        a.Legend.FontSize = 13;
    end
    title(plume_name(i),"FontSize",16)
    xlabel('tilted angle',"FontSize",14)
    ylim([0 3000]);xlim([0 100])
    xticks([0 30 60 90])
    a.Box = "on";
    a.TickLength = [0.02,0.025];a.FontSize = 12;
    set(gca,'Ydir','reverse');
    j=j+1;
    end
end
%%
% calculate offset distance and azimuth from vertical plume
% input the lon, lat of surface location of plumes
surface_lonlatr(1,:) = [-28.4 38.5 1]; % Azores
surface_lonlatr(2,:) = [-18 28 1];% Canary
surface_lonlatr(3,:) = [-24 15 1]; % Cape Verde
surface_lonlatr(4,:) = [164 5 1];% Caroline
surface_lonlatr(5,:) = [34 6 1]; % East Africa
surface_lonlatr(6,:) = [-109.3 -27.1 1]; % Easter
surface_lonlatr(7,:) = [-91.5 -0.4 1]; % Galapagos
surface_lonlatr(8,:) = [-155.58 19.90 1]; % hawaii
surface_lonlatr(9,:) = [6 23 1];% Hoggar
surface_lonlatr(10,:) = [-19 65 1]; % Iceland
surface_lonlatr(11,:) = [-82 -34 1]; % Juan Fernandez
surface_lonlatr(12,:) = [69 -49 1]; % Kerguelen
surface_lonlatr(13,:) = [-138 -51 1]; % Louisville
surface_lonlatr(14,:) = [-140.2 -29 1]; % Macdonald 
surface_lonlatr(15,:) = [37.8 -46.9 1]; % Marion
surface_lonlatr(16,:) = [-138 -11 1]; % Marquesas
surface_lonlatr(17,:) = [1 -52 1]; % Meteor
surface_lonlatr(18,:) = [-129 -25 1]; % Pitcairn
surface_lonlatr(19,:) = [55.7 -21.2 1]; % Reunion
surface_lonlatr(20,:) = [-168 -15 1]; % Samoa
surface_lonlatr(21,:) = [-80 -26 1]; % San Felix
surface_lonlatr(22,:) = [-10 -17 1]; % St Helena
surface_lonlatr(23,:) = [-148.1 -17.9 1]; % Tahiti
surface_lonlatr(24,:) = [-28.8 -20.5 1]; % Trindade
surface_lonlatr(25,:) = [-11 -38 1]; % Tristan
surface_lonlatr(26,:) = [4 -33 1]; % Vema

plume_name = {
    'Azores';'Canary';'Cape Verde';'Caroline';'EAR';'Easter';'Galapagos';
    'Hawaii';'Hoggar';'Iceland';'Juan_Fer';'Kerguelen';'Louisville';
    'Macdonald';'Marion';'Marquesas';'Meteor';'Pitcairn';'Reunion';
    'Samoa';'San_Felix';'St Helena';'Tahiti';'Trindade';'Tristan';'Vema'}; % semucb

h = {};h1={};h2={};
m=1;
indx_m = [1 5 6 7 11 33 15 34 17 35 19 36 37 21 38 22 23 24 40 41 26 42 43 30 44 31];% semucb(26)
for i=1:26
    if i == 1 || i==2 || i==3 || i==4 || i==6 || i==7 || i==8 || i==10 || i==11 || i==12 || i==13 || i ==14 || i==16 || i==18 || i==19 || i==20 || i==21 || i==22 || i==23 || i==25
    i_list = [1 2 3 4 6 8 9 11 12 14 15 16 18 20 21 22 23 24 25 26];
    i1 = i_list(m);
    m=m+1;
    [h{i}.lon(:),h{i}.lat(:),h{i}.r(:)] = cart2sph(f{i}(:,1),f{i}(:,2),f{i}(:,3));
    [h1{i1}.lon(:),h1{i1}.lat(:),h1{i1}.r(:)] = cart2sph(f1{i1}(:,1),f1{i1}(:,2),f1{i1}(:,3));
    h2{i}.lon(:)=plumes_model(indx_m(i)).lon(:);
    h2{i}.lat(:)=plumes_model(indx_m(i)).lat(:);
    h2{i}.r(:)= plumes_model(indx_m(i)).r(:);
    len = length(h{i}.r(:));len1 = length(h1{i1}.r(:));len2 = length(h2{i}.r(:));
    lon_ver = ones(len,1)*h{i}.lon(1);
    lat_ver = ones(len,1)*h{i}.lat(1);
    lon_ver1 = ones(len1,1)*h1{i1}.lon(1);
    lat_ver1 = ones(len1,1)*h1{i1}.lat(1);
    lon_ver2 = ones(len2,1)*surface_lonlatr(i,1);
    lat_ver2 = ones(len2,1)*surface_lonlatr(i,2);
    [arclen2,az2] = distance(lat_ver2,lon_ver2,h2{i}.lat(:),h2{i}.lon(:),'degrees');
    [arclen,az] = distance(lat_ver,lon_ver,h{i}.lat(:),h{i}.lon(:),'radians');
    [arclen1,az1] = distance(lat_ver1,lon_ver1,h1{i1}.lat(:),h1{i1}.lon(:),'radians');
    % Treatment :(
    % TC Treatments(Order should NOT change!!)
    % only for glad
    if i1==11
        az1(2) = az1(2)-2*pi;
    end

    for k = 2:len-1
        if az(k+1)-az(k)>1.1*pi
            az(k+1) = az(k+1)-2*pi;
        elseif az(k+1)-az(k)<-1.1*pi
            az(k+1) = az(k+1)+2*pi;
        end
    end
    for k = 2:len1-1
        if az1(k+1)-az1(k)>1.1*pi
            az1(k+1) = az1(k+1)-2*pi;
        elseif az1(k+1)-az1(k)<-1.1*pi
            az1(k+1) = az1(k+1)+2*pi;
        end
    end
    % only for semucb
    if i==1
        az = az+2*pi;
    end

% MC treatments
    if i == 20  && az2(1)>=270 % semucb
        az2(1) = az2(1)-360;
    end

    for k = 1:len2-1      
        if az2(k+1)-az2(k)>190
            az2(k+1) = az2(k+1)-360;
        elseif az2(k+1)-az2(k)<-190
            az2(k+1) = az2(k+1)+360;
        end
    end
    
    % modeled conduits
    h2{i}.azimuth(:) = az2;
    h2{i}.distance(:) = arclen2;
    % TC from SEMUCB
    h{i}.azimuth(:) = az*180/pi;
    h{i}.distance(:) = arclen/pi*180;
    % TC from glad
    h1{i1}.azimuth(:) = az1*180/pi;
    h1{i1}.distance(:) = arclen1/pi*180;
    end
end

% plot distance and azimuth in one diagram
j=1;k=1;
fig3 = figure(3);
fig3.Position = [71.4,123.4,1000,620];
for i=1:26
    if i == 1 || i==2 || i==3 || i==4 || i==6 || i==7 || i==8 || i==10 || i==11 || i==12 
        i_list = [1 2 3 4 6 8 9 11 12 14];
        i1 = i_list(k);
        k=k+1;
        subplot(2,5,j);
        ax1 = gca;
        if j<6
            a=0.09+(j-1)*0.175;
            b=0.53;
        else
            a = 0.09+(j-6)*0.175;
            b=0.13;
        end
        ax1.Position = [a,b,0.155,0.34];        
        plot(ax1,h2{i}.distance,(1-h2{i}.r)*6371,'LineStyle','-','LineWidth',2,'Color','#77AC30','Parent',ax1)
        hold on
        plot(ax1,h{i}.distance,(1-h{i}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','#77AC30',"LineStyle","-",'Color','#77AC30','Parent',ax1)
        hold on
        plot(ax1,h1{i1}.distance,(1-h1{i1}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','none',"LineStyle","--",'Color','#77AC30','Parent',ax1)
        ax1_pos = ax1.Position;
        ax1.XColor = '#77AC30';
        ax1.Box = "off";
        yticks(ax1,[0 410 660 1250 2500 3000])
        xticks(ax1,[0 5 10 15 20])
        ax1.YTickLabel = '';
        ax1.XTickLabel = '';
        if j>5
            xlabel('Distance (deg)','FontSize',14)
            ax1.XTickLabel = [0 5 10 15 20];
        end
        ax1.TickLength = [0.02,0.025];ax1.FontSize = 12;
        ylim(ax1,[0 3000])
        xlim(ax1,[0 25])
        set(gca,'Ydir','reverse');
        
        ax2 = axes('Position',ax1_pos);
        plot(ax2,h2{i}.azimuth,(1-h2{i}.r)*6371,'LineStyle','-','LineWidth',2,'Color','#0072BD','Parent',ax2,'Color','#0072BD')
        hold on
        plot(ax2,h{i}.azimuth,(1-h{i}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','#0072BD',"LineStyle","-",'Color','#0072BD','Parent',ax2,'Color','#0072BD')
        hold on
        plot(ax2,h1{i1}.azimuth,(1-h1{i1}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','none',"LineStyle","--",'Color','#0072BD','Parent',ax2,'Color','#0072BD')
        ax2.XAxisLocation ='top';
        ax2.XColor = '#0072BD';
        ax2.Color = 'none';
        ylim(ax2,[0 3000])
        xlim(ax2,[-90 450])
        yticks(ax2,[0 410 660 1250 2500 3000])
        xticks(ax2,[-90 0 90 180 270 360 450])
        ax2.YTickLabel = '';
        ax2.XTickLabel = '';
        set(gca,'Ydir','reverse');
        if j<=5
            xlabel('Azimuth (deg)','FontSize',14)
            ax2.XTickLabel = [270 0 90 180 270 360 90];
        end
        ax2.Box = "off";
        if j==1 || j==6
           ylabel('depth (km)','FontSize',14);
           ax2.YTickLabel = [0 410 660 1250 2500 3000];
        end
        ax2.TickLength = [0.02,0.025];ax2.FontSize = 11;
        j=j+1;
%         title(ax2,plume_name(i))
        ax1.Position = ax2.Position;
    end
end
% legend(ax1,'model','picked')
% ax1.Legend.Orientation = 'vertical';
% ax1.Legend.Position= [0.8 0.5 0.1 0.1];
% ax1.Legend.FontSize = 12;

fig4 = figure(4);
fig4.Position = [71.4,123.4,1000,620];
j=1;k=1;
for i=1:26
    if i==13 || i ==14 || i==16 || i==18 || i==19 || i==20 || i==21 || i==22 || i==23 || i==25
        i_list = [15 16 18 20 21 22 23 24 25 26];
        i1 = i_list(k);
        k=k+1;
        subplot(2,5,j)
        ax1 = gca;
        if j<6
            a=0.09+(j-1)*0.175;
            b=0.53;
        else
            a = 0.09+(j-6)*0.175;
            b=0.13;
        end
        ax1.Position = [a,b,0.155,0.34];
        plot(ax1,h2{i}.distance,(1-h2{i}.r)*6371,'LineStyle','-','LineWidth',2,'Color','#77AC30','Parent',ax1)
        hold on
        plot(ax1,h{i}.distance,(1-h{i}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','#77AC30',"LineStyle","-",'Color','#77AC30','Parent',ax1)
        hold on
        plot(ax1,h1{i1}.distance,(1-h1{i1}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','none',"LineStyle","--",'Color','#77AC30','Parent',ax1)
        ax1_pos = ax1.Position;
        ax1.XColor = '#77AC30';
        ax1.Box = "off";
        yticks(ax1,[0 410 660 1250 2500 3000])
        xticks(ax1,[0 5 10 15 20])
        ax1.YTickLabel = '';
        ax1.XTickLabel = '';
        if j>5
            xlabel('Distance (deg)','FontSize',14)
            ax1.XTickLabel = [0 5 10 15 20];
        end
        ylim(ax1,[0 3000])
        xlim(ax1,[0 25])
        set(gca,'Ydir','reverse');
        ax1.TickLength = [0.02,0.025];ax1.FontSize = 12;
        
        ax2 = axes('Position',ax1_pos);
        plot(ax2,h2{i}.azimuth,(1-h2{i}.r)*6371,'LineStyle','-','LineWidth',2,'Color','#0072BD','Parent',ax2,'Color','#0072BD')
        hold on
        plot(ax2,h{i}.azimuth,(1-h{i}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','#0072BD',"LineStyle","-",'Color','#0072BD','Parent',ax2,'Color','#0072BD')
        hold on
        plot(ax2,h1{i1}.azimuth,(1-h1{i1}.r)*6371,'Marker','o','MarkerSize',3,'MarkerFaceColor','none',"LineStyle","--",'Color','#0072BD','Parent',ax2,'Color','#0072BD')
        ax2.XAxisLocation ='top';
        ax2.XColor = '#0072BD';
        ax2.Color = 'none';
        ylim(ax2,[0 3000])
        xlim(ax2,[-90 450])
        yticks(ax2,[0 410 660 1250 2500 3000])
        xticks(ax2,[-90 0 90 180 270 360 450])
        ax2.YTickLabel = '';
        ax2.XTickLabel = '';
        set(gca,'Ydir','reverse');
        if j<=5
            xlabel('Azimuth (deg)','FontSize',14)
            ax2.XTickLabel = [270 0 90 180 270 360 90];
        end
        ax2.Box = "off";
        if j==1 || j==6
           ylabel('depth (km)','FontSize',14);
           ax2.YTickLabel = [0 410 660 1250 2500 3000];
        end
        ax2.TickLength = [0.02,0.025];ax2.FontSize = 11;
        j=j+1;
%         title(ax2,plume_name(i))
        ax1.Position = ax2.Position;
    end
end
legend(ax1,'Model','SEMUCB-WM1','GLAD-M25')
legend(ax2,'Model','SEMUCB-WM1','GLAD-M25')
ax1.Legend.Orientation = 'horizontal';
ax1.Legend.Position= [0.3 0.5 0.4 0.05];
ax1.Legend.FontSize = 12;
ax2.Legend.Orientation = 'horizontal';
ax2.Legend.Position= [0.3 0.7 0.4 0.05];
ax2.Legend.FontSize = 12;
%%
exportgraphics(fig1,'figure\angle\prim_angle_1.pdf')
exportgraphics(fig2,'figure\angle\prim_angle_2.pdf')
exportgraphics(fig3,'figure\angle\prim_dist_1.pdf')
exportgraphics(fig4,'figure\angle\prim_dist_2.pdf')


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