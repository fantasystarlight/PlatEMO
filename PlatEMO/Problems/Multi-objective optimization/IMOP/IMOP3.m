classdef IMOP3 < PROBLEM
% <2019> <multi> <real> <expensive/none>
% Benchmark MOP with irregular Pareto front
% a1 --- 0.05 --- Parameter a1
% K  ---    5 --- Parameter K

%------------------------------- Reference --------------------------------
% Y. Tian, R. Cheng, X. Zhang, M. Li, and Y. Jin. Diversity assessment of
% multi-objective evolutionary algorithms: Performance metric and benchmark
% problems. IEEE Computational Intelligence Magazine, 2019, 14(3): 61-74.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2025 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    properties(Access = private)
        a1 = 0.05;  % Parameter a1
        K  = 5;     % Parameter K
    end
    methods
        %% Default settings of the problem
        function Setting(obj)
            [obj.a1,obj.K] = obj.ParameterSet(0.05,5);
            obj.M = 2;
            if isempty(obj.D); obj.D = 10; end
            obj.lower    = zeros(1,obj.D);
            obj.upper    = ones(1,obj.D);
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            y1 = mean(PopDec(:,1:obj.K),2).^obj.a1;
            g  = sum((PopDec(:,obj.K+1:end)-0.5).^2,2);
            PopObj(:,1) = g + (1+cos(y1*pi*10)/5-y1);
            PopObj(:,2) = g + y1;
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            x      = linspace(0,1,N)';
            R(:,1) = 1 + cos(x*pi*10)/5 - x;
            R(:,2) = x;
            R      = R(NDSort(R,1)==1,:);
        end
        %% Generate the image of Pareto front
        function R = GetPF(obj)
            x      = linspace(0,1,200)';
            R(:,1) = 1 + cos(x*pi*10)/5 - x;
            R(:,2) = x;
            R(NDSort(R,1)>1,:) = nan;
        end
    end
end