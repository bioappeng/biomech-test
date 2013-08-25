%   returns the polynomial coefficients,
%   returns area under and average slope of the curve

classdef process_velocity_validation < handle & process
    methods (Static)
        function run(collector, set)
            for j=1:set.num_drops
                drop = set.get_drop(j);
                position = drop.signals('pot').data;
                s = size(position);

                Samp_rate = 1/2000;

                t = (0 : Samp_rate : ((s-1)*Samp_rate));
                imax = find(position == max(position) , 1 , 'first');
                med = median(position(1:100));
                thresh = 0.11;
                i = 1;
                while abs(position(i) - med) < thresh
                    i = i + 1;
                end
                imin = i;
                x = t(imin : imax);
                y = position(imin : imax);
%                coefs = polyfit(x,y,2);
                V_avg = (position(imax) - position(imin))/(t(imax) - t(imin));
                V = zeros(size(position));
                for i = 1 : size(position)-1
                    V(i) = (position(i+1) - position(i))/(t(i+1) - t(i));
                end
                vmax = find(V == max(V) , 1 , 'first');
                V_max = V(vmax);

%                coefs
                max_velocity(j, 1) = V_max;
            end
            collector.add_field(max_velocity, 'max_velocity')
        end
    end
end
