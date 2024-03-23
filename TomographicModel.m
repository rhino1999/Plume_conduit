classdef TomographicModel < handle
    properties
        depth
        lon
        lat
        vs
        evaluate
    end
    methods
        function obj = TomographicModel()
% %             tomofile = 'semucb_vtk\glad-m25-vs-0.0-n4.nc';
%             tomofile = 'semucb_vtk\glad-m25-vp-0.0-n4.nc';
%             obj.depth = ncread(tomofile,'depth');
%             obj.lat = ncread(tomofile,'latitude');
%             obj.lon = ncread(tomofile,'longitude');
% %             vsh = ncread(tomofile,'vsh');
% %             vsv = ncread(tomofile,'vsv');
%             vsh = ncread(tomofile,'vph');
%             vsv = ncread(tomofile,'vpv');
%             vs_or = sqrt(vsv.^2+vsh.^2);
%             vs_mean = zeros(1,342);
%             vs_sum = zeros(1,342);
%             obj.vs = zeros(721,361,342);
%             d_theta = deg2rad(0.5);d_phi = deg2rad(0.5);
%             for i = 1:1:342
%                 cell_vs = 0.25*(vs_or(1:end-1,1:end-1,i) + ...
%                     vs_or(2:end,1:end-1,i)+...
%                     vs_or(1:end-1,2:end,i)+...
%                     vs_or(2:end,2:end,i));
%                 lonc = (obj.lon(1:end-1)+obj.lon(2:end))/2;
%                 latc = (obj.lat(1:end-1)+obj.lat(2:end))/2;
% 
%                 cell_weight = (cosd(latc) * ones(length(lonc),1)')';
%                 vs_mean(i) = sum(sum(cell_weight .* cell_vs)) / sum(sum(cell_weight));
%                 obj.vs (:,:,i) = (vs_or(:,:,i) - vs_mean(i)) / vs_mean(i)*100; % dvs in %
%             end

%             tomofile = 'semucb_vtk\semucb-wm1.nc';
%             obj.depth = ncread(tomofile,'depth');
%             obj.lon = ncread(tomofile,'longitude');
%             obj.lat = ncread(tomofile,'latitude');
%             obj.vs = ncread(tomofile,'vsvoigt');

%             tomofile = 'semucb_vtk\TX2019slab_percent.nc';
%             obj.depth = ncread(tomofile,'depth');
%             obj.lon = ncread(tomofile,'longitude');
%             obj.lat = ncread(tomofile,'latitude');
%             obj.vs = ncread(tomofile,'dvs');
 
            tomofile = 'semucb_vtk\SPiRaL-1.4.Interpolated.Flattened-viz-only.r0.0.nc';
            obj.depth = ncread(tomofile,'depth');
            obj.lat = ncread(tomofile,'latitude');
            obj.lon = ncread(tomofile,'longitude');
            vsh = ncread(tomofile,'vsh');
            vsv = ncread(tomofile,'vsv');
%             vsh = ncread(tomofile,'vph');
%             vsv = ncread(tomofile,'vpv');
            vs_or = sqrt(vsv.^2+vsh.^2);
            vs_mean = zeros(1,48);
            vs_sum = zeros(1,48);
            obj.vs = zeros(361,181,48);
            d_theta = deg2rad(0.5);d_phi = deg2rad(0.5);
            for i = 1:1:48
                cell_vs = 0.25*(vs_or(1:end-1,1:end-1,i) + ...
                    vs_or(2:end,1:end-1,i)+...
                    vs_or(1:end-1,2:end,i)+...
                    vs_or(2:end,2:end,i));
                lonc = (obj.lon(1:end-1)+obj.lon(2:end))/2;
                latc = (obj.lat(1:end-1)+obj.lat(2:end))/2;

                cell_weight = (cosd(latc) * ones(length(lonc),1)')';
                vs_mean(i) = sum(sum(cell_weight .* cell_vs)) / sum(sum(cell_weight));
                obj.vs (:,:,i) = (vs_or(:,:,i) - vs_mean(i)) / vs_mean(i)*100; % dvs in %
            end

%             tomofile = 'semucb_vtk\UU-P07_lon_lat_depth_%dVp_cell_depth_midpoint';
%             data = readmatrix(tomofile);
%             k = zeros(29,1);
%             for i = 1:29
%                 k(i) = (i-1)*720*360+1;
%             end
%             obj.depth = data(k,3);
%             obj.lon = data(1:720,1);
%             obj.lat = linspace(-89.5,89.5,360)';
%             dvp = zeros(720,360,29);
%             for n=1:29
%                 startwith = (n-1)*720*360;
%                 dvp(:,:,n) = reshape(data((startwith+1):(startwith+720*360),4),720,360);
%                 dvp(:,:,n) = fliplr(dvp(:,:,n));
%                 dvp(:,:,n) = flipud(dvp(:,:,n));
%             end
%             obj.vs = dvp;
            
 
            [xx,yy,zz] = ndgrid(obj.lon,obj.lat,obj.depth);
            obj.evaluate = griddedInterpolant(xx,yy,zz,obj.vs);            
        end

%         function dvs = evaluate(obj,lon,lat,depth)
%             % interpolate the velocities at points given in lon,lat,depth
%             % depth must be specified in the same units as the model (km).
%             % check bounds before interpolating
%             assert(max(depth(:)) <= max(obj.depth))
%             assert(min(depth(:)) >= min(obj.depth))
%             assert(min(lon(:)) >= min(obj.lon))
%             assert(max(lon(:)) <= max(obj.lon))
%             % find nearest layer for each input depth value
%             if 0
%                 layers = zeros(size(depth));
%                 dvs = zeros(size(depth));
%                 for i=1:length(depth(:))
%                     [~,ind] = min( abs(depth(i)-obj.depth) );
%                     layers(i) = ind;
%                 end
%                 unique_layers = unique(layers);
%                 for ilayer = 1:length(unique_layers)
%                     layer = unique_layers(ilayer);
%                     mask = layers == layer;
%                     layer_dvs = squeeze(obj.vs(:,:,layer))';
%                     dvs(mask) = interp2(obj.lon,obj.lat,layer_dvs,lon(mask),lat(mask));
%                 end
%             else
%                  dvs = interp3(obj.lon,obj.lat,obj.depth,obj.vs,lon,lat,depth);
%             end
%         end
    end
end