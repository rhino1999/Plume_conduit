clear all
%%
f1=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00000'],'FileType','text');
f2=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00063'],'FileType','text');
f3=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00115'],'FileType','text');
f4=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00139'],'FileType','text');
f5=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00173'],'FileType','text');
f6=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00209'],'FileType','text');
f7=readmatrix(['C:\Users\Rhino\output-free_surface_with_crust_test4\topography.00229'],'FileType','text');
% horizontal in km
x(:,1) = f1(:,1)/1e3;x(:,2) = f2(:,1)/1e3;x(:,3) = f3(:,1)/1e3;x(:,4) = f4(:,1)/1e3;
x(:,5) = f5(:,1)/1e3;x(:,6) = f6(:,1)/1e3;x(:,7) = f7(:,1)/1e3;
% vertical in m
y(:,1) = f1(:,3);y(:,2) = f2(:,3);y(:,3) = f3(:,3);y(:,4) = f4(:,3);y(:,5) = f5(:,3);y(:,6) = f6(:,3);y(:,7) = f7(:,3);
%%
plot(x(:,1),y(:,1),'k-');hold on;
plot(x(:,2),y(:,2));hold on;
plot(x(:,3),y(:,3));hold on;
plot(x(:,4),y(:,4));hold on;
plot(x(:,5),y(:,5));hold on;
plot(x(:,6),y(:,6));hold on;
plot(x(:,7),y(:,7),'k--');hold on;
ylim([-200 1000]);
xlabel('distance (km)')
ylabel('elevation (m)')
legend('000','063','115','139','173','209','229','Location','southoutside')
%%
f=readmatrix('C:\Users\Rhino\output-free_surface_with_crust_test3\statistics');
% # 1: Time step number
% # 2: Time (years)
% # 3: Time step size (years)
% # 4: Number of mesh cells
% # 5: Number of Stokes degrees of freedom
% # 6: Number of temperature degrees of freedom
% # 7: Iterations for temperature solver
% # 8: Iterations for Stokes solver
% # 9: Velocity iterations in Stokes preconditioner
% # 10: Schur complement iterations in Stokes preconditioner
% # 11: RMS velocity (m/year)
% # 12: Max. velocity (m/year)
% # 13: Minimum topography (m)
% # 14: Maximum topography (m)
% # 15: Pressure at top (Pa)
% # 16: Pressure at bottom (Pa)
% # 17: Visualization file name
% # 18: Surface visualization file name
topo_min=f(18:end,13);
topo_max=f(18:end,14);
time=f(18:end,2);
figure(2)
plot(time/1e6,topo_min,'B-')
hold on
plot(time/1e6,topo_max,'R-')
ylim([-200 900])
ylabel('topography (m)')
xlabel('time (Ma)')
legend('minimum','maximum')
%%
data = h5read('C:\Users\Rhino\output-free_surface_with_crust_test5\solution\solution-00001.h5','/T');
mesh = h5read('C:\Users\Rhino\output-free_surface_with_crust_test5\solution\mesh-00000.h5','/cells');
nodes = h5read('C:\Users\Rhino\output-free_surface_with_crust_test5\solution\mesh-00000.h5','/nodes');
data_end = h5read('C:\Users\Rhino\output-free_surface_with_crust_test5\solution\solution-00020.h5','/T');
%%
scatter(nodes(1,:),nodes(2,:),'.')
axis equal