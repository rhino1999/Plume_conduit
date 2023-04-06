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
%             tomofile = 'glad-m25-vs-0.0-n4.nc';
% 
%             obj.depth = ncread(tomofile,'depth');
%             obj.lat = ncread(tomofile,'latitude');
%             obj.lon = ncread(tomofile,'longitude');
%             vsh = ncread(tomofile,'vsh');
%             vsv = ncread(tomofile,'vsv');
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
            tomofile = 'semucb-wm1.nc';
            info = ncinfo(tomofile);
            obj.depth = ncread(tomofile,'depth');
            obj.lon = ncread(tomofile,'longitude');
            obj.lat = ncread(tomofile,'latitude');
            obj.vs = ncread(tomofile,'vsvoigt');

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