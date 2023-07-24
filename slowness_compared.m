indx_p = 26;
index = 1;
interpolation_depths = linspace(plumes_stn{1}.depth(1),plumes_stn{1}.depth(end),200);
times_1 = ones(1,200);
times_2 = ones(1,200);
vertical_sum = ones(1,200);
model_sum = ones(1,200);
picked_sum = ones(1,200);
for i=1:indx_p
    if i == 12 || i==2 || i==7 || i== 8 || i==9 || i==10 || i==6 || i==11 || i==4 || i==5 || i == 3 || i==22 || i==21 || i==20 || i==13
%     if i == 2 || i==7 || i== 8 || i==9 || i==10 || i==11 || i == 12 || i == 13 || i == 3 || i==22 || i==23 || i==24
        vertical_sum(1,:) = vertical_sum(1,:)+vsver(i,:);
        model_sum(1,:) = model_sum(1,:)+plume_Vs_stn(i,:);
        picked_sum(1,:) = picked_sum(1,:)+plume_Vs(i,:);
    end
end
%         times_1(1,:) = (picked_sum(1,:)-model_sum(1,:))./picked_sum(1,:);
%         times_2(1,:) = (picked_sum(1,:)-vertical_sum(1,:))./picked_sum(1,:);
        times_1(1,:) = picked_sum(1,:)./model_sum(1,:);
        times_2(1,:) = picked_sum(1,:)./vertical_sum(1,:);
%%
    plot(times_1(1,:),interpolation_depths,'Marker','diamond','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#0072BD',"LineWidth",1)
    hold on
    plot(times_2(1,:),interpolation_depths,'Marker','o','MarkerSize',2,'MarkerIndices',1:10:200,'MarkerFaceColor','#D95319',"LineWidth",1)
    ylabel('depth (km)',"FontSize",14);
xlabel('picked/model or vericcal',"FontSize",14)
legend("picked/model","picked/vertical")
set(gca,'Ydir','reverse');