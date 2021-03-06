% MatthewCorrelationCoefficient - Matthew Correlation Coefficient
%   Compute the Matthew Correlation Coefficient. For additional
%   information, see:
%   http://en.wikipedia.org/wiki/Matthews_correlation_coefficient

% License to use and modify this code is granted freely without warranty to all, as long as the original author is
% referenced and attributed as such. The original author maintains the right to be solely associated with this work.
%
% Programmed and Copyright by Simone Scardapane:
% simone.scardapane@uniroma1.it

classdef MatthewCorrelationCoefficient < LossFunction & NumericalContainer
    
    methods
        
        function p = initParameters(obj, p)
        end
        
        function mcc  = compute( ~, true_values, predictions, ~ )
            
            C = confusionmat(true_values,predictions);
            
            if(numel(C) == 1)
                mcc = 1;
                return;
            end
            
            TP = C(1,1);
            FP = C(1,2);
            FN = C(2,1);
            TN = C(2,2);
            
            % If any of the terms in the denominator is 0, the limiting
            % value for the MCC is 0, which results from putting the
            % denominator equal to 1.
            denominator = sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
            if(denominator == 0)
                denominator = 1;
            end
            
            mcc = (TP*TN-FP*FN)/denominator;
            
        end
        
    end
    
    methods
        function b = isBetterThan(obj, perf)
            b = obj.getFinalizedValue() > perf.getFinalizedValue();
        end
    end
    
    methods(Static)
        
        function info = getDescription()
            info = 'Matthew Correlation Coefficient';
        end
        
        function b = isCompatible(t)
            b = t == Tasks.BC;
        end
        
    end
    
end