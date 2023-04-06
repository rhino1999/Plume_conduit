% plot plate boundaries and plate motion
addpath .\plate-reference\
% load all files
X = -180:22.5:180;
Y = -90:22.5:90;
[x1,y1,z1]=grdread2('morvel.vx.0.25.sa.grd');
[x2,y2,z2]=grdread2('morvel.vy.0.25.sa.grd');
msk = x1>180;
z1_new=[z1(:,msk) z1(:,~msk)];
z2_new=[z2(:,msk) z2(:,~msk)];
E = z1_new(1:90:end,1:90:end);
N = z2_new(1:90:end,1:90:end);
f = readmatrix('nuvel_1_plates.txt');
load shorelines.mat
%%
plate_boundaries = {};
i1 = 1;
j=1;
for i=1:length(f)
    if isnan(f(i,1))
        plate_boundaries{j} = f(i1:i-1,1:2);
        j=j+1;
        i1 = i+1;
    end
end

for i=1:length(plate_boundaries)
    thispb = plate_boundaries{i};
    mask=thispb(:,1)>180.;
    thispb(mask,1) = thispb(mask,1)-360;
    j=2;
    while j < length(thispb)
       if abs(thispb(j,1)-thispb(j-1,1)) > 180.0
           thispb = [thispb(1:j-1,:); NaN NaN; thispb(j:end,:)];
       end
       j=j+1;
    end
    plate_boundaries{i}=thispb;
end
%%
for i=1:length(plate_boundaries)
    plot(plate_boundaries{i}(:,1),plate_boundaries{i}(:,2),'k-','LineWidth',1.5)
end
hold on
quiver(X,Y,E,N,0.8,'Color',[0.5 0.5 0.5]);hold on;
plot([shorelines(:).Lon],[shorelines(:).Lat],'Color',[0.4900 0.1840 0.5600],'LineWidth',0.3);
xlim([-180 180]);ylim([-90 90]);
%%
shore = struct();
for i = 1:1866
    for j = 1:length(shorelines(i).Lon)
        if shorelines(i).Lon(j)>=0
            shore(i).lon(j) = shorelines(i).Lon(j);
        else
            shore(i).lon(j) = shorelines(i).Lon(j)+360;
        end
    end
end
shore = shore';