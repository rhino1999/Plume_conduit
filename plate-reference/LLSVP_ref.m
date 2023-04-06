% draw map at different depth
addpath .\plate-reference\
% load('semucb_vtk\Glad-m25.mat');
dvs = ncread('semucb_vtk\semucb-wm1.nc','vsvoigt');
%%
x = linspace(-180,180,361);% semucb: 361, 181; glad: 721, 361
y = linspace(-90,90,181);
[xx,yy] = meshgrid(x,y);
fig1 = figure();
fig1.Position = [100 200 780 440];
ax1 = axes;
slice = dvs(:,:,65);
pcolor(ax1,xx,yy,slice');
colormap(ax1,crameri('roma'));
c1 = colorbar(ax1,'Position',[.05 .11 .0175 .815]);
c1.Label.String = 'dvs %';c1.Label.FontSize = 14;
xlim([-180 180]);ylim([-90 90]);
shading interp;
alpha(0.5)
hold on
