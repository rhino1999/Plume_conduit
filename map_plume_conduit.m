% load semucb
fn1 = 'conduit_major\SEMUCB\EAR_200.csv';
fn2 = 'conduit_major\SEMUCB\Easter_200.csv';
fn3 = 'conduit_major\SEMUCB\Iceland_200.csv';
fn4 = 'conduit_major\SEMUCB\Tristan_200.csv';
fn5 = 'conduit_major\SEMUCB\Louisville_200.csv';
fn6 = 'conduit_major\SEMUCB\Reunion_200.csv';
fn7 = 'conduit_major\SEMUCB\Hawaii_200.csv';
fn8 = 'conduit_major\SEMUCB\Samoa_200.csv';
fn9 = 'conduit_major\SEMUCB\Tahiti_200.csv';
fn10 = 'conduit_major\SEMUCB\Mac_200.csv';
fn11 = 'conduit_major\SEMUCB\Pitcairn_200.csv';
fn12 = 'conduit_major\SEMUCB\Gala_200.csv';
fn13 = 'conduit_major\SEMUCB\Marquesas_200.csv';
fn14 = 'conduit_major\SEMUCB\Kerguelen_200.csv';
fn15 = 'conduit_major\SEMUCB\Caroline_200.csv';
fn16 = 'conduit_major\SEMUCB\Juan_Fer_200.csv';
fn17 = 'conduit_major\SEMUCB\San_Felix_200.csv';
fn18 = 'conduit_major\SEMUCB\Marion_200.csv';
fn19 = 'conduit_major\SEMUCB\Meteor_200.csv';
fn20 = 'conduit_major\SEMUCB\Vema_200.csv';
fn21 = 'conduit_major\SEMUCB\Trindade_200.csv';
fn22 = 'conduit_major\SEMUCB\St_H_200.csv';
fn23 = 'conduit_major\SEMUCB\Cape_200.csv';
fn24 = 'conduit_major\SEMUCB\Canary_200.csv';
fn25 = 'conduit_major\SEMUCB\Azores_200.csv';
% fn26 = 'conduit_major\JM_200.csv';
fn27 = 'conduit_major\SEMUCB\Hoggar_200.csv';
% fn28 = 'conduit_major\SEMUCB\Fernando_200.csv';

% fn1 = 'conduit_major\EAR_200_g.csv';
% fn2 = 'conduit_major\Easter_200_g.csv';
% fn3 = 'conduit_major\Iceland_200_g.csv';
% fn4 = 'conduit_major\Tristan_200_g_2.csv';
% fn5 = 'conduit_major\Louisville_200_g.csv';
% fn6 = 'conduit_major\Reunion_200_g.csv';
% fn7 = 'conduit_major\Hawaii_200_g.csv';
% fn8 = 'conduit_major\Samoa_200_g.csv';
% fn9 = 'conduit_major\Tahiti_200_g.csv';
% fn10 = 'conduit_major\Mac_200_g.csv';
% fn11 = 'conduit_major\Pitcairn_200_g.csv';
% fn12 = 'conduit_major\Gala_200_g.csv';
% fn13 = 'conduit_major\Marquesas_200_g.csv';
% fn14 = 'conduit_major\Kerguelen_200_g.csv';
% fn15 = 'conduit_major\Caroline_200_g.csv';
% fn16 = 'conduit_major\Juan_Fer_200_g.csv';
% fn17 = 'conduit_major\San_Felix_200_g.csv';
% fn18 = 'conduit_major\Marion_200_g.csv';
% fn19 = 'conduit_major\Meteor_200_g.csv';
% fn20 = 'conduit_major\Vema_200_g.csv';
% fn21 = 'conduit_major\Trindade_200_g.csv';
% fn22 = 'conduit_major\St_H_200_g.csv';
% fn23 = 'conduit_major\Cape_200_g.csv';
% fn24 = 'conduit_major\Canary_200_g.csv';
% fn25 = 'conduit_major\Azores_200_g.csv';
% fn26 = 'conduit_major\JM_200_g.csv';
% fn27 = 'conduit_major\Hoggar.csv';
% fn28 = 'conduit_major\Fernando_200_g.csv';


f1 = readmatrix(fn1);f2 = readmatrix(fn2);
f3 = readmatrix(fn3);f4 = readmatrix(fn4);
f5 = readmatrix(fn5);f6 = readmatrix(fn6);
f7 = readmatrix(fn7);f8 = readmatrix(fn8);
f9 = readmatrix(fn9);f10 = readmatrix(fn10);
f11 = readmatrix(fn11);f12 = readmatrix(fn12);
f13 = readmatrix(fn13);f14 = readmatrix(fn14);
f15 = readmatrix(fn15);f16 = readmatrix(fn16);
f17 = readmatrix(fn17);f18 = readmatrix(fn18);
f19 = readmatrix(fn19);f20 = readmatrix(fn20);
f21 = readmatrix(fn21);f22 = readmatrix(fn22);
f23 = readmatrix(fn23);f24 = readmatrix(fn24);
f25 = readmatrix(fn25);%f26 = readmatrix(fn26);
f27 = readmatrix(fn27);%f28 = readmatrix(fn28);
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
% interpolate data by 4 pts
npts = 5;
[xq1,yq1,zq1] = interplt4(f1,npts);
[xq2,yq2,zq2] = interplt4(f2,npts);
[xq3,yq3,zq3] = interplt4(f3,npts);
[xq4,yq4,zq4] = interplt4(f4,npts);
[xq5,yq5,zq5] = interplt4(f5,npts);
[xq6,yq6,zq6] = interplt4(f6,npts);
[xq7,yq7,zq7] = interplt4(f7,npts);
[xq8,yq8,zq8] = interplt4(f8,npts);
[xq9,yq9,zq9] = interplt4(f9,npts);
[xq10,yq10,zq10] = interplt4(f10,npts);
[xq11,yq11,zq11] = interplt4(f11,npts);
[xq12,yq12,zq12] = interplt4(f12,npts);
[xq13,yq13,zq13] = interplt4(f13,npts);
[xq14,yq14,zq14] = interplt4(f14,npts);
[xq15,yq15,zq15] = interplt4(f15,npts);
[xq16,yq16,zq16] = interplt4(f16,npts);
[xq17,yq17,zq17] = interplt4(f17,npts);
[xq18,yq18,zq18] = interplt4(f18,npts);
[xq19,yq19,zq19] = interplt4(f19,npts);
[xq20,yq20,zq20] = interplt4(f20,npts);
[xq21,yq21,zq21] = interplt4(f21,npts);
[xq22,yq22,zq22] = interplt4(f22,npts);
[xq23,yq23,zq23] = interplt4(f23,npts);
[xq24,yq24,zq24] = interplt4(f24,npts);
[xq25,yq25,zq25] = interplt4(f25,npts);
% [xq26,yq26,zq26] = interplt4(f26,npts);
[xq27,yq27,zq27] = interplt4(f27,npts);
% [xq28,yq28,zq28] = interplt4(f28,npts);

% convert into lon, lat, depth
EAR = zeros(length(xq1),3);
EAR(:,1) = atan2d(yq1,xq1);% lon in degree
EAR(:,2) = atan2d(zq1,sqrt(xq1.^2+yq1.^2));% lat in degree
EAR(:,3) = abs((1-sqrt(xq1.^2+yq1.^2+zq1.^2))*6371);% dep in km

Easter = zeros(length(xq2),3);
Easter(:,1) = atan2d(yq2,xq2);% lon in degree
Easter(:,2) = atan2d(zq2,sqrt(xq2.^2+yq2.^2));% lat in degree
Easter(:,3) = abs((1-sqrt(xq2.^2+yq2.^2+zq2.^2))*6371);% dep in km

Iceland = zeros(length(xq3),3);
Iceland(:,1) = atan2d(yq3,xq3);% lon in degree
Iceland(:,2) = atan2d(zq3,sqrt(xq3.^2+yq3.^2));% lat in degree
Iceland(:,3) = abs((1-sqrt(xq3.^2+yq3.^2+zq3.^2))*6371);% dep in km

Tristan = zeros(length(xq4),3);
Tristan(:,1) = atan2d(yq4,xq4);% lon in degree
Tristan(:,2) = atan2d(zq4,sqrt(xq4.^2+yq4.^2));% lat in degree
Tristan(:,3) = abs((1-sqrt(xq4.^2+yq4.^2+zq4.^2))*6371);% dep in km

Louisville = zeros(length(xq5),3);
Louisville(:,1) = atan2d(yq5,xq5);% lon in degree
Louisville(:,2) = atan2d(zq5,sqrt(xq5.^2+yq5.^2));% lat in degree
Louisville(:,3) = abs((1-sqrt(xq5.^2+yq5.^2+zq5.^2))*6371);% dep in km

Reunion = zeros(length(xq6),3);
Reunion(:,1) = atan2d(yq6,xq6);% lon in degree
Reunion(:,2) = atan2d(zq6,sqrt(xq6.^2+yq6.^2));% lat in degree
Reunion(:,3) = abs((1-sqrt(xq6.^2+yq6.^2+zq6.^2))*6371);% dep in km

Hawaii = zeros(length(xq7),3);
Hawaii(:,1) = atan2d(yq7,xq7);% lon in degree
Hawaii(:,2) = atan2d(zq7,sqrt(xq7.^2+yq7.^2));% lat in degree
Hawaii(:,3) = abs((1-sqrt(xq7.^2+yq7.^2+zq7.^2))*6371);% dep in km

Samoa = zeros(length(xq8),3);
Samoa(:,1) = atan2d(yq8,xq8);% lon in degree
Samoa(:,2) = atan2d(zq8,sqrt(xq8.^2+yq8.^2));% lat in degree
Samoa(:,3) = abs((1-sqrt(xq8.^2+yq8.^2+zq8.^2))*6371);% dep in km

Tahiti = zeros(length(xq9),3);
Tahiti(:,1) = atan2d(yq9,xq9);% lon in degree
Tahiti(:,2) = atan2d(zq9,sqrt(xq9.^2+yq9.^2));% lat in degree
Tahiti(:,3) = abs((1-sqrt(xq9.^2+yq9.^2+zq9.^2))*6371);% dep in km

Mac = zeros(length(xq10),3);
Mac(:,1) = atan2d(yq10,xq10);% lon in degree
Mac(:,2) = atan2d(zq10,sqrt(xq10.^2+yq10.^2));% lat in degree
Mac(:,3) = abs((1-sqrt(xq10.^2+yq10.^2+zq10.^2))*6371);% dep in km

Pitcairn = zeros(length(xq11),3);
Pitcairn(:,1) = atan2d(yq11,xq11);% lon in degree
Pitcairn(:,2) = atan2d(zq11,sqrt(xq11.^2+yq11.^2));% lat in degree
Pitcairn(:,3) = abs((1-sqrt(xq11.^2+yq11.^2+zq11.^2))*6371);% dep in 

Gala = zeros(length(xq12),3);
Gala(:,1) = atan2d(yq12,xq12);% lon in degree
Gala(:,2) = atan2d(zq12,sqrt(xq12.^2+yq12.^2));% lat in degree
Gala(:,3) = abs((1-sqrt(xq12.^2+yq12.^2+zq12.^2))*6371);% dep in km

Marquesas = zeros(length(xq13),3);
Marquesas(:,1) = atan2d(yq13,xq13);% lon in degree
Marquesas(:,2) = atan2d(zq13,sqrt(xq13.^2+yq13.^2));% lat in degree
Marquesas(:,3) = abs((1-sqrt(xq13.^2+yq13.^2+zq13.^2))*6371);% dep in km

Kerguelen = zeros(length(xq14),3);
Kerguelen(:,1) = atan2d(yq14,xq14);% lon in degree
Kerguelen(:,2) = atan2d(zq14,sqrt(xq14.^2+yq14.^2));% lat in degree
Kerguelen(:,3) = abs((1-sqrt(xq14.^2+yq14.^2+zq14.^2))*6371);% dep in km

Caroline = zeros(length(xq15),3);
Caroline(:,1) = atan2d(yq15,xq15);% lon in degree
Caroline(:,2) = atan2d(zq15,sqrt(xq15.^2+yq15.^2));% lat in degree
Caroline(:,3) = abs((1-sqrt(xq15.^2+yq15.^2+zq15.^2))*6371);% dep in km

Juan = zeros(length(xq16),3);
Juan(:,1) = atan2d(yq16,xq16);% lon in degree
Juan(:,2) = atan2d(zq16,sqrt(xq16.^2+yq16.^2));% lat in degree
Juan(:,3) = abs((1-sqrt(xq16.^2+yq16.^2+zq16.^2))*6371);% dep in km

San_Felix = zeros(length(xq17),3);
San_Felix(:,1) = atan2d(yq17,xq17);% lon in degree
San_Felix(:,2) = atan2d(zq17,sqrt(xq17.^2+yq17.^2));% lat in degree
San_Felix(:,3) = abs((1-sqrt(xq17.^2+yq17.^2+zq17.^2))*6371);% dep in km

Marion = zeros(length(xq18),3);
Marion(:,1) = atan2d(yq18,xq18);% lon in degree
Marion(:,2) = atan2d(zq18,sqrt(xq18.^2+yq18.^2));% lat in degree
Marion(:,3) = abs((1-sqrt(xq18.^2+yq18.^2+zq18.^2))*6371);% dep in km

Meteor = zeros(length(xq19),3);
Meteor(:,1) = atan2d(yq19,xq19);% lon in degree
Meteor(:,2) = atan2d(zq19,sqrt(xq19.^2+yq19.^2));% lat in degree
Meteor(:,3) = abs((1-sqrt(xq19.^2+yq19.^2+zq19.^2))*6371);% dep in km

Vema = zeros(length(xq20),3);
Vema(:,1) = atan2d(yq20,xq20);% lon in degree
Vema(:,2) = atan2d(zq20,sqrt(xq20.^2+yq20.^2));% lat in degree
Vema(:,3) = abs((1-sqrt(xq20.^2+yq20.^2+zq20.^2))*6371);% dep in km

Trindade = zeros(length(xq21),3);
Trindade(:,1) = atan2d(yq21,xq21);% lon in degree
Trindade(:,2) = atan2d(zq21,sqrt(xq21.^2+yq21.^2));% lat in degree
Trindade(:,3) = abs((1-sqrt(xq21.^2+yq21.^2+zq21.^2))*6371);% dep in km

St_H = zeros(length(xq22),3);
St_H(:,1) = atan2d(yq22,xq22);% lon in degree
St_H(:,2) = atan2d(zq22,sqrt(xq22.^2+yq22.^2));% lat in degree
St_H(:,3) = abs((1-sqrt(xq22.^2+yq22.^2+zq22.^2))*6371);% dep in km

Cape = zeros(length(xq23),3);
Cape(:,1) = atan2d(yq23,xq23);% lon in degree
Cape(:,2) = atan2d(zq23,sqrt(xq23.^2+yq23.^2));% lat in degree
Cape(:,3) = abs((1-sqrt(xq23.^2+yq23.^2+zq23.^2))*6371);% dep in km

Canary = zeros(length(xq24),3);
Canary(:,1) = atan2d(yq24,xq24);% lon in degree
Canary(:,2) = atan2d(zq24,sqrt(xq24.^2+yq24.^2));% lat in degree
Canary(:,3) = abs((1-sqrt(xq24.^2+yq24.^2+zq24.^2))*6371);% dep in km

Azores = zeros(length(xq25),3);
Azores(:,1) = atan2d(yq25,xq25);% lon in degree
Azores(:,2) = atan2d(zq25,sqrt(xq25.^2+yq25.^2));% lat in degree
Azores(:,3) = abs((1-sqrt(xq25.^2+yq25.^2+zq25.^2))*6371);% dep in km

% JM = zeros(length(xq26),3);
% JM(:,1) = atan2d(yq26,xq26);% lon in degree
% JM(:,2) = atan2d(zq26,sqrt(xq26.^2+yq26.^2));% lat in degree
% JM(:,3) = abs((1-sqrt(xq26.^2+yq26.^2+zq26.^2))*6371);% dep in km

Hoggar = zeros(length(xq27),3);
Hoggar(:,1) = atan2d(yq27,xq27);% lon in degree
Hoggar(:,2) = atan2d(zq27,sqrt(xq27.^2+yq27.^2));% lat in degree
Hoggar(:,3) = abs((1-sqrt(xq27.^2+yq27.^2+zq27.^2))*6371);% dep in km

% Fernando = zeros(length(xq28),3);
% Fernando(:,1) = atan2d(yq28,xq28);% lon in degree
% Fernando(:,2) = atan2d(zq28,sqrt(xq28.^2+yq28.^2));% lat in degree
% Fernando(:,3) = abs((1-sqrt(xq28.^2+yq28.^2+zq28.^2))*6371);% dep in km

%%
pt = 200;
ax2 = axes;
linkaxes([ax1,ax2])
scatter(ax2,flipud(EAR(:,1)),flipud(EAR(:,2)),ones(length(xq1),1)*pt,flipud(EAR(:,3)),'.');hold on;
scatter(ax2,flipud(Easter(:,1)),flipud(Easter(:,2)),ones(length(xq2),1)*pt,flipud(Easter(:,3)),'.');hold on;
scatter(ax2,flipud(Iceland(:,1)),flipud(Iceland(:,2)),ones(length(xq3),1)*pt,flipud(Iceland(:,3)),'.');hold on;
scatter(ax2,flipud(Tristan(:,1)),flipud(Tristan(:,2)),ones(length(xq4),1)*pt,flipud(Tristan(:,3)),'.');hold on;
scatter(ax2,flipud(Louisville(:,1)),flipud(Louisville(:,2)),ones(length(xq5),1)*pt,flipud(Louisville(:,3)),'.');hold on;
scatter(ax2,flipud(Reunion(:,1)),flipud(Reunion(:,2)),ones(length(xq6),1)*pt,flipud(Reunion(:,3)),'.');hold on;
scatter(ax2,flipud(Hawaii(:,1)),flipud(Hawaii(:,2)),ones(length(xq7),1)*pt,flipud(Hawaii(:,3)),'.');hold on;
scatter(ax2,flipud(Samoa(:,1)),flipud(Samoa(:,2)),ones(length(xq8),1)*pt,flipud(Samoa(:,3)),'.');hold on;
scatter(ax2,flipud(Tahiti(:,1)),flipud(Tahiti(:,2)),ones(length(xq9),1)*pt,flipud(Tahiti(:,3)),'.');hold on;
scatter(ax2,flipud(Mac(:,1)),flipud(Mac(:,2)),ones(length(xq10),1)*pt,flipud(Mac(:,3)),'.');hold on;
scatter(ax2,flipud(Pitcairn(:,1)),flipud(Pitcairn(:,2)),ones(length(xq11),1)*pt,flipud(Pitcairn(:,3)),'.');hold on;
scatter(ax2,flipud(Gala(:,1)),flipud(Gala(:,2)),ones(length(xq12),1)*pt,flipud(Gala(:,3)),'.');hold on;
scatter(ax2,flipud(Marquesas(:,1)),flipud(Marquesas(:,2)),ones(length(xq13),1)*pt,flipud(Marquesas(:,3)),'.');hold on;
scatter(ax2,flipud(Kerguelen(:,1)),flipud(Kerguelen(:,2)),ones(length(xq14),1)*pt,flipud(Kerguelen(:,3)),'.');hold on;
scatter(ax2,flipud(Caroline(:,1)),flipud(Caroline(:,2)),ones(length(xq15),1)*pt,flipud(Caroline(:,3)),'.');hold on;
scatter(ax2,flipud(Juan(:,1)),flipud(Juan(:,2)),ones(length(xq16),1)*pt,flipud(Juan(:,3)),'.');hold on;
scatter(ax2,flipud(San_Felix(:,1)),flipud(San_Felix(:,2)),ones(length(xq17),1)*pt,flipud(San_Felix(:,3)),'.');hold on;
scatter(ax2,flipud(Marion(:,1)),flipud(Marion(:,2)),ones(length(xq18),1)*pt,flipud(Marion(:,3)),'.');hold on;
scatter(ax2,flipud(Meteor(:,1)),flipud(Meteor(:,2)),ones(length(xq19),1)*pt,flipud(Meteor(:,3)),'.');hold on;
scatter(ax2,flipud(Vema(:,1)),flipud(Vema(:,2)),ones(length(xq20),1)*pt,flipud(Vema(:,3)),'.');hold on;
scatter(ax2,flipud(Trindade(:,1)),flipud(Trindade(:,2)),ones(length(xq21),1)*pt,flipud(Trindade(:,3)),'.');hold on;
scatter(ax2,flipud(St_H(:,1)),flipud(St_H(:,2)),ones(length(xq22),1)*pt,flipud(St_H(:,3)),'.');hold on;
scatter(ax2,flipud(Cape(:,1)),flipud(Cape(:,2)),ones(length(xq23),1)*pt,flipud(Cape(:,3)),'.');hold on;
scatter(ax2,flipud(Canary(:,1)),flipud(Canary(:,2)),ones(length(xq24),1)*pt,flipud(Canary(:,3)),'.');hold on;
scatter(ax2,flipud(Azores(:,1)),flipud(Azores(:,2)),ones(length(xq25),1)*pt,flipud(Azores(:,3)),'.');hold on;
% scatter(ax2,JM(:,1),JM(:,2),ones(length(xq26),1)*pt,JM(:,3),'.');hold on;
scatter(ax2,flipud(Hoggar(:,1)),flipud(Hoggar(:,2)),ones(length(xq27),1)*pt,flipud(Hoggar(:,3)),'.');hold on;
% scatter(ax2,Fernando(:,1),Fernando(:,2),ones(length(xq28),1)*pt,Fernando(:,3),'.');hold on;

ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
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

Easter = zeros(size(f2),'like',f2);
Easter(:,1) = atan2d(f2(:,2),f2(:,1));% lon in degree
Easter(:,2) = atan2d(f2(:,3),sqrt(f2(:,1).^2+f2(:,2).^2));% lat in degree
Easter(:,3) = (1-sqrt(f2(:,1).^2+f2(:,2).^2+f2(:,3).^2))*6371;% dep in km

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