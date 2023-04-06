classdef PlumeConduit < handle
    properties
        depth
        lon
        lat
        n                
    end
    methods
        function obj = PlumeConduit(lon,lat,depth)
            % create a new plumeconduit object
            obj.lon = lon;
            obj.lat = lat;
            obj.depth = depth;
            obj.n = length(depth);
%             % sort depth 
%             [obj.depth,indx] = sort(obj.depth);
%             obj.lon = obj.lon(indx);
%             obj.lat = obj.lat(indx);
            % delete the overlap point
            [obj.depth,indx_origin,indx_new] = unique(obj.depth);
            obj.lon = obj.lon(indx_origin);
            obj.lat = obj.lat(indx_origin);
        end
        function vs = calculateVs(obj,model,depth)
            % calculate Vs along trajectory
            %             ndepth = 65;
            %             depth = linspace(min(obj.depth),max(obj.depth),ndepth);
            x = interp1(obj.depth,obj.lon,depth);
            y = interp1(obj.depth,obj.lat,depth);
            vs = model.evaluate(x,y,depth); %vs values along conduit
        end
        function [x,y] = interpolate(obj,depth)
           x = interp1(obj.depth,obj.lon,depth);
           y = interp1(obj.depth,obj.lat,depth);
        end
    end
end